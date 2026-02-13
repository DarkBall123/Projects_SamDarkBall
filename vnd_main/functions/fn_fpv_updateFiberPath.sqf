#include "\vnd_main\script_macros.hpp"

params ["_uav"];
if (isNull _uav) exitWith {};

private _dArr = GETMVAR(DB_vnd_fpv_dronesArray, []);
if !(typeOf _uav in _dArr) exitWith {};

private _recalcPathLen = {
    params ["_nodes"];
    private _len = 0;
    for "_i" from 0 to ((count _nodes) - 2) do {
        _len = _len + ((_nodes # _i) distance (_nodes # (_i + 1)));
    };
    _len
};

private _now = time;
private _path = +(_uav getVariable ["vnd_fiber_path", []]);
private _uavPos = _uav modelToWorldVisual [0, -0.10, 0.075];

private _fiberLen = _uav getVariable ["vnd_fiber_len", -1];
if (_fiberLen < 0) then {
    _fiberLen = [_path] call _recalcPathLen;
};

private _syncTrim = _uav getVariable ["vnd_syncTrim", 0];
private _syncAppend = +(_uav getVariable ["vnd_syncAppend", []]);

if (_path isEqualTo []) then {
    _path pushBack _uavPos;
    _fiberLen = 0;
    _syncAppend pushBack _uavPos;
};

private _last = _path # ((count _path) - 1);
private _lastToUav = _last distance _uavPos;
if (_lastToUav > VND_FIBER_ANCHOR_DIST) then {
    _path pushBack _uavPos;
    _fiberLen = _fiberLen + _lastToUav;
    _syncAppend pushBack _uavPos;
};

while { _fiberLen > VND_FIBER_MAX_SPOOL && { count _path > 1 } } do {
    private _first = _path # 0;
    private _second = _path # 1;
    _fiberLen = _fiberLen - (_first distance _second);
    if (_fiberLen < 0) then { _fiberLen = 0; };
    _path deleteAt 0;
    _syncTrim = _syncTrim + 1;
};

if (_fiberLen < 0) then {
    _fiberLen = [_path] call _recalcPathLen;
};

private _lastSag = _uav getVariable ["vnd_lastSag", 0];
private _sagDt = _now - _lastSag;
if (_sagDt >= VND_FIBER_GRAVITY_INTERVAL) then {
    _path = [_path, _sagDt] call DB_vnd_fnc_fpv_applyGravity;
    _uav setVariable ["vnd_lastSag", _now];
};

_uav setVariable ["vnd_fiber_path", _path, false];
_uav setVariable ["vnd_fiber_len", _fiberLen, false];

private _lastSnapshot = _uav getVariable ["vnd_lastSnapshotSync", 0];
if ((_now - _lastSnapshot) >= VND_FIBER_SNAPSHOT_INTERVAL) then {
    [_uav, ["snapshot", +_path]] remoteExecCall ["DB_vnd_fnc_fpv_receivePath", -clientOwner, _uav];
    _uav setVariable ["vnd_lastSnapshotSync", _now];
    _uav setVariable ["vnd_lastSync", _now];
    _syncTrim = 0;
    _syncAppend = [];
} else {
    private _lastSync = _uav getVariable ["vnd_lastSync", 0];
    if ((_now - _lastSync) >= VND_FIBER_SYNC_INTERVAL && { _syncTrim > 0 || { count _syncAppend > 0 } }) then {
        [_uav, ["delta", _syncTrim, +_syncAppend]] remoteExecCall ["DB_vnd_fnc_fpv_receivePath", -clientOwner, _uav];
        _uav setVariable ["vnd_lastSync", _now];
        _syncTrim = 0;
        _syncAppend = [];
    };
};

_uav setVariable ["vnd_syncTrim", _syncTrim, false];
_uav setVariable ["vnd_syncAppend", _syncAppend, false];
