private _target = objNull;
private _maxDistance = 4.5;

{
    if (
        isNull _target &&
        {!isNull _x} &&
        {!(_x isEqualTo player)} &&
        {player distance _x <= _maxDistance}
    ) then {
        _target = _x;
    };
} forEach [cursorObject, cursorTarget];

if (isNull _target) then {
    _target = player;
};

_target
