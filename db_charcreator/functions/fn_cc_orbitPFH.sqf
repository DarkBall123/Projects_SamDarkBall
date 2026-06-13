/*
    db_charcreator: per-frame camera orbit.
    Purpose: keep the camera locked on the player and orbit it left/right while A/E
             are held (DB_cc_orbitDir set by the display KeyDown/KeyUp handlers).
    Context: client, CBA per-frame handler while the creator is open.
    Params: CBA PFH signature [_args, _handle]; unused.
    Returns: nothing.
*/

#include "..\script_macros.hpp"

private _cam = GETUVAR(DB_cc_cam, objNull);
if (isNull _cam) exitWith {};

private _dir = GETMVAR(DB_cc_orbitDir, 0);
private _az  = GETMVAR(DB_cc_azimuth, 180);

if (_dir != 0) then {
    _az = (_az + _dir * 70 * diag_deltaTime) % 360;
    SETMVAR(DB_cc_azimuth, _az);
};

private _dist   = GETMVAR(DB_cc_dist, 2.2);
private _height = GETMVAR(DB_cc_height, 1.45);

// Orbit around the player's chest at the requested eye height.
private _center = player modelToWorld [0, 0, 1.1];
private _camPos = _center vectorAdd [_dist * sin _az, _dist * cos _az, _height - 1.1];

_cam setPosATL _camPos;
_cam camSetTarget (player modelToWorld [0, 0, 1.4]);
_cam camCommit 0;
