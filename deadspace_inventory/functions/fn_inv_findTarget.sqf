private _target = objNull;

{
    if (
        isNull _target &&
        {!isNull _x} &&
        {!(_x isEqualTo player)} &&
        {player distance _x <= 6}
    ) then {
        _target = _x;
    };
} forEach [cursorObject, cursorTarget];

if (isNull _target) then {
    _target = player;
};

_target
