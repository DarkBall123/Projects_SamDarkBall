#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Static SQF/CBA pattern tests for vnd_main.

Purpose:
- enforce pure CBA usage (no legacy CBA internals/guard hacks in SQF)
- enforce forbidden SQF constructs in this repo (`scopeName`, `breakOut`)
- verify CBA addon dependencies in config.cpp
"""

from __future__ import annotations

import argparse
import fnmatch
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator, List


EXCLUDE_GLOBS = [
    "**/.git/**",
    "**/node_modules/**",
    "**/.hemtt/**",
    "**/vendor/**",
    "**/build/**",
]


@dataclass
class Finding:
    file: Path
    line: int
    message: str

    def format(self, root: Path) -> str:
        rel = self.file.resolve().relative_to(root.resolve())
        return f"ERROR {rel.as_posix()}:{self.line}: {self.message}"


def iter_sqf_files(root: Path, addon_dir: Path) -> Iterator[Path]:
    for path in addon_dir.rglob("*.sqf"):
        rel = path.resolve().relative_to(root.resolve()).as_posix()
        if any(fnmatch.fnmatch(rel, g) for g in EXCLUDE_GLOBS):
            continue
        yield path


def find_line(text: str, needle: str) -> int:
    pos = text.find(needle)
    if pos < 0:
        return 1
    return text.count("\n", 0, pos) + 1


def check_forbidden_constructs(root: Path, addon_dir: Path) -> List[Finding]:
    findings: List[Finding] = []
    forbidden_patterns = [
        re.compile(r"\bscopeName\b"),
        re.compile(r"\bbreakOut\b"),
    ]

    for path in iter_sqf_files(root, addon_dir):
        text = path.read_text(encoding="utf-8", errors="replace")
        lines = text.splitlines()
        for idx, raw in enumerate(lines, start=1):
            clean = raw.strip()
            if clean.startswith("//"):
                continue
            for pat in forbidden_patterns:
                if pat.search(raw):
                    findings.append(Finding(path, idx, f"forbidden SQF construct `{pat.pattern.strip('\\\\b')}` found"))
    return findings


def check_no_legacy_cba_constructs(root: Path, addon_dir: Path) -> List[Finding]:
    findings: List[Finding] = []

    legacy_tokens = [
        "cba_common_perFrameHandlerArray",
        "cba_common_PFHhandles",
        "cba_common_waitUntilAndExecArray",
    ]
    legacy_isnil_re = re.compile(r'isNil\s+"CBA_fnc_[^"]+"')

    for path in iter_sqf_files(root, addon_dir):
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        for idx, raw in enumerate(lines, start=1):
            clean = raw.strip()
            if clean.startswith("//"):
                continue

            for token in legacy_tokens:
                if token in raw:
                    findings.append(Finding(path, idx, f"legacy CBA internal token found: `{token}`"))

            if legacy_isnil_re.search(raw):
                findings.append(Finding(path, idx, "legacy `isNil \"CBA_fnc_*\"` guard found; use direct CBA call"))

    return findings


def check_required_addons(root: Path, addon_dir: Path) -> List[Finding]:
    findings: List[Finding] = []
    cfg = addon_dir / "config.cpp"
    if not cfg.exists():
        findings.append(Finding(cfg, 1, "config.cpp not found"))
        return findings

    text = cfg.read_text(encoding="utf-8", errors="replace")
    required = [
        '"cba_main"',
        '"cba_common"',
        '"cba_xeh"',
        '"cba_xeh_a3"',
        '"cba_settings"',
    ]

    missing = [name for name in required if name not in text]
    if missing:
        findings.append(
            Finding(
                cfg,
                find_line(text, "requiredAddons[]"),
                f"requiredAddons is missing: {', '.join(missing)}",
            )
        )
    return findings


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", default=".", help="repository root")
    parser.add_argument("--addon", default="vnd_main", help="addon directory to validate")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    addon_dir = (root / args.addon).resolve()

    if not addon_dir.exists():
        print(f"ERROR {args.addon}: addon directory does not exist")
        return 2

    findings: List[Finding] = []
    findings.extend(check_forbidden_constructs(root, addon_dir))
    findings.extend(check_no_legacy_cba_constructs(root, addon_dir))
    findings.extend(check_required_addons(root, addon_dir))

    if findings:
        for f in findings:
            print(f.format(root))
        return 1

    print("SQF CBA pattern tests passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
