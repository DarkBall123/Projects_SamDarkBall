# DB UI Editor Sample

Small in-game playground for Arma 3 UI controls. It is intentionally separate from the product mods.

## Run

```powershell
cd samples\arma-ui-editor
hemtt launch
```

Open any mission or Eden preview and press `F7`. The action is also available under:

`Options > Controls > Configure Addons > DB Samples > Open UI Editor`

From the debug console you can open it directly:

```sqf
[] call DB_fnc_openUIEditor;
```

## Included

- Common text, image, input, button, list, tree, slider, progress, map, and group controls.
- Root controls and controls nested inside a selected `ControlsGroup`.
- SafeZone, PixelGrid + SafeZone, PixelGrid, GUI_GRID, and absolute coordinate views.
- Editable text and `x/y/w/h` values.
- Config output that can be selected and copied with `Ctrl+C`.

This is a sample, not a replacement for the built-in GUI Editor. It focuses on quickly checking control behavior and coordinate math inside Arma.
