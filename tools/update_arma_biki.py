#!/usr/bin/env python3
"""Build a reproducible local Arma 3 documentation snapshot from BIKI.

The importer uses the MediaWiki API instead of scraping public HTML pages. It:

1. walks the Arma 3 category tree;
2. forcibly includes the complete Arma 3 command and function categories;
3. stores page revision metadata and raw wikitext;
4. renders the exact revision through MediaWiki and converts it to Markdown;
5. builds a complete Markdown snapshot and embeds it into all_arma_sqf_info.md.

The manifest makes subsequent runs incremental: unchanged revisions reuse their
cached raw and Markdown files.
"""

from __future__ import annotations

import argparse
import asyncio
import hashlib
import html
import json
import re
import sys
from dataclasses import dataclass, field
from datetime import datetime, timezone
from html.parser import HTMLParser
from pathlib import Path
from typing import Any, Iterable
from urllib.parse import quote

import httpx


DEFAULT_API_URL = "https://community.bistudio.com/wikidata/api.php"
DEFAULT_WIKI_URL = "https://community.bistudio.com/wiki"
DEFAULT_ROOT_CATEGORIES = (
    "Category:Arma 3",
    "Category:Arma 3: Scripting Commands",
    "Category:Arma 3: Functions",
)
DEFAULT_DATA_DIR = Path("docs/arma_biki")
DEFAULT_OUTPUT = Path("docs/arma_biki_complete.md")
DEFAULT_MERGED_OUTPUT = Path("docs/all_arma_sqf_info.md")
MERGED_START = "<!-- ARMA_BIKI_COMPLETE_START -->"
MERGED_END = "<!-- ARMA_BIKI_COMPLETE_END -->"
SCHEMA_VERSION = 1
ARMA_322_TITLES = {
    "attachChild",
    "BIS fnc channelNumToRadioChannelID",
    "childAttached",
    "combatPace",
    "compatibleWeapons",
    "detachChild",
    "enableFreeLook",
    "enableGunStabilization",
    "getAimDirectionAndUp",
    "getAnimationsQueue",
    "getLightInfo",
    "hiddenActions",
    "hideActions",
    "parentAttached",
    "pylonAction",
    "BIS fnc radioChannelIDToChannelNum",
    "removeWeaponItem",
    "setJointDriveAngularVelocity",
    "setJointDriveLinearVelocity",
    "setJointDriveOrientation",
    "setJointDrivePosition",
    "setTargetSize",
    "shownAction",
}


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat()


