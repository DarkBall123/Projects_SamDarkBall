/*
    db_charcreator: open the character creator.
    Purpose: entry point invoked by the scroll-wheel action. Builds the attribute
             model, frames the GTA-style preview camera, opens the UI and starts the
             orbit per-frame handler.
    Context: client, player on foot, no creator already open.
    Params: addAction signature; unused (operates on `player`).
    Returns: nothing.
*/

#include "..\script_macros.hpp"

disableSerialization;

// Guard against double-open.
if (!isNull (GETUVAR(DB_cc_display, displayNull))) exitWith {};
if (!alive player) exitWith {};
if (!(vehicle player isEqualTo player)) exitWith {};

// 1. Data model (lists + current indices) -> uiNamespace.
call DB_fnc_cc_buildAttributeModel;

// 2. Relaxed, weapon-down pose for the preview.
call DB_fnc_cc_preparePlayer;

// 3. Camera in front of the player, looking at the head.
call DB_fnc_cc_setupCamera;

// 4. Build the panel. Aborts and tears down if the display can't be created.
call DB_fnc_cc_buildUI;
if (isNull (GETUVAR(DB_cc_display, displayNull))) exitWith {
    call DB_fnc_cc_close;
};

// 5. Orbit handler (A / E rotate the camera around the unit).
SETMVAR(DB_cc_orbitDir, 0);
private _pfh = [DB_fnc_cc_orbitPFH, 0, []] call CBA_fnc_addPerFrameHandler;
SETUVAR(DB_cc_pfh, _pfh);
