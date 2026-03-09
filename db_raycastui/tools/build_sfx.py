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


def square(freq: float, time_pos: float) -> float:
    return 1.0 if math.sin(2 * math.pi * freq * time_pos) >= 0 else -1.0


def triangle(freq: float, time_pos: float) -> float:
    return (2.0 / math.pi) * math.asin(math.sin(2 * math.pi * freq * time_pos))


def bitcrush(value: float, steps: int) -> float:
    if steps <= 1:
        return value
    return round(value * steps) / steps


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
        env = smooth_fade(time_pos, duration, 0.001, 0.075)
        crack = noise(rng, 0.88) * math.exp(-time_pos * 28.0)
        bark = square(180, time_pos) * 0.22 * math.exp(-time_pos * 13.0)
        snap = triangle(820, time_pos) * 0.12 * math.exp(-time_pos * 30.0)
        tail = math.sin(2 * math.pi * 108 * time_pos) * 0.14 * math.exp(-time_pos * 9.0)
        return bitcrush((crack + bark + snap + tail) * env * 0.82, 18)

    render_clip("pistol_shot", 0.12, generator)


def build_shotgun() -> None:
    rng = random.Random(202)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.001, 0.16)
        blast = noise(rng, 0.92) * math.exp(-time_pos * 12.5)
        bass = square(92, time_pos) * 0.28 * math.exp(-time_pos * 5.8)
        body = triangle(148, time_pos) * 0.18 * math.exp(-time_pos * 7.4)
        tail = math.sin(2 * math.pi * 58 * time_pos) * 0.18 * math.exp(-time_pos * 3.6)
        return bitcrush((blast + bass + body + tail) * env * 0.86, 14)

    render_clip("shotgun_shot", 0.24, generator)


def build_monster_idle() -> None:
    rng = random.Random(252)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.02, 0.12)
        throat = triangle(96 + (6 * math.sin(2 * math.pi * 3.0 * time_pos)), time_pos) * 0.24
        rasp = noise(rng, 0.16) * math.exp(-time_pos * 3.2)
        rumble = square(48, time_pos) * 0.12 * math.exp(-time_pos * 1.7)
        return bitcrush((throat + rasp + rumble) * env * 0.74, 20)

    render_clip("monster_idle", 0.26, generator)


def build_monster_attack() -> None:
    rng = random.Random(303)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.004, 0.14)
        shriek = triangle(280 - (time_pos * 120), time_pos) * 0.24
        growl = square(132 + (12 * math.sin(2 * math.pi * 5.0 * time_pos)), time_pos) * 0.18
        rasp = noise(rng, 0.26) * math.exp(-time_pos * 5.0)
        return bitcrush((shriek + growl + rasp) * env * 0.84, 16)

    render_clip("monster_attack", 0.28, generator)


def build_monster_hurt() -> None:
    rng = random.Random(404)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.001, 0.10)
        yelp = triangle(max(860 - (time_pos * 2200), 160), time_pos) * 0.32
        body = square(max(210 - (time_pos * 240), 70), time_pos) * 0.16
        rasp = noise(rng, 0.14) * math.exp(-time_pos * 11.0)
        return bitcrush((yelp + body + rasp) * env * 0.82, 14)

    render_clip("monster_hurt", 0.16, generator)


def build_monster_die() -> None:
    rng = random.Random(505)

    def generator(time_pos: float, duration: float) -> float:
        env = smooth_fade(time_pos, duration, 0.01, 0.26)
        bass = triangle(max(210 - (time_pos * 240), 52), time_pos) * 0.28
        choke = square(max(148 - (time_pos * 120), 48), time_pos) * 0.18
        rasp = noise(rng, 0.22) * math.exp(-time_pos * 4.2)
        return bitcrush((bass + choke + rasp) * env * 0.86, 15)

    render_clip("monster_die", 0.48, generator)


def main() -> None:
    build_pistol()
    build_shotgun()
    build_monster_idle()
    build_monster_attack()
    build_monster_hurt()
    build_monster_die()


if __name__ == "__main__":
    main()
