#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SQF validator (lightweight):
- tabs check
- bracket balance check: (), {}, []
- basic missing semicolon heuristic (best-effort, may be tuned via config)

Designed for CI usage (GitHub Actions).
"""

from __future__ import annotations

import argparse
import fnmatch
import json
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Iterator, List, Tuple


DEFAULT_CONFIG_PATH = Path("tools/ci_config.json")


@dataclass
class Finding:
    level: str   # "ERROR" | "WARN"
    file: Path
    line: int
    message: str

    def format(self) -> str:
        return f"{self.level} {self.file.as_posix()}:{self.line}: {self.message}"


def load_config(path: Path) -> dict:
    if path.exists():
        with path.open("r", encoding="utf-8") as f:
            return json.load(f)
    # safe defaults
    return {
        "sqf": {
            "include": ["addons"],
            "exclude_globs": ["**/node_modules/**", "**/.hemtt/**", "**/vendor/**", "**/build/**"],
            "check_tabs": True,
            "check_brackets": True,
            "check_semicolons": True,
        }
    }


def iter_files(root: Path, includes: List[str], exclude_globs: List[str], ext: str) -> Iterator[Path]:
    for inc in includes:
        base = (root / inc).resolve()
        if not base.exists():
            continue
        for p in base.rglob(f"*{ext}"):
            rel = p.relative_to(root.resolve())
            if any(fnmatch.fnmatch(rel.as_posix(), g) for g in exclude_globs):
                continue
            yield p


# ---------- stripping comments/strings (best-effort) ----------

@dataclass
class StripState:
    in_block_comment: bool = False
    in_string: bool = False


def strip_sqf_line(line: str, st: StripState) -> Tuple[str, StripState]:
    """
    Remove comments and string literals content (replace with spaces),
    keeping structure for bracket scanning.
    Handles:
      - // line comments
      - /* ... */ block comments (multi-line)
      - "..." strings (SQF uses "" to escape a quote inside string)
    """
    out = []
    i = 0
    n = len(line)

    while i < n:
        ch = line[i]

        # block comment mode
        if st.in_block_comment:
            if ch == "*" and i + 1 < n and line[i + 1] == "/":
                st.in_block_comment = False
                out.append("  ")
                i += 2
            else:
                out.append(" ")
                i += 1
            continue

        # string mode
        if st.in_string:
            if ch == '"':
                # SQF escape is "" inside string
                if i + 1 < n and line[i + 1] == '"':
                    out.append("  ")
                    i += 2
                else:
                    st.in_string = False
                    out.append(" ")
                    i += 1
            else:
                out.append(" ")
                i += 1
            continue

        # entering comment/string
        if ch == "/" and i + 1 < n and line[i + 1] == "/":
            # rest of line is comment
            out.append(" " * (n - i))
            break

        if ch == "/" and i + 1 < n and line[i + 1] == "*":
            st.in_block_comment = True
            out.append("  ")
            i += 2
            continue

        if ch == '"':
            st.in_string = True
            out.append(" ")
            i += 1
            continue

        out.append(ch)
        i += 1

    return "".join(out), st


# ---------- checks ----------

BR_OPEN = {"(": ")", "{": "}", "[": "]"}
BR_CLOSE = {")": "(", "}": "{", "]": "["}


CONTROL_LINE_RE = re.compile(r"^\s*(if|for|foreach|while|switch|case|default)\b", re.IGNORECASE)
PREPROC_RE = re.compile(r"^\s*#")


def should_require_semicolon(clean_line: str) -> bool:
    """
    Heuristic:
    - ignore empty, preprocessor, pure braces, obvious continuations
    - require semicolon for "statement-like" lines
    """
    s = clean_line.strip()
    if not s:
        return False
    if PREPROC_RE.match(s):
        return False

    # ignore single braces or block open/close
    if s in ("{", "}", "};", "};", "};"):
        return False

    # ignore control lines that usually start blocks
    if CONTROL_LINE_RE.match(s):
        return False

    # obvious continuations
    if s.endswith(("{", "}", ";", ",", ":", "[", "(", "\\", "&&", "||")):
        return False

    # `then` lines often open blocks
    if s.endswith("then"):
        return False

    # common multiline operators at end
    if s.endswith(("+", "-", "*", "/", "%", "==", "!=", ">", "<", ">=", "<=", "=")):
        return False

    # if line ends with closing bracket/paren, it might still need semicolon,
    # but allow multiline arrays/calls to reduce false positives:
    if s.endswith(("]", ")")):
        return False

    # otherwise: likely a statement missing ;
    return True


def validate_sqf_file(path: Path, check_tabs: bool, check_brackets: bool, check_semicolons: bool) -> List[Finding]:
    findings: List[Finding] = []

    # tabs + semicolons check line-by-line
    st = StripState()
    stack: List[Tuple[str, int]] = []  # (open_bracket, line_no)

    try:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    except Exception as e:
        return [Finding("ERROR", path, 1, f"cannot read file: {e}")]

    for idx, raw in enumerate(lines, start=1):
        if check_tabs and "\t" in raw:
            findings.append(Finding("ERROR", path, idx, "tab character found; use spaces"))

        clean, st = strip_sqf_line(raw, st)

        if check_brackets:
            for ch in clean:
                if ch in BR_OPEN:
                    stack.append((ch, idx))
                elif ch in BR_CLOSE:
                    if not stack:
                        findings.append(Finding("ERROR", path, idx, f"unexpected closing bracket '{ch}'"))
                    else:
                        open_ch, open_line = stack.pop()
                        if BR_OPEN[open_ch] != ch:
                            findings.append(Finding(
                                "ERROR",
                                path,
                                idx,
                                f"mismatched bracket: opened '{open_ch}' at line {open_line}, closed '{ch}'"
                            ))

        if check_semicolons:
            # remove trailing whitespace and comments/strings already stripped
            # apply heuristic only if not in block-comment/string
            # (we don't want to enforce semicolons inside those states)
            if not st.in_block_comment and not st.in_string:
                if should_require_semicolon(clean):
                    findings.append(Finding("ERROR", path, idx, "possible missing ';' at end of statement (heuristic)"))

    if check_brackets and stack:
        # report unclosed brackets
        for open_ch, open_line in stack[-10:]:
            findings.append(Finding("ERROR", path, open_line, f"unclosed bracket '{open_ch}'"))

    # if file ends inside block comment or string → error
    if st.in_block_comment:
        findings.append(Finding("ERROR", path, len(lines) or 1, "file ends inside /* block comment */"))
    if st.in_string:
        findings.append(Finding("ERROR", path, len(lines) or 1, "file ends inside a string literal"))

    return findings


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=".", help="repository root (default: .)")
    ap.add_argument("--config", default=str(DEFAULT_CONFIG_PATH), help="path to ci_config.json")
    ap.add_argument("--no-semicolons", action="store_true", help="disable semicolon heuristic")
    args = ap.parse_args()

    root = Path(args.root).resolve()
    cfg = load_config(Path(args.config))

    sqf_cfg = cfg.get("sqf", {})
    includes = sqf_cfg.get("include", ["addons"])
    exclude_globs = sqf_cfg.get("exclude_globs", [])
    check_tabs = bool(sqf_cfg.get("check_tabs", True))
    check_brackets = bool(sqf_cfg.get("check_brackets", True))
    check_semicolons = bool(sqf_cfg.get("check_semicolons", True)) and not args.no_semicolons

    all_findings: List[Finding] = []
    for file_path in iter_files(root, includes, exclude_globs, ".sqf"):
        all_findings.extend(validate_sqf_file(file_path, check_tabs, check_brackets, check_semicolons))

    # print & exit
    errors = [f for f in all_findings if f.level == "ERROR"]
    for f in all_findings:
        print(f.format())

    if errors:
        print(f"\nFound {len(errors)} error(s) in SQF validation.")
        return 1

    print("SQF validation passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
