# Deadspace Inventory

`deadspace_inventory` is a standalone Arma 3 addon that replaces the default inventory window with a diegetic, screen-space interaction overlay.

The current implementation is intentionally cursorless:
- the player keeps movement and camera control;
- the overlay is positioned near the inspected target with `worldToScreen`;
- the currently selected slot is the one closest to the center of the screen;
- item transfer is a single action, not drag and drop.

## Current Features

- `Ctrl+I` opens the custom inventory overlay.
- `InventoryOpened` is overridden for the controlled unit.
- Supports inspection of:
  - player inventory
  - other units / corpses
  - vehicles
  - generic cargo objects / containers
- Cargo is grouped into stacks by classname.
- Transfer is one-click / one-confirm action.

## Controls

- `Ctrl+I`: open / close overlay
- `Tab`: switch container panel
- `Mouse Wheel`: change page
- `Left / Right Arrow`: change page
- `Space` or `Enter`: transfer selected stack
- `Esc`: close overlay

`LMB` is also hooked as a confirm input, but the keyboard path is currently considered the reliable interaction path until in-game validation is complete.

## Architecture

The addon does not use `createDisplay` for the main interaction flow.

Instead it follows an ACE-like approach:
- input hooks are attached to `findDisplay 46`;
- rendering runs in `Draw2D`;
- overlay placement is derived from `worldToScreen`;
- UI controls are created dynamically on the main mission display.

This avoids taking over the cursor in the normal gameplay interaction mode.

Display registration is not based on `BIS_fnc_initDisplay` scripted events. The addon currently waits for `findDisplay 46`, then attaches its handlers directly. Save-load recovery is registered during preInit via the mission `"Loaded"` event, because Arma requires that handler to exist before a saved mission is restored.

## Important Limitations

- This is still an MVP implementation.
- The overlay has not yet been validated in live Arma 3 runtime.
- Remote-control edge cases may require extra event wiring depending on the final gameplay scope.
- Weapon attachment-aware cargo transfer is not finalized yet.

## Relevant Files

- `config.cpp`
- `XEH_preInit.sqf`
- `XEH_postInit.sqf`
- `functions/fn_inv_postInit.sqf`
- `functions/fn_inv_registerDisplayEH.sqf`
- `functions/fn_inv_registerInventoryEH.sqf`
- `functions/fn_inv_render.sqf`
