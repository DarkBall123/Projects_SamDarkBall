/*
    db_charcreator: tear down the character creator.
    Purpose: stop the orbit handler, destroy the camera, restore the player's pose
             and close the display. Safe to call repeatedly and from the display
             Unload handler (ESC) as well as the Finish button.
    Context: client.
    Params: none.
    Returns: nothing.
*/

#include "..\script_macros.hpp"

disableSerialization;

// 1. Per-frame orbit handler.
private _pfh = GETUVAR(DB_cc_pfh, -1);
if (_pfh >= 0) then {
    [_pfh] call CBA_fnc_removePerFrameHandler;
};
SETUVAR(DB_cc_pfh, -1);

// 2. Camera. Terminating the effect hands the view back to the player.
private _cam = GETUVAR(DB_cc_cam, objNull);
if (!isNull _cam) then {
    _cam cameraEffect ["terminate", "back"];
    camDestroy _cam;
};
SETUVAR(DB_cc_cam, objNull);

// 3. Pose / weapon.
call DB_fnc_cc_restorePlayer;

// 4. Display. Null the handle first so the Unload handler doesn't recurse.
private _disp = GETUVAR(DB_cc_display, displayNull);
SETUVAR(DB_cc_display, displayNull);
if (!isNull _disp) then {
    _disp closeDisplay 1;
};
