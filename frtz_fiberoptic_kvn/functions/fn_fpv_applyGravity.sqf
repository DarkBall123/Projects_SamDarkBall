#define DROP_RATE 4
#define MARGIN    0.05
#define MAX_RAY   120

params ["_path", "_dt"];
if ((count _path) < 2 || {_dt <= 0}) exitWith { _path };

private _fall = DROP_RATE * _dt;
private _checks = [];
private _indexes = [];

for "_i" from 0 to (count _path - 2) do {
    private _pAGL = _path # _i;
    private _pASL = AGLToASL _pAGL;
    private _currZ = _pASL # 2;
    private _terrainZ = getTerrainHeightASL _pASL;

    if (_currZ > (_terrainZ + MARGIN + 0.02)) then {
        private _rayDepth = ((_currZ - _terrainZ) + 5) min MAX_RAY;
        _indexes pushBack [_i, _pASL, _terrainZ];
        _checks pushBack [
            _pASL vectorAdd [0,0,0.1],
            _pASL vectorAdd [0,0,-_rayDepth],
            objNull, objNull, true, 1, "VIEW", "GEOM"
        ];
    };
};

if (_checks isEqualTo []) exitWith { _path };

private _hits = lineIntersectsSurfaces _checks;

for "_i" from 0 to (count _indexes - 1) do {
    (_indexes # _i) params ["_pathIndex", "_pASL", "_terrainZ"];
    private _hit = _hits # _i;
    private _groundZ = if (_hit isEqualTo []) then { _terrainZ } else { (((_hit # 0) # 0) # 2) };
    private _targetZ = _groundZ + MARGIN;
    private _currZ = _pASL # 2;

    if (_currZ > _targetZ) then {
        private _newZ = _currZ - _fall;
        if (_newZ < _targetZ) then { _newZ = _targetZ };
        _pASL set [2, _newZ];
        _path set [_pathIndex, ASLToAGL _pASL];
    };
};

_path
