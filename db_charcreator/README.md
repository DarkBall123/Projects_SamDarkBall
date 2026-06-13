# db_charcreator — Character Creator

A standalone GTA-style character creation system for Arma 3, built as an independent
CBA addon. Walk up to yourself, open the creator from the scroll-wheel menu, and
customize your character live with an orbiting preview camera — like the GTA online
character editor, adapted to what Arma 3 supports natively.

## Features

- **Scroll-wheel action** `Create Character` on the player (re-added on respawn).
- **GTA-style preview**: a free camera frames you from the front; hold **A / E** to
  orbit it around the model. Changes apply to the real player unit instantly, so the
  game world stays visible behind a translucent right-side panel.
- **Customizable attributes** (each with `<` / `>` selectors):
  - **Face** — every `CfgFaces` entry (`setFace`)
  - **Voice** — every `CfgVoice` speaker (`setSpeaker`)
  - **Glasses** — `CfgGlasses`, plus *None* (`addGoggles`)
  - **Uniform** — every wearable uniform in `CfgWeapons` (`forceAddUniform`)
  - **Headgear** — every headgear in `CfgWeapons`, plus *None* (`addHeadgear`)
- **Finish** button (or **ESC**) closes the editor and returns the camera cleanly.

The attribute lists are enumerated from config at runtime, so anything added by other
loaded mods shows up automatically.

## Scope notes

- **Session only** — nothing is written to disk. Selections last for the current
  mission. (Persistence to `profileNamespace` would be a small addition in `cc_close`.)
- **No name / gender / age / backstory** — Arma 3 cannot rename the engine player, and
  hair/beard are baked into the face model, so those GTA fields were intentionally left
  out rather than faked.
- **Multiplayer face** — `setFace` is applied locally for instant preview. To sync the
  face to other clients, enable the `remoteExec` line in `functions/fn_cc_apply.sqf`.
- `forceAddUniform` clears items stored in the uniform — expected for a cosmetic editor.

## Requirements

- CBA_A3 (`cba_main`, `cba_xeh`)
- Base game `A3_Characters_F`

## Layout

```
config.cpp                     CfgPatches + includes
script_macros.hpp              CBA macros, grid units, control idc scheme
XEH_preInit.sqf / XEH_postInit.sqf
includes/                      CfgFunctions + Extended_*_EventHandlers
functions/                     fn_cc_*.sqf (open, close, UI, camera, model)
```

All functions resolve under the `DB` tag, e.g. `DB_fnc_cc_open`.

## Testing in the editor

1. Load with CBA: `-mod=@CBA_A3;<path to db_charcreator>`.
2. Place a playable unit in Eden, hit Play.
3. Scroll-wheel near yourself → **Create Character**.
4. Hold **A / E** to spin the camera; cycle each attribute with `<` / `>`.
5. **Finish** (or **ESC**) → camera returns to the player, no leftover state.
