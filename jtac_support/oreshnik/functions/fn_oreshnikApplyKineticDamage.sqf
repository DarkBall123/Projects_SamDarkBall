params [
    ["_impactATL", [0, 0, 0], [[]]],
    ["_settings", createHashMap, [createHashMap]]
];

if (!isServer) exitWith { false };

private _radius = (_settings getOrDefault ["damageRadius", 14]) max 1;
private _maxDamage = (_settings getOrDefault ["maxDamage", 0.7]) max 0;
_maxDamage = _maxDamage min 0.9;

private _targets = nearestObjects [_impactATL, ["CAManBase", "LandVehicle", "Air", "Ship", "StaticWeapon"], _radius, true];

{
    if (alive _x) then {
        private _distance = (_x distance _impactATL) min _radius;
        private _falloff = 1 - (_distance / _radius);
        private _damageAdd = _maxDamage * _falloff;
        _x setDamage (((damage _x) + _damageAdd) min 0.95);
    };
} forEach _targets;

true;
