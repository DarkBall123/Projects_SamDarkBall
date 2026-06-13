/*
    db_charcreator: create and frame the preview camera.
    Purpose: spawn a free camera in front of the player looking at the head, GTA
             style, leaving the game world visible behind the panel.
    Context: client, called once on open.
    Params: none.
    Returns: nothing (stores DB_cc_cam in uiNamespace + orbit state in missionNamespace).
*/

#include "..\script_macros.hpp"

// Orbit state: azimuth (deg), radius (m), eye height (m ATL).
SETMVAR(DB_cc_azimuth, (getDir player) + 180);
SETMVAR(DB_cc_dist, 2.2);
SETMVAR(DB_cc_height, 1.45);

private _cam = "camera" camCreate (player modelToWorld [0, 2.2, 1.45]);
_cam cameraEffect ["internal", "back"];
_cam camSetTarget player;
_cam camSetFov 0.7;
_cam camCommit 0;

showCinemaBorder false;

SETUVAR(DB_cc_cam, _cam);