def atomic_write_text(path: Path, value: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp")
    temporary.write_text(value, encoding="utf-8")
    temporary.replace(path)


def chunks(values: list[int], size: int) -> Iterable[list[int]]:
    for index in range(0, len(values), size):
        yield values[index:index + size]


def page_url(title: str) -> str:
    return f"{DEFAULT_WIKI_URL}/{quote(title.replace(' ', '_'), safe=':_()')}"


@dataclass
class DiscoveredPage:
    pageid: int
    title: str
    member_of: set[str] = field(default_factory=set)


class BikiApi:
    def __init__(
        self,
        client: httpx.AsyncClient,
        concurrency: int,
        retries: int,
    ) -> None:
        self._client = client
        self._semaphore = asyncio.Semaphore(concurrency)
        self._retries = retries

    async def query(self, params: dict[str, str]) -> dict[str, Any]:
        request_params = {
            "format": "json",
            "formatversion": "2",
            "maxlag": "5",
            **params,
        }

        async with self._semaphore:
            for attempt in range(self._retries + 1):
                try:
                    response = await self._client.get(DEFAULT_API_URL, params=request_params)
                    if response.status_code == 429 or response.status_code >= 500:
                        raise httpx.HTTPStatusError(
                            f"retryable HTTP status {response.status_code}",
                            request=response.request,
                            response=response,
                        )
                    response.raise_for_status()
                    payload = response.json()
                    error = payload.get("error")
                    if error:
                        if error.get("code") == "maxlag":
                            raise RuntimeError(f"BIKI maxlag: {error.get('info', '')}")
                        raise RuntimeError(f"BIKI API error: {error}")
                    return payload
                except (httpx.HTTPError, ValueError, RuntimeError) as exc:
                    if attempt >= self._retries:
                        raise RuntimeError(f"BIKI request failed after retries: {params}; last error: {exc}") from exc
                    await asyncio.sleep(min(8.0, 0.5 * (2 ** attempt)))

        raise AssertionError("unreachable")

    async def category_members(self, category: str) -> list[dict[str, Any]]:
        members: list[dict[str, Any]] = []
        continuation = ""

        while True:
            params = {
                "action": "query",
                "list": "categorymembers",
                "cmtitle": category,
                "cmnamespace": "0|14",
                "cmlimit": "max",
            }
            if continuation:
                params["cmcontinue"] = continuation

            payload = await self.query(params)
            members.extend(payload.get("query", {}).get("categorymembers", []))
            continuation = payload.get("continue", {}).get("cmcontinue", "")
            if not continuation:
                return members

    async def revision_metadata(self, pageids: list[int]) -> dict[int, dict[str, Any]]:
        payload = await self.query(
            {
                "action": "query",
                "prop": "revisions",
                "pageids": "|".join(str(pageid) for pageid in pageids),
                "rvprop": "ids|timestamp",
            }
        )

        result: dict[int, dict[str, Any]] = {}
        for page in payload.get("query", {}).get("pages", []):
            revisions = page.get("revisions") or []
            if not revisions:
                continue
            revision = revisions[0]
            result[int(page["pageid"])] = {
                "title": page["title"],
                "revid": int(revision["revid"]),
                "timestamp": revision["timestamp"],
            }
        return result

    async def raw_revisions(self, pageids: list[int]) -> dict[int, str]:
        payload = await self.query(
            {
                "action": "query",
                "prop": "revisions",
                "pageids": "|".join(str(pageid) for pageid in pageids),
                "rvprop": "content",
                "rvslots": "main",
            }
        )

        result: dict[int, str] = {}
        for page in payload.get("query", {}).get("pages", []):
            revisions = page.get("revisions") or []
            if not revisions:
                continue
            slot = revisions[0].get("slots", {}).get("main", {})
            content = slot.get("content")
            if isinstance(content, str):
                result[int(page["pageid"])] = content
        return result

    async def rendered_revision(self, revid: int) -> str:
        payload = await self.query(
            {
                "action": "parse",
                "oldid": str(revid),
                "prop": "text",
                "disableeditsection": "1",
                "disabletoc": "1",
            }
        )
        rendered = payload.get("parse", {}).get("text")
        if not isinstance(rendered, str):
            raise RuntimeError(f"No rendered HTML returned for revision {revid}")
        return rendered


class BikiHtmlToMarkdown(HTMLParser):
    """Small dependency-free converter tuned for rendered BIKI article HTML."""

    _SKIP_CLASSES = {
        "mw-editsection",
        "toc",
        "toc-side",
        "catlinks",
        "printfooter",
        "mw-jump-link",
    }

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self._parts: list[str] = []
        self._skip_depth = 0
        self._pre_depth = 0
        self._list_stack: list[str] = []
        self._in_cell = False
        self._cell_is_header = False

    @staticmethod
    def _attrs(attrs: list[tuple[str, str | None]]) -> dict[str, str]:
        return {key.lower(): (value or "") for key, value in attrs}

    def _append(self, value: str) -> None:
        if value:
            self._parts.append(value)

    def _newline(self, count: int = 1) -> None:
        current = "".join(self._parts[-3:])
        existing = len(current) - len(current.rstrip("\n"))
        if existing < count:
            self._parts.append("\n" * (count - existing))

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        tag = tag.lower()
        attrs_map = self._attrs(attrs)
        classes = set(attrs_map.get("class", "").split())

        if self._skip_depth:
            self._skip_depth += 1
            return
        if tag in {"script", "style", "noscript"} or classes & self._SKIP_CLASSES:
            self._skip_depth = 1
            return

        if tag == "pre":
            self._newline(2)
            language = "sqf" if "sqf" in attrs_map.get("class", "").lower() else ""
            self._append(f"```{language}\n")
            self._pre_depth += 1
        elif tag == "code" and not self._pre_depth:
            self._append("`")
        elif tag in {"strong", "b"}:
            self._append("**")
        elif tag in {"em", "i"}:
            self._append("*")
        elif tag == "br":
            self._newline()
        elif tag in {"p", "section", "article"}:
            self._newline(2)
        elif tag in {"h1", "h2", "h3", "h4", "h5", "h6"}:
            self._newline(2)
            source_level = int(tag[1])
            level = min(6, source_level + 1)
            self._append("#" * level + " ")
        elif tag in {"ul", "ol"}:
            self._list_stack.append(tag)
            self._newline()
        elif tag == "li":
            self._newline()
            indent = "  " * max(0, len(self._list_stack) - 1)
            marker = "1. " if self._list_stack and self._list_stack[-1] == "ol" else "- "
            self._append(indent + marker)
        elif tag == "blockquote":
            self._newline(2)
            self._append("> ")
        elif tag == "table":
            self._newline(2)
        elif tag == "tr":
            self._newline()
            self._append("| ")
        elif tag in {"th", "td"}:
            self._in_cell = True
            self._cell_is_header = tag == "th"
        elif tag == "img":
            alt = attrs_map.get("alt", "").strip()
            if alt and alt.lower() not in {"checked", "unchecked"}:
                self._append(f"[{alt}]")

    def handle_endtag(self, tag: str) -> None:
        tag = tag.lower()
        if self._skip_depth:
            self._skip_depth -= 1
            return

        if tag == "pre" and self._pre_depth:
            self._pre_depth -= 1
            self._newline()
            self._append("```")
            self._newline(2)
        elif tag == "code" and not self._pre_depth:
            self._append("`")
        elif tag in {"strong", "b"}:
            self._append("**")
        elif tag in {"em", "i"}:
            self._append("*")
        elif tag in {"p", "section", "article"}:
            self._newline(2)
        elif tag in {"h1", "h2", "h3", "h4", "h5", "h6"}:
            self._newline(2)
        elif tag in {"ul", "ol"}:
            if self._list_stack:
                self._list_stack.pop()
            self._newline()
        elif tag == "li":
            self._newline()
        elif tag == "blockquote":
            self._newline(2)
        elif tag in {"th", "td"}:
            self._append(" | ")
            self._in_cell = False
            self._cell_is_header = False
        elif tag == "tr":
            self._newline()
        elif tag == "table":
            self._newline(2)

    def handle_data(self, data: str) -> None:
        if self._skip_depth or not data:
            return
        if self._pre_depth:
            self._append(data)
            return

        value = re.sub(r"\s+", " ", data)
        if not value.strip():
            if self._parts and not self._parts[-1].endswith((" ", "\n")):
                self._append(" ")
            return

        if self._parts and not self._parts[-1].endswith((" ", "\n", "`", "*")):
            self._append(" ")
        self._append(value.strip())

    def markdown(self) -> str:
        value = html.unescape("".join(self._parts))
        value = re.sub(r"\[(?:edit|edit source)\]", "", value, flags=re.IGNORECASE)
        value = re.sub(r"[ \t]+\n", "\n", value)
        value = re.sub(r"\n[ \t]+", "\n", value)
        value = re.sub(r"[ \t]{2,}", " ", value)
        value = re.sub(r"\n{3,}", "\n\n", value)
        value = re.sub(r" \| \n", " |\n", value)
        return value.strip()


def html_to_markdown(source_html: str) -> str:
    parser = BikiHtmlToMarkdown()
    parser.feed(source_html)
    parser.close()
    return parser.markdown()


def fallback_markdown(wikitext: str) -> str:
    return "Rendered HTML was unavailable; raw BIKI source follows.\n\n```mediawiki\n" + wikitext.rstrip() + "\n```"


def split_template_arguments(source: str) -> list[str]:
    """Split a MediaWiki template body on top-level pipes."""
    parts: list[str] = []
    current: list[str] = []
    brace_depth = 0
    link_depth = 0
    index = 0

    while index < len(source):
        pair = source[index:index + 2]
        if pair == "{{":
            brace_depth += 1
            current.append(pair)
            index += 2
            continue
        if pair == "}}" and brace_depth:
            brace_depth -= 1
            current.append(pair)
            index += 2
            continue
        if pair == "[[":
            link_depth += 1
            current.append(pair)
            index += 2
            continue
        if pair == "]]" and link_depth:
            link_depth -= 1
            current.append(pair)
            index += 2
            continue
        if source[index] == "|" and brace_depth == 0 and link_depth == 0:
            parts.append("".join(current))
            current = []
            index += 1
            continue
        current.append(source[index])
        index += 1

    parts.append("".join(current))
    return parts


def replace_simple_templates(value: str) -> str:
    previous = ""
    while value != previous:
        previous = value
        value = re.sub(
            r"\{\{(?:Link|link)\|([^{}|]+)\|([^{}]+)\}\}",
            lambda match: f"[{match.group(2).strip()}]({match.group(1).strip()})",
            value,
        )
        value = re.sub(
            r"\{\{(?:Feature|feature)\|[^{}|]+\|([^{}]+)\}\}",
            lambda match: match.group(1).strip(),
            value,
        )
        value = re.sub(
            r"\{\{ArgTitle\|\d+\|([^{}|]+)(?:\|([^{}|]+))?\}\}",
            lambda match: "\n== "
            + match.group(1).strip()
            + (f" ({match.group(2).strip()})" if match.group(2) else "")
            + " ==\n",
            value,
            flags=re.IGNORECASE,
        )
        value = re.sub(
            r"\{\{(?:hl|Inline code)\|([^{}]+)\}\}",
            lambda match: f"`{match.group(1).strip()}`",
            value,
            flags=re.IGNORECASE,
        )
        value = re.sub(r"\{\{arma3\}\}", "Arma 3", value, flags=re.IGNORECASE)
        value = re.sub(
            r"\{\{Link\|([^{}|]+)\}\}",
            lambda match: match.group(1).strip(),
            value,
            flags=re.IGNORECASE,
        )
        value = re.sub(
            r"\{\{Name\|([^{}|]+)(?:\|[^{}]*)?\}\}",
            lambda match: match.group(1).strip(),
            value,
            flags=re.IGNORECASE,
        )
        value = re.sub(
            r"\{\{Icon\|(checked|unchecked)\}\}",
            lambda match: "yes" if match.group(1).lower() == "checked" else "no",
            value,
            flags=re.IGNORECASE,
        )
        value = re.sub(
            r"\{\{GVI\|arma3\|([^{}|]+)(?:\|[^{}]*)?\}\}",
            lambda match: match.group(1).strip(),
            value,
            flags=re.IGNORECASE,
        )
        value = re.sub(r"\{\{Wiki\|WIP\}\}", "Work in progress.", value, flags=re.IGNORECASE)
    return value


def convert_wiki_inline(value: str) -> str:
    value = re.sub(r"<!--.*?-->", "", value, flags=re.DOTALL)
    value = re.sub(
        r"<sqf(?:\s+[^>]*)?>(.*?)</sqf>",
        lambda match: "\n\n```sqf\n" + html.unescape(match.group(1).strip()) + "\n```\n\n",
        value,
        flags=re.IGNORECASE | re.DOTALL,
    )
    value = re.sub(
        r"<(?:syntaxhighlight|source)(?:\s+[^>]*)?>(.*?)</(?:syntaxhighlight|source)>",
        lambda match: "\n\n```\n" + html.unescape(match.group(1).strip()) + "\n```\n\n",
        value,
        flags=re.IGNORECASE | re.DOTALL,
    )
    value = replace_simple_templates(value)
    value = re.sub(
        r"\[\[([^\]|]+)\|([^\]]+)\]\]",
        lambda match: match.group(2).strip(),
        value,
    )
    value = re.sub(r"\[\[([^\]]+)\]\]", lambda match: match.group(1).strip(), value)
    value = re.sub(r"<br\s*/?>", "\n", value, flags=re.IGNORECASE)
    value = re.sub(r"<nowiki>(.*?)</nowiki>", lambda match: match.group(1), value, flags=re.I | re.S)
    value = re.sub(
        r"</?(?:a|b|big|blockquote|caption|center|dd|div|dl|dt|font|gallery|hr|i|kbd|li|math|ol|p|poem|ref|references|section|small|span|spoiler|strong|sub|sup|table|tbody|td|tfoot|th|thead|tr|u|ul|var)(?:\s+[^>]*)?/?>",
        "",
        value,
        flags=re.IGNORECASE,
    )
    value = html.unescape(value)
    value = re.sub(r"'''(.*?)'''", r"**\1**", value, flags=re.DOTALL)
    value = re.sub(r"''(.*?)''", r"*\1*", value, flags=re.DOTALL)
    value = re.sub(r"\n{3,}", "\n\n", value)
    return value.strip()


def parse_rv_template(wikitext: str) -> dict[str, str] | None:
    stripped = wikitext.strip()
    if not stripped.lower().startswith("{{rv|") or not stripped.endswith("}}"):
        return None

    protected: dict[str, str] = {}

    def protect(match: re.Match[str]) -> str:
        token = f"\x00ARMA_BIKI_BLOCK_{len(protected)}\x00"
        protected[token] = match.group(0)
        return token

    body = re.sub(
        r"<(sqf|syntaxhighlight|source|pre|nowiki)(?:\s+[^>]*)?>.*?</\1>",
        protect,
        stripped[5:-2],
        flags=re.IGNORECASE | re.DOTALL,
    )
    fields: dict[str, str] = {}
    for argument in split_template_arguments(body):
        if "=" not in argument:
            continue
        key, value = argument.split("=", 1)
        key = key.strip()
        if key:
            for token, original in protected.items():
                value = value.replace(token, original)
            fields[key] = value.strip()
    return fields


def rv_to_markdown(fields: dict[str, str]) -> str:
    lines: list[str] = []
    versions: list[str] = []
    for index in range(1, 10):
        game = fields.get(f"game{index}", "").strip()
        version = fields.get(f"version{index}", "").strip()
        if game or version:
            versions.append(" ".join(part for part in (game, version) if part))
    if versions:
        lines.append(f"- Availability: {', '.join(versions)}")

    locality = []
    if fields.get("arg", "").strip():
        locality.append(f"argument {fields['arg'].strip()}")
    if fields.get("eff", "").strip():
        locality.append(f"effect {fields['eff'].strip()}")
    if fields.get("serverExec", "").strip():
        locality.append(f"server execution {fields['serverExec'].strip()}")
    if locality:
        lines.append(f"- Locality: {', '.join(locality)}")

    groups = [fields[key].strip() for key in sorted(fields) if re.fullmatch(r"gr\d+", key) and fields[key].strip()]
    if groups:
        lines.append(f"- Groups: {', '.join(groups)}")

    description = convert_wiki_inline(fields.get("descr", ""))
    if description:
        lines.extend(["", "### Description", "", description])
    multiplayer = convert_wiki_inline(fields.get("mp", ""))
    if multiplayer:
        lines.extend(["", "### Multiplayer", "", multiplayer])

    syntax_keys = sorted(
        (key for key in fields if re.fullmatch(r"s\d+", key)),
        key=lambda key: int(key[1:]),
    )
    if syntax_keys:
        lines.extend(["", "### Syntax", ""])
        for key in syntax_keys:
            value = convert_wiki_inline(fields[key])
            if value:
                lines.extend([f"```sqf\n{value}\n```", ""])

    parameter_keys = sorted(
        (key for key in fields if re.fullmatch(r"p\d+", key)),
        key=lambda key: int(key[1:]),
    )
    if parameter_keys:
        lines.extend(["### Parameters", ""])
        for key in parameter_keys:
            value = convert_wiki_inline(fields[key])
            if value:
                lines.append(f"- {value}")

    return_keys = sorted(
        (key for key in fields if re.fullmatch(r"r\d+", key)),
        key=lambda key: int(key[1:]),
    )
    if return_keys:
        lines.extend(["", "### Return Value", ""])
        for key in return_keys:
            value = convert_wiki_inline(fields[key])
            if value:
                lines.append(f"- {value}")

    example_keys = sorted(
        (key for key in fields if re.fullmatch(r"x\d+", key)),
        key=lambda key: int(key[1:]),
    )
    if example_keys:
        lines.extend(["", "### Examples", ""])
        for index, key in enumerate(example_keys, start=1):
            value = convert_wiki_inline(fields[key])
            if value:
                lines.extend([f"#### Example {index}", "", value, ""])

    see_also = convert_wiki_inline(fields.get("seealso", ""))
    if see_also:
        lines.extend(["### See Also", "", see_also, ""])
    notes = convert_wiki_inline(fields.get("notes", ""))
    if notes:
        lines.extend(["### Notes", "", notes, ""])

    return "\n".join(lines).strip()


def generic_wikitext_to_markdown(wikitext: str) -> str:
    value = convert_wiki_inline(wikitext)
    lines: list[str] = []
    table_depth = 0

    for raw_line in value.splitlines():
        line = raw_line.rstrip()
        if line.startswith("{|"):
            if table_depth == 0:
                lines.append("```mediawiki-table")
            table_depth += 1
            lines.append(line)
            continue
        if table_depth:
            lines.append(line)
            if line.startswith("|}"):
                table_depth -= 1
                if table_depth == 0:
                    lines.append("```")
            continue

        heading = re.fullmatch(r"(={2,6})\s*(.*?)\s*\1", line)
        if heading:
            level = min(6, len(heading.group(1)) + 1)
            lines.append("#" * level + " " + heading.group(2).strip())
            continue

        bullet = re.match(r"^(\*+)\s+(.*)$", line)
        if bullet:
            lines.append("  " * (len(bullet.group(1)) - 1) + "- " + bullet.group(2))
            continue
        ordered = re.match(r"^(#+)\s+(.*)$", line)
        if ordered:
            lines.append("  " * (len(ordered.group(1)) - 1) + "1. " + ordered.group(2))
            continue
        definition = re.match(r"^[;:]\s*(.*)$", line)
        if definition:
            lines.append("- " + definition.group(1))
            continue
        lines.append(line)

    if table_depth:
        lines.append("```")
    result = "\n".join(lines)
    result = re.sub(r"\n{3,}", "\n\n", result)
    return result.strip()


def wikitext_to_markdown(wikitext: str) -> str:
    fields = parse_rv_template(wikitext)
    if fields is not None:
        rendered = rv_to_markdown(fields)
        if rendered:
            return rendered
    rendered = generic_wikitext_to_markdown(wikitext)
    return rendered if rendered else fallback_markdown(wikitext)


def article_markdown(
    title: str,
    revid: int,
    timestamp: str,
    body: str,
) -> str:
    return "\n".join(
        [
            f"## {title}",
            "",
            f"- Source: {page_url(title)}",
            f"- Revision: {revid}",
            f"- Updated: {timestamp}",
            "",
            body.strip(),
            "",
        ]
    )


async def discover_pages(
    api: BikiApi,
    roots: tuple[str, ...],
    workers: int,
) -> tuple[dict[int, DiscoveredPage], list[str]]:
    queue: asyncio.Queue[str] = asyncio.Queue()
    scheduled = set(roots)
    visited: set[str] = set()
    pages: dict[int, DiscoveredPage] = {}

    for root in roots:
        queue.put_nowait(root)

    async def worker() -> None:
        while True:
            category = await queue.get()
            try:
                members = await api.category_members(category)
                visited.add(category)
                for member in members:
                    namespace = int(member.get("ns", -1))
                    title = str(member.get("title", ""))
                    pageid = int(member.get("pageid", 0))
                    if namespace == 0 and pageid:
                        page = pages.setdefault(pageid, DiscoveredPage(pageid=pageid, title=title))
                        page.title = title
                        page.member_of.add(category)
                    elif namespace == 14 and title and title not in scheduled:
                        scheduled.add(title)
                        queue.put_nowait(title)
            finally:
                queue.task_done()

    tasks = [asyncio.create_task(worker()) for _ in range(workers)]
    await queue.join()
    for task in tasks:
        task.cancel()
    await asyncio.gather(*tasks, return_exceptions=True)
    return pages, sorted(visited, key=str.casefold)


async def fetch_metadata(api: BikiApi, pageids: list[int], batch_size: int) -> dict[int, dict[str, Any]]:
    batches = list(chunks(pageids, batch_size))
    results = await asyncio.gather(*(api.revision_metadata(batch) for batch in batches))
    merged: dict[int, dict[str, Any]] = {}
    for result in results:
        merged.update(result)
    return merged


async def fetch_raw(api: BikiApi, pageids: list[int], batch_size: int) -> dict[int, str]:
    batches = list(chunks(pageids, batch_size))
    results = await asyncio.gather(*(api.raw_revisions(batch) for batch in batches))
    merged: dict[int, str] = {}
    for result in results:
        merged.update(result)
    return merged


async def render_changed_pages(
    api: BikiApi,
    changed: list[int],
    metadata: dict[int, dict[str, Any]],
    raw_content: dict[int, str],
    pages_dir: Path,
    render_mode: str,
) -> dict[int, str]:
    errors: dict[int, str] = {}
    completed = 0
    total = len(changed)
    progress_lock = asyncio.Lock()

    async def render(pageid: int) -> None:
        nonlocal completed
        page_metadata = metadata[pageid]
        revid = int(page_metadata["revid"])
        if render_mode == "api":
            try:
                rendered_html = await api.rendered_revision(revid)
                body = html_to_markdown(rendered_html)
                if not body:
                    raise RuntimeError("rendered Markdown is empty")
            except Exception as exc:  # raw content still guarantees a complete dump
                errors[pageid] = str(exc)
                body = wikitext_to_markdown(raw_content[pageid])
        else:
            body = wikitext_to_markdown(raw_content[pageid])

        value = article_markdown(
            title=page_metadata["title"],
            revid=revid,
            timestamp=page_metadata["timestamp"],
            body=body,
        )
        atomic_write_text(pages_dir / f"{pageid}.md", value)

        async with progress_lock:
            completed += 1
            if completed == total or completed % 50 == 0:
                print(f"Rendered {completed}/{total} changed pages", flush=True)

    await asyncio.gather(*(render(pageid) for pageid in changed))
    return errors


def load_manifest(path: Path) -> dict[str, Any]:
    if not path.exists():
        return {}
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}


