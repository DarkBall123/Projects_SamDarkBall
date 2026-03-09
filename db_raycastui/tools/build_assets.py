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
    ROOT / "data" / "ui" / "logo" / "doomcard.svg": (ROOT / "data" / "ui" / "logo" / "doomcard.png", (1024, 256)),
    ROOT / "data" / "ui" / "status" / "statusbar.svg": (ROOT / "data" / "ui" / "status" / "statusbar.png", (2048, 256)),
    ROOT / "data" / "ui" / "status" / "face_idle.svg": (ROOT / "data" / "ui" / "status" / "face_idle.png", (256, 256)),
    ROOT / "data" / "ui" / "status" / "face_alert.svg": (ROOT / "data" / "ui" / "status" / "face_alert.png", (256, 256)),
    ROOT / "data" / "ui" / "status" / "face_hurt.svg": (ROOT / "data" / "ui" / "status" / "face_hurt.png", (256, 256)),
    ROOT / "data" / "ui" / "status" / "face_dead.svg": (ROOT / "data" / "ui" / "status" / "face_dead.png", (256, 256)),
}

BLASTER_SHEET = ROOT / "data" / "ui" / "weapon" / "source" / "blaster_sheet.png"
BLASTER_FRAMES = {
    "blaster": ((189, 51, 337, 240), ROOT / "data" / "ui" / "weapon" / "blaster.png", (512, 256), (360, 226), (0, -10)),
    "blaster_fire": ((340, 41, 502, 240), ROOT / "data" / "ui" / "weapon" / "blaster_fire.png", (512, 256), (360, 226), (0, -10)),
}

SHOTGUN_SHEET = ROOT / "data" / "ui" / "weapon" / "source" / "shotgun_sheet.png"
SHOTGUN_FRAMES = {
    "shotgun": ((30, 87, 126, 153), ROOT / "data" / "ui" / "weapon" / "shotgun.png", (1024, 512), (920, 420), (0, -6)),
    "shotgun_fire": ((149, 164, 245, 247), ROOT / "data" / "ui" / "weapon" / "shotgun_fire.png", (1024, 512), (980, 470), (6, -12)),
    "shotgun_reload": ((749, 201, 830, 247), ROOT / "data" / "ui" / "weapon" / "shotgun_reload.png", (1024, 512), (860, 330), (0, 46)),
}

SPRITE_ASSETS = {
    ROOT / "data" / "sprites" / "enemies" / "imp_idle.svg": (ROOT / "data" / "sprites" / "enemies" / "imp_idle.png", (512, 512)),
    ROOT / "data" / "sprites" / "enemies" / "imp_attack.svg": (ROOT / "data" / "sprites" / "enemies" / "imp_attack.png", (512, 512)),
    ROOT / "data" / "sprites" / "enemies" / "imp_hurt.svg": (ROOT / "data" / "sprites" / "enemies" / "imp_hurt.png", (512, 512)),
}

PROJECTILE_ASSETS = {
    ROOT / "data" / "sprites" / "projectiles" / "fireball_0.svg": (ROOT / "data" / "sprites" / "projectiles" / "fireball_0.png", (256, 256)),
    ROOT / "data" / "sprites" / "projectiles" / "fireball_1.svg": (ROOT / "data" / "sprites" / "projectiles" / "fireball_1.png", (256, 256)),
    ROOT / "data" / "sprites" / "projectiles" / "fireball_2.svg": (ROOT / "data" / "sprites" / "projectiles" / "fireball_2.png", (256, 256)),
}

PICKUP_ASSETS = {
    ROOT / "data" / "sprites" / "pickups" / "exit_portal.svg": (ROOT / "data" / "sprites" / "pickups" / "exit_portal.png", (256, 512)),
}


def run(command: list[str]) -> None:
    subprocess.run(command, check=True)


def render_svg(svg_path: Path, png_path: Path, width: int, height: int) -> None:
    png_path.parent.mkdir(parents=True, exist_ok=True)
    run(["rsvg-convert", "-w", str(width), "-h", str(height), str(svg_path), "-o", str(png_path)])


def remove_checkerboard(image: Image.Image) -> Image.Image:
    image = image.convert("RGBA")
    pixels = image.load()
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = pixels[x, y]
            if (r, g, b) in ((255, 255, 255), (238, 238, 238)):
                pixels[x, y] = (0, 0, 0, 0)
    return image


