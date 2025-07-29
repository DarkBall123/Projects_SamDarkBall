params ["_pl", "_uav"];

if !(missionNamespace getVariable ["vnd_showFiber", true]) exitWith {};

private _anchorDist = 1.5;
private _maxSpool   = 200;
private _now        = time;
private _path  = _uav getVariable ["vnd_fiber_path", []];
private _uavPos = _uav modelToWorldVisual [0, -0.10, 0.075];

if (_path isEqualTo []) then {
    _path pushBack _uavPos;
};

private _last = _path select (count _path - 1);
if ((_last distance _uavPos) > _anchorDist) then {
    _path pushBack _uavPos;
};

private _len = 0;
for "_i" from 0 to (count _path - 2) do {
    _len = _len + ((_path select _i) distance (_path select (_i + 1)));
};
while { _len > _maxSpool && (count _path > 2) } do {
    _path deleteAt 0;
    _len = 0;
    for "_i" from 0 to (count _path - 2) do {
        _len = _len + ((_path select _i) distance (_path select (_i + 1)));
    };
};

private _rawPath = +_path;  

private _lastSag = _uav getVariable ["vnd_lastSag", time];
private _dt      = _now - _lastSag;
_uav setVariable ["vnd_lastSag", _now];
_path = [_path, _dt] call DB_vnd_fnc_fpv_applyGravity;
_uav  setVariable ["vnd_fiber_path", _path, false];

private _lastSync = _uav getVariable ["vnd_lastSync", 0];
if ((_now - _lastSync) >= 0.25) then {
    _uav setVariable ["vnd_lastSync", _now];
    [_uav, _rawPath] remoteExecCall ["DB_vnd_fnc_fpv_receivePath", -clientOwner, _uav];
};

if !(missionNamespace getVariable ["vnd_showFiber", true]) then {
    if !(_path isEqualTo []) then {
        _uav setVariable ["vnd_fiber_path", [], false];
    };
};
