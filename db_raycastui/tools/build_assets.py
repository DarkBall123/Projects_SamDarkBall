#!/usr/bin/env python3
from __future__ import annotations

import argparse
import subprocess
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]

WALLS = {
    "brick": ROOT / "data" / "walls" / "brick",
    "tech": ROOT / "data" / "walls" / "tech",
    "stone": ROOT / "data" / "walls" / "stone",
}

UI_ASSETS = {
    ROOT / "data" / "ui" / "weapon" / "blaster.svg": (ROOT / "data" / "ui" / "weapon" / "blaster.png", ROOT / "data" / "ui" / "weapon" / "blaster.jpg", (512, 256)),
    ROOT / "data" / "ui" / "weapon" / "blaster_fire.svg": (ROOT / "data" / "ui" / "weapon" / "blaster_fire.png", ROOT / "data" / "ui" / "weapon" / "blaster_fire.jpg", (512, 256)),
    ROOT / "data" / "ui" / "weapon" / "shotgun.svg": (ROOT / "data" / "ui" / "weapon" / "shotgun.png", ROOT / "data" / "ui" / "weapon" / "shotgun.jpg", (1024, 512)),
    ROOT / "data" / "ui" / "weapon" / "shotgun_fire.svg": (ROOT / "data" / "ui" / "weapon" / "shotgun_fire.png", ROOT / "data" / "ui" / "weapon" / "shotgun_fire.jpg", (1024, 512)),
    ROOT / "data" / "ui" / "weapon" / "shotgun_reload.svg": (ROOT / "data" / "ui" / "weapon" / "shotgun_reload.png", ROOT / "data" / "ui" / "weapon" / "shotgun_reload.jpg", (1024, 512)),
    ROOT / "data" / "ui" / "logo" / "doomcard.svg": (ROOT / "data" / "ui" / "logo" / "doomcard.png", ROOT / "data" / "ui" / "logo" / "doomcard.jpg", (1024, 256)),
}

SPRITE_ASSETS = {
    ROOT / "data" / "sprites" / "enemies" / "imp_idle.svg": (ROOT / "data" / "sprites" / "enemies" / "imp_idle.png", ROOT / "data" / "sprites" / "enemies" / "imp_idle.jpg", (512, 512)),
    ROOT / "data" / "sprites" / "enemies" / "imp_attack.svg": (ROOT / "data" / "sprites" / "enemies" / "imp_attack.png", ROOT / "data" / "sprites" / "enemies" / "imp_attack.jpg", (512, 512)),
    ROOT / "data" / "sprites" / "enemies" / "imp_hurt.svg": (ROOT / "data" / "sprites" / "enemies" / "imp_hurt.png", ROOT / "data" / "sprites" / "enemies" / "imp_hurt.jpg", (512, 512)),
}


def run(command: list[str]) -> None:
    subprocess.run(command, check=True)


def render_svg(svg_path: Path, png_path: Path, width: int, height: int) -> None:
    png_path.parent.mkdir(parents=True, exist_ok=True)
    run(["rsvg-convert", "-w", str(width), "-h", str(height), str(svg_path), "-o", str(png_path)])


def png_to_jpg(png_path: Path, jpg_path: Path, background: tuple[int, int, int]) -> None:
    image = Image.open(png_path).convert("RGBA")
    flat = Image.new("RGBA", image.size, background + (255,))
    merged = Image.alpha_composite(flat, image).convert("RGB")
    jpg_path.parent.mkdir(parents=True, exist_ok=True)
    merged.save(jpg_path, quality=95)


def build_wall_set(wall_name: str, wall_dir: Path, slice_count: int) -> None:
    svg_path = wall_dir / "source.svg"
    png_path = wall_dir / f"{wall_name}.png"
    jpg_path = wall_dir / f"{wall_name}.jpg"
    render_svg(svg_path, png_path, 128, 128)
    png_to_jpg(png_path, jpg_path, (12, 12, 12))

    slices_dir = wall_dir / "jpg"
    slices_dir.mkdir(parents=True, exist_ok=True)

    source = Image.open(png_path).convert("RGB")
    slice_width = source.width // slice_count
    for index in range(slice_count):
        left = index * slice_width
        right = source.width if index == (slice_count - 1) else left + slice_width
        crop = source.crop((left, 0, right, source.height))
        crop.save(slices_dir / f"slice_{index:02d}.jpg", quality=95)


def build_bitmap_assets(asset_map: dict[Path, tuple[Path, Path, tuple[int, int]]]) -> None:
    for svg_path, (png_path, jpg_path, size) in asset_map.items():
        width, height = size
        render_svg(svg_path, png_path, width, height)
        png_to_jpg(png_path, jpg_path, (5, 5, 5))


def main() -> None:
    parser = argparse.ArgumentParser(description="Build DB Raycast UI assets from SVG sources.")
    parser.add_argument("--slice-count", type=int, default=64, help="Number of wall slices to generate.")
    args = parser.parse_args()

    for wall_name, wall_dir in WALLS.items():
        build_wall_set(wall_name, wall_dir, args.slice_count)

    build_bitmap_assets(UI_ASSETS)
    build_bitmap_assets(SPRITE_ASSETS)


if __name__ == "__main__":
    main()