def strip_blaster_flash(image: Image.Image) -> Image.Image:
    image = image.convert("RGBA")
    pixels = image.load()
    cutoff_y = int(image.height * 0.48)
    crown_y = int(image.height * 0.30)
    for y in range(cutoff_y):
        for x in range(image.width):
            r, g, b, a = pixels[x, y]
            if a == 0:
                continue
            if (y < crown_y) and (max(r, g, b) > 105):
                pixels[x, y] = (0, 0, 0, 0)
                continue
            if (y < cutoff_y) and (r > 60) and (r > g) and (r > b):
                pixels[x, y] = (0, 0, 0, 0)
                continue
            if ((r >= 150) and (g >= 90)) or ((r >= 95) and (g >= 20) and (b <= 120)):
                pixels[x, y] = (0, 0, 0, 0)
    return image


def build_shotgun_assets() -> None:
    if not SHOTGUN_SHEET.exists():
        return

    sheet = remove_checkerboard(Image.open(SHOTGUN_SHEET))

    for _name, (crop_box, png_path, canvas_size, fit_size, offset) in SHOTGUN_FRAMES.items():
        sprite = sheet.crop(crop_box)
        bbox = sprite.getbbox()
        if bbox is not None:
            sprite = sprite.crop(bbox)

        scale = min(fit_size[0] / sprite.width, fit_size[1] / sprite.height)
        scaled = sprite.resize((max(1, int(round(sprite.width * scale))), max(1, int(round(sprite.height * scale)))), Image.Resampling.NEAREST)

        canvas = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
        left = ((canvas_size[0] - scaled.width) // 2) + offset[0]
        top = (canvas_size[1] - scaled.height) - 10 + offset[1]
        canvas.alpha_composite(scaled, (left, top))

        png_path.parent.mkdir(parents=True, exist_ok=True)
        canvas.save(png_path)


def build_blaster_assets() -> None:
    if not BLASTER_SHEET.exists():
        return

    sheet = remove_checkerboard(Image.open(BLASTER_SHEET))

    for _name, (crop_box, png_path, canvas_size, fit_size, offset) in BLASTER_FRAMES.items():
        sprite = sheet.crop(crop_box)
        if _name == "blaster":
            sprite = strip_blaster_flash(sprite)

        scale = min(fit_size[0] / sprite.width, fit_size[1] / sprite.height)
        scaled = sprite.resize((max(1, int(round(sprite.width * scale))), max(1, int(round(sprite.height * scale)))), Image.Resampling.NEAREST)

        canvas = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
        left = ((canvas_size[0] - scaled.width) // 2) + offset[0]
        top = (canvas_size[1] - scaled.height) - 6 + offset[1]
        canvas.alpha_composite(scaled, (left, top))

        png_path.parent.mkdir(parents=True, exist_ok=True)
        canvas.save(png_path)


def build_wall_set(wall_name: str, wall_dir: Path, slice_count: int) -> None:
    svg_path = wall_dir / "source.svg"
    png_path = wall_dir / f"{wall_name}.png"
    render_svg(svg_path, png_path, 128, 128)

    slices_dir = wall_dir / "jpg"
    slices_dir.mkdir(parents=True, exist_ok=True)

    source = Image.open(png_path).convert("RGBA")
    slice_width = source.width // slice_count
    for index in range(slice_count):
        left = index * slice_width
        right = source.width if index == (slice_count - 1) else left + slice_width
        crop = source.crop((left, 0, right, source.height))
        crop.save(slices_dir / f"slice_{index:02d}.png")

def build_bitmap_assets(asset_map: dict[Path, tuple[Path, tuple[int, int]]]) -> None:
    for svg_path, (png_path, size) in asset_map.items():
        width, height = size
        render_svg(svg_path, png_path, width, height)


def main() -> None:
    parser = argparse.ArgumentParser(description="Build DB Raycast UI assets from SVG sources.")
    parser.add_argument("--slice-count", type=int, default=64, help="Number of wall slices to generate.")
    args = parser.parse_args()

    for wall_name, wall_dir in WALLS.items():
        build_wall_set(wall_name, wall_dir, args.slice_count)

    build_bitmap_assets(UI_ASSETS)
    build_blaster_assets()
    build_shotgun_assets()
    build_bitmap_assets(SPRITE_ASSETS)
    build_bitmap_assets(PROJECTILE_ASSETS)
    build_bitmap_assets(PICKUP_ASSETS)


if __name__ == "__main__":
    main()
