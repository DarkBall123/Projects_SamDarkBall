params
[
    ["_sectorId", -1],
    ["_styleId", -1]
];

if (_sectorId < 0 || { _styleId < 0 }) exitWith { false };

private _sectorState = missionNamespace getVariable ["DZ_sectorVisualState", []];

if (_sectorId >= count _sectorState) exitWith { false };
if ((_sectorState # _sectorId) isEqualTo _styleId) exitWith { false };

_sectorState set [_sectorId, _styleId];
missionNamespace setVariable ["DZ_sectorVisualState", _sectorState];

true
