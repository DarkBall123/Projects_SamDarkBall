#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Config style checker (lightweight) for Arma config-like files:
- tabs check
- bracket balance check: (), {}, []

Targets: .hpp, .cpp, .h, .inc (config-ish / headers)
"""

from __future__ import annotations

import argparse
import fnmatch
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator, List, Tuple


DEFAULT_CONFIG_PATH = Path("tools/ci_config.json")

BR_OPEN = {"(": ")", "{": "}", "[": "]"}
BR_CLOSE = {")": "(", "}": "{", "]": "["}


@dataclass
class Finding:
    level: str
    file: Path
    line: int
    message: str

    def format(self) -> str:
        return f"{self.level} {self.file.as_posix()}:{self.line}: {self.message}"


def load_config(path: Path) -> dict:
    if path.exists():
        with path.open("r", encoding="utf-8") as f:
            return json.load(f)
    return {
        "config": {
            "include": ["addons"],
            "extensions": [".hpp", ".cpp", ".h", ".inc"],
            "exclude_globs": ["**/node_modules/**", "**/.hemtt/**", "**/vendor/**", "**/build/**"],
            "check_tabs": True,
            "check_brackets": True,
        }
    }


def iter_files(root: Path, includes: List[str], exclude_globs: List[str], exts: List[str]) -> Iterator[Path]:
    for inc in includes:
        base = (root / inc).resolve()
        if not base.exists():
            continue
        for p in base.rglob("*"):
            if not p.is_file():
                continue
            if p.suffix.lower() not in [e.lower() for e in exts]:
                continue
            rel = p.relative_to(root.resolve())
            if any(fnmatch.fnmatch(rel.as_posix(), g) for g in exclude_globs):
                continue
            yield p


def strip_line_comments(line: str) -> str:
    # config files often use // comments; keep it simple
    pos = line.find("//")
    if pos >= 0:
        return line[:pos]
    return line


def validate_file(path: Path, check_tabs: bool, check_brackets: bool) -> List[Finding]:
    findings: List[Finding] = []
    stack: List[Tuple[str, int]] = []

    try:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    except Exception as e:
        return [Finding("ERROR", path, 1, f"cannot read file: {e}")]

    for idx, raw in enumerate(lines, start=1):
        if check_tabs and "\t" in raw:
            findings.append(Finding("ERROR", path, idx, "tab character found; use spaces"))

        clean = strip_line_comments(raw)

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

    if check_brackets and stack:
        for open_ch, open_line in stack[-10:]:
            findings.append(Finding("ERROR", path, open_line, f"unclosed bracket '{open_ch}'"))

    return findings


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=".", help="repository root (default: .)")
    ap.add_argument("--config", default=str(DEFAULT_CONFIG_PATH), help="path to ci_config.json")
    args = ap.parse_args()

    root = Path(args.root).resolve()
    cfg = load_config(Path(args.config))

    c = cfg.get("config", {})
    includes = c.get("include", ["addons"])
    exts = c.get("extensions", [".hpp", ".cpp", ".h", ".inc"])
    exclude_globs = c.get("exclude_globs", [])
    check_tabs = bool(c.get("check_tabs", True))
    check_brackets = bool(c.get("check_brackets", True))

    all_findings: List[Finding] = []
    for p in iter_files(root, includes, exclude_globs, exts):
        all_findings.extend(validate_file(p, check_tabs, check_brackets))

    errors = [f for f in all_findings if f.level == "ERROR"]
    for f in all_findings:
        print(f.format())

    if errors:
        print(f"\nFound {len(errors)} error(s) in config style check.")
        return 1

    print("Config style check passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
