#!/usr/bin/env python3
from __future__ import annotations

import argparse
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

REQUIRED_PAA = [
    ROOT / "data" / "ui" / "logo" / "doomcard.paa",
    ROOT / "data" / "ui" / "status" / "statusbar.paa",
    ROOT / "data" / "ui" / "status" / "face_idle.paa",
    ROOT / "data" / "ui" / "status" / "face_alert.paa",
    ROOT / "data" / "ui" / "status" / "face_hurt.paa",
    ROOT / "data" / "ui" / "status" / "face_dead.paa",
    ROOT / "data" / "ui" / "weapon" / "blaster.paa",
    ROOT / "data" / "ui" / "weapon" / "blaster_fire.paa",
    ROOT / "data" / "ui" / "weapon" / "shotgun.paa",
    ROOT / "data" / "ui" / "weapon" / "shotgun_fire.paa",
    ROOT / "data" / "ui" / "weapon" / "shotgun_reload.paa",
    ROOT / "data" / "sprites" / "enemies" / "imp_idle.paa",
    ROOT / "data" / "sprites" / "enemies" / "imp_attack.paa",
    ROOT / "data" / "sprites" / "enemies" / "imp_hurt.paa",
    ROOT / "data" / "sprites" / "pickups" / "exit_portal.paa",
    ROOT / "data" / "sprites" / "projectiles" / "fireball_0.paa",
    ROOT / "data" / "sprites" / "projectiles" / "fireball_1.paa",
    ROOT / "data" / "sprites" / "projectiles" / "fireball_2.paa",
    ROOT / "data" / "walls" / "brick" / "brick.paa",
    ROOT / "data" / "walls" / "stone" / "stone.paa",
    ROOT / "data" / "walls" / "tech" / "tech.paa",
]


def wall_slice_paths() -> list[Path]:
    paths: list[Path] = []
    for wall_name in ("brick", "stone", "tech"):
        for index in range(64):
            paths.append(ROOT / "data" / "walls" / wall_name / "jpg" / f"slice_{index:02d}.paa")
    return paths


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate the DB Raycast UI .paa asset set.")
    parser.add_argument("--quiet", action="store_true", help="Only use the exit code.")
    args = parser.parse_args()

    missing = [path for path in (REQUIRED_PAA + wall_slice_paths()) if not path.exists()]
    if not missing:
        if not args.quiet:
            print("DB Raycast UI .paa asset set looks complete.")
        return 0

    if not args.quiet:
        print("Missing .paa assets:")
        for path in missing:
            print(path.relative_to(ROOT))

    return 1


if __name__ == "__main__":
    sys.exit(main())