def build_complete_snapshot(
    output: Path,
    manifest: dict[str, Any],
    pages_dir: Path,
) -> None:
    page_entries = sorted(manifest["pages"].values(), key=lambda item: item["title"].casefold())
    lines = [
        "# Complete Arma 3 BIKI Snapshot",
        "",
        f"- Source API: {manifest['source_api']}",
        f"- Generated: {manifest['generated_utc']}",
        f"- Root categories: {', '.join(manifest['root_categories'])}",
        f"- Categories traversed: {manifest['category_count']}",
        f"- Articles: {manifest['page_count']}",
        "- Content: normalized article text plus per-page source revision metadata",
        "",
    ]

    for entry in page_entries:
        article_path = pages_dir / f"{entry['pageid']}.md"
        lines.append(article_path.read_text(encoding="utf-8").rstrip())
        lines.extend(["", "---", ""])

    atomic_write_text(output, "\n".join(lines).rstrip() + "\n")


def merge_snapshot(target: Path, snapshot_path: Path) -> None:
    legacy = target.read_text(encoding="utf-8") if target.exists() else ""
    snapshot = snapshot_path.read_text(encoding="utf-8").rstrip()
    managed = f"{MERGED_START}\n\n{snapshot}\n\n{MERGED_END}"

    if MERGED_START in legacy and MERGED_END in legacy:
        prefix, remainder = legacy.split(MERGED_START, 1)
        _old, suffix = remainder.split(MERGED_END, 1)
        merged = prefix.rstrip() + "\n\n" + managed + suffix
    else:
        merged = legacy.rstrip() + "\n\n" + managed + "\n"

    atomic_write_text(target, merged)


