#!/usr/bin/env python3
from __future__ import annotations

import math
import random
import subprocess
import tempfile
import wave
from array import array
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SFX_DIR = ROOT / "data" / "sfx"
RATE = 44100


def clamp(value: float) -> float:
    return max(-1.0, min(1.0, value))


def smooth_fade(time_pos: float, duration: float, attack: float, release: float) -> float:
    fade_in = min(1.0, time_pos / max(attack, 0.0001))
    fade_out = min(1.0, (duration - time_pos) / max(release, 0.0001))
    return max(0.0, min(fade_in, fade_out))


def noise(rng: random.Random, strength: float) -> float:
    return rng.uniform(-1.0, 1.0) * strength


def render_clip(name: str, duration: float, generator) -> None:
    total_frames = int(duration * RATE)
    frames = array("h")

    for index in range(total_frames):
        time_pos = index / RATE
        sample = clamp(generator(time_pos, duration))
        frames.append(int(sample * 32767))

    SFX_DIR.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory() as tmp_dir:
        wav_path = Path(tmp_dir) / f"{name}.wav"
        ogg_path = SFX_DIR / f"{name}.ogg"

        with wave.open(str(wav_path), "wb") as wav_file:
            wav_file.setnchannels(1)
            wav_file.setsampwidth(2)
            wav_file.setframerate(RATE)
            wav_file.writeframes(frames.tobytes())

        subprocess.run(
            [
                "ffmpeg",
                "-y",
                "-loglevel",
                "error",
                "-i",
                str(wav_path),
                "-ac",
                "2",
                "-c:a",
                "vorbis",
                "-strict",
                "-2",
                "-q:a",
                "5",
                str(ogg_path),
            ],
            check=True,
        )


def build_pistol() -> None:
    rng = random.Random(101)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.002, 0.085)
        crack = noise(rng, 0.85) * math.exp(-time_pos * 22.0)
        pop = math.sin(2 * math.pi * 190 * time_pos) * 0.22 * math.exp(-time_pos * 16.0)
        snap = math.sin(2 * math.pi * 1200 * time_pos) * 0.08 * math.exp(-time_pos * 34.0)
        return (crack + pop + snap) * env * 0.8

    render_clip("pistol_shot", 0.13, generator)


def build_shotgun() -> None:
    rng = random.Random(202)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.002, 0.16)
        blast = noise(rng, 0.9) * math.exp(-time_pos * 12.0)
        thump = math.sin(2 * math.pi * 105 * time_pos) * 0.34 * math.exp(-time_pos * 7.5)
        tail = math.sin(2 * math.pi * 62 * time_pos) * 0.18 * math.exp(-time_pos * 4.8)
        return (blast + thump + tail) * env * 0.82

    render_clip("shotgun_shot", 0.24, generator)


def build_monster_attack() -> None:
    rng = random.Random(303)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.01, 0.18)
        growl_a = math.sin(2 * math.pi * (155 + (18 * math.sin(2 * math.pi * 7 * time_pos))) * time_pos)
        growl_b = math.sin(2 * math.pi * (92 + (10 * math.sin(2 * math.pi * 5 * time_pos))) * time_pos)
        rasp = noise(rng, 0.25) * math.exp(-time_pos * 4.0)
        return ((growl_a * 0.30) + (growl_b * 0.22) + rasp) * env * 0.9

    render_clip("monster_attack", 0.34, generator)


def build_monster_hurt() -> None:
    rng = random.Random(404)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.002, 0.11)
        pitch = 720 - (time_pos * 1800)
        yelp = math.sin(2 * math.pi * max(pitch, 120) * time_pos) * 0.34
        body = math.sin(2 * math.pi * (280 - (time_pos * 320)) * time_pos) * 0.18
        rasp = noise(rng, 0.12) * math.exp(-time_pos * 14.0)
        return (yelp + body + rasp) * env * 0.9

    render_clip("monster_hurt", 0.18, generator)


def build_monster_die() -> None:
    rng = random.Random(505)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.01, 0.28)
        bass = math.sin(2 * math.pi * max(220 - (time_pos * 260), 55) * time_pos) * 0.30
        mid = math.sin(2 * math.pi * max(360 - (time_pos * 420), 85) * time_pos) * 0.18
        rasp = noise(rng, 0.20) * math.exp(-time_pos * 5.0)
        return (bass + mid + rasp) * env * 0.88

    render_clip("monster_die", 0.56, generator)


def main() -> None:
    build_pistol()
    build_shotgun()
    build_monster_attack()
    build_monster_hurt()
    build_monster_die()


if __name__ == "__main__":
    main()
