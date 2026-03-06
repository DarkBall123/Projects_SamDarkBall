private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _unit) then {
    _unit = player;
};

private _target = objNull;
private _maxDistance = 4.5;

{
    if (
        isNull _target &&
        {!isNull _x} &&
        {!(_x isEqualTo _unit)} &&
        {_unit distance _x <= _maxDistance}
    ) then {
        _target = _x;
    };
} forEach [cursorObject, cursorTarget];

if (isNull _target) then {
    _target = _unit;
};

_target