def verify_generated_snapshot(
    manifest_path: Path,
    snapshot_path: Path,
    merged_path: Path | None,
) -> None:
    manifest = load_manifest(manifest_path)
    pages = manifest.get("pages", {})
    expected_count = int(manifest.get("page_count", -1))
    errors: list[str] = []

    if manifest.get("schema_version") != SCHEMA_VERSION:
        errors.append("manifest schema version mismatch")
    if expected_count != len(pages):
        errors.append(f"manifest page_count={expected_count}, entries={len(pages)}")
    if int(manifest.get("category_count", -1)) != len(manifest.get("categories", [])):
        errors.append("manifest category count mismatch")

    titles: set[str] = set()
    for key, entry in pages.items():
        pageid = int(entry.get("pageid", -1))
        title = str(entry.get("title", ""))
        if key != str(pageid):
            errors.append(f"manifest key/pageid mismatch: {key}/{pageid}")
        if not title:
            errors.append(f"page {pageid} has no title")
        elif title in titles:
            errors.append(f"duplicate title: {title}")
        titles.add(title)

        raw_path = Path(entry.get("raw_path", ""))
        markdown_path = Path(entry.get("markdown_path", ""))
        if not raw_path.is_file():
            errors.append(f"missing raw page: {pageid}")
            continue
        if not markdown_path.is_file():
            errors.append(f"missing Markdown page: {pageid}")
            continue

        raw_hash = hashlib.sha256(raw_path.read_bytes()).hexdigest()
        if raw_hash != entry.get("raw_sha256"):
            errors.append(f"raw hash mismatch: {pageid}")

        markdown = markdown_path.read_text(encoding="utf-8")
        if not markdown.startswith(f"## {title}\n"):
            errors.append(f"Markdown title mismatch: {pageid}")
        fence_count = sum(1 for line in markdown.splitlines() if line.startswith("```"))
        if fence_count % 2:
            errors.append(f"unbalanced Markdown fence: {pageid}")
        if entry.get("render_error"):
            errors.append(f"render fallback recorded: {pageid}")

    missing_222 = sorted(ARMA_322_TITLES - titles, key=str.casefold)
    if missing_222:
        errors.append(f"missing Arma 3 2.22 pages: {missing_222}")

    command_count = sum(
        "Category:Arma 3: Scripting Commands" in entry.get("member_of", [])
        for entry in pages.values()
    )
    function_count = sum(
        "Category:Arma 3: Functions" in entry.get("member_of", [])
        for entry in pages.values()
    )
    if command_count == 0 or function_count == 0:
        errors.append("command or function root category is empty")

    if not snapshot_path.is_file():
        errors.append(f"missing complete snapshot: {snapshot_path}")
        snapshot = ""
    else:
        snapshot = snapshot_path.read_text(encoding="utf-8")
        snapshot_titles = {
            line[3:]
            for line in snapshot.splitlines()
            if line.startswith("## ")
        }
        missing_snapshot_titles = sorted(titles - snapshot_titles, key=str.casefold)
        extra_snapshot_titles = sorted(snapshot_titles - titles, key=str.casefold)
        if missing_snapshot_titles:
            errors.append(f"snapshot is missing articles: {missing_snapshot_titles[:20]}")
        if extra_snapshot_titles:
            errors.append(f"snapshot has unexpected article headings: {extra_snapshot_titles[:20]}")

    if merged_path is not None:
        if not merged_path.is_file():
            errors.append(f"missing merged output: {merged_path}")
        else:
            merged = merged_path.read_text(encoding="utf-8")
            if merged.count(MERGED_START) != 1 or merged.count(MERGED_END) != 1:
                errors.append("merged output has invalid managed markers")
            elif snapshot and f"{MERGED_START}\n\n{snapshot.rstrip()}\n\n{MERGED_END}" not in merged:
                errors.append("merged output does not contain the exact complete snapshot")

    if errors:
        preview = "\n- ".join(errors[:50])
        raise RuntimeError(f"Generated snapshot verification failed:\n- {preview}")

    print(
        f"Verified {expected_count} articles: {command_count} commands, "
        f"{function_count} functions, {len(ARMA_322_TITLES)} Arma 3 2.22 pages",
        flush=True,
    )


