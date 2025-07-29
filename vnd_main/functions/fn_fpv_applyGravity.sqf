#define DROP_RATE 4
#define MARGIN    0.05
#define MAX_RAY   120

params ["_path", "_dt"];
if (_path isEqualTo [] || _dt <= 0) exitWith { _path };

for "_i" from 0 to (count _path - 2) do {
    private _pAGL = _path # _i;
    private _pASL = AGLToASL _pAGL;

    private _currZ = _pASL # 2;
    private _rayDepth = (_currZ + 5) min MAX_RAY;

    private _hit = lineIntersectsSurfaces [
        _pASL vectorAdd [0,0,0.1],
        _pASL vectorAdd [0,0,-_rayDepth],
        objNull, objNull, true, 1, "VIEW", "GEOM"
    ];

    private _groundZ = if (_hit isEqualTo []) then { getTerrainHeightASL _pASL } else { (((_hit select 0) select 0) select 2) };
    private _targetZ = _groundZ + MARGIN;

    if (_currZ > _targetZ) then {
        private _newZ = _currZ - DROP_RATE * _dt;
        if (_newZ < _targetZ) then { _newZ = _targetZ };
        _pASL set [2, _newZ];
        _path set [_i, ASLToAGL _pASL];
    };
};


_path