async def run(args: argparse.Namespace) -> int:
    roots = tuple(args.category) if args.category else DEFAULT_ROOT_CATEGORIES
    headers = {"User-Agent": args.user_agent}
    limits = httpx.Limits(
        max_connections=args.concurrency,
        max_keepalive_connections=args.concurrency,
    )

    async with httpx.AsyncClient(
        headers=headers,
        timeout=args.timeout,
        follow_redirects=True,
        limits=limits,
        http2=True,
    ) as client:
        api = BikiApi(client, args.concurrency, args.retries)
        print(f"Discovering category tree from: {', '.join(roots)}", flush=True)
        discovered, categories = await discover_pages(api, roots, args.concurrency)
        ordered_discovered = sorted(discovered.values(), key=lambda item: item.title.casefold())
        if args.max_pages:
            ordered_discovered = ordered_discovered[:args.max_pages]
            discovered = {page.pageid: page for page in ordered_discovered}

        print(
            f"Discovered {len(discovered)} main-namespace articles in {len(categories)} categories",
            flush=True,
        )
        if args.discover_only:
            return 0

        data_dir = Path(args.data_dir)
        raw_dir = data_dir / "raw"
        pages_dir = data_dir / "pages"
        manifest_path = data_dir / "manifest.json"
        raw_dir.mkdir(parents=True, exist_ok=True)
        pages_dir.mkdir(parents=True, exist_ok=True)

        pageids = sorted(discovered)
        metadata = await fetch_metadata(api, pageids, args.batch_size)
        missing_metadata = sorted(set(pageids) - set(metadata))
        if missing_metadata:
            raise RuntimeError(f"Missing revision metadata for page IDs: {missing_metadata[:20]}")

        old_manifest = load_manifest(manifest_path)
        old_pages = old_manifest.get("pages", {})
        raw_needed: list[int] = []
        changed: list[int] = []
        for pageid in pageids:
            old = old_pages.get(str(pageid), {})
            raw_path = raw_dir / f"{pageid}.wiki"
            markdown_path = pages_dir / f"{pageid}.md"
            source_changed = (
                args.force
                or int(old.get("revid", -1)) != int(metadata[pageid]["revid"])
                or not raw_path.exists()
            )
            if source_changed:
                raw_needed.append(pageid)
            if source_changed or args.rerender or not markdown_path.exists():
                changed.append(pageid)

        print(
            f"Source revisions to download: {len(raw_needed)}; "
            f"cached sources: {len(pageids) - len(raw_needed)}; "
            f"pages to render: {len(changed)}",
            flush=True,
        )
        raw_content = await fetch_raw(api, raw_needed, args.batch_size) if raw_needed else {}
        missing_raw = sorted(set(raw_needed) - set(raw_content))
        if missing_raw:
            raise RuntimeError(f"Missing raw content for page IDs: {missing_raw[:20]}")

        for pageid, content in raw_content.items():
            atomic_write_text(raw_dir / f"{pageid}.wiki", content)

        for pageid in changed:
            if pageid not in raw_content:
                raw_content[pageid] = (raw_dir / f"{pageid}.wiki").read_text(encoding="utf-8")

        render_errors = await render_changed_pages(
            api,
            changed,
            metadata,
            raw_content,
            pages_dir,
            args.render_mode,
        )

    manifest_pages: dict[str, Any] = {}
    for pageid in pageids:
        raw_path = raw_dir / f"{pageid}.wiki"
        markdown_path = pages_dir / f"{pageid}.md"
        raw_value = raw_path.read_bytes()
        entry = {
            "pageid": pageid,
            "title": metadata[pageid]["title"],
            "revid": metadata[pageid]["revid"],
            "timestamp": metadata[pageid]["timestamp"],
            "source": page_url(metadata[pageid]["title"]),
            "member_of": sorted(discovered[pageid].member_of, key=str.casefold),
            "raw_path": raw_path.as_posix(),
            "markdown_path": markdown_path.as_posix(),
            "raw_sha256": hashlib.sha256(raw_value).hexdigest(),
        }
        if pageid in render_errors:
            entry["render_error"] = render_errors[pageid]
        manifest_pages[str(pageid)] = entry

    manifest = {
        "schema_version": SCHEMA_VERSION,
        "source_api": DEFAULT_API_URL,
        "generated_utc": utc_now(),
        "root_categories": list(roots),
        "category_count": len(categories),
        "categories": categories,
        "page_count": len(pageids),
        "changed_count": len(changed),
        "downloaded_count": len(raw_needed),
        "render_mode": args.render_mode,
        "render_fallback_count": len(render_errors),
        "pages": manifest_pages,
    }
    atomic_write_text(manifest_path, json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")

    output = Path(args.output)
    build_complete_snapshot(output, manifest, pages_dir)
    merged_output = None
    if not args.no_merge:
        merged_output = Path(args.merged_output)
        merge_snapshot(merged_output, output)

    verify_generated_snapshot(manifest_path, output, merged_output)

    print(
        f"Snapshot complete: {len(pageids)} articles, {len(categories)} categories, "
        f"{len(render_errors)} render fallbacks",
        flush=True,
    )
    print(f"Manifest: {manifest_path}", flush=True)
    print(f"Snapshot: {output}", flush=True)
    if not args.no_merge:
        print(f"Merged output: {args.merged_output}", flush=True)
    return 0


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Dump the complete Arma 3 BIKI category tree to Markdown.")
    parser.add_argument("--category", action="append", help="Root category; repeatable (defaults to Arma 3 roots)")
    parser.add_argument("--data-dir", default=str(DEFAULT_DATA_DIR), help="Raw/page cache and manifest directory")
    parser.add_argument("--output", default=str(DEFAULT_OUTPUT), help="Complete generated Markdown snapshot")
    parser.add_argument("--merged-output", default=str(DEFAULT_MERGED_OUTPUT), help="Legacy Markdown file to extend")
    parser.add_argument("--no-merge", action="store_true", help="Do not update the merged legacy Markdown file")
    parser.add_argument("--discover-only", action="store_true", help="Only traverse categories and print counts")
    parser.add_argument("--max-pages", type=int, default=0, help="Limit pages after discovery (for tests only)")
    parser.add_argument("--force", action="store_true", help="Redownload and rerender unchanged revisions")
    parser.add_argument("--rerender", action="store_true", help="Regenerate Markdown from cached raw revisions")
    parser.add_argument(
        "--render-mode",
        choices=("raw", "api"),
        default="raw",
        help="Use reliable local wikitext conversion or optional server-rendered HTML",
    )
    parser.add_argument("--concurrency", type=int, default=4, help="Maximum concurrent BIKI requests")
    parser.add_argument("--batch-size", type=int, default=40, help="Page IDs per revision query")
    parser.add_argument("--retries", type=int, default=4, help="Retries for transient API failures")
    parser.add_argument("--timeout", type=float, default=60.0, help="HTTP timeout in seconds")
    parser.add_argument(
        "--user-agent",
        default=(
            "Mozilla/5.0 (compatible; Projects-SamDarkBall-ArmaDocsUpdater/1.0; "
            "+https://community.bistudio.com/wiki/Main_Page)"
        ),
        help="HTTP User-Agent",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    args.concurrency = max(1, min(args.concurrency, 8))
    args.batch_size = max(1, min(args.batch_size, 50))
    args.retries = max(0, args.retries)
    args.timeout = max(5.0, args.timeout)
    try:
        return asyncio.run(run(args))
    except KeyboardInterrupt:
        print("Interrupted", file=sys.stderr)
        return 130
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
