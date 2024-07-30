params ["_object"];

private _playerPos = getPosATL _object;
private _containers = nearestObjects [_playerPos, ["All"], 15];
private _found = false;

{
    private _mags = getMagazineCargo _x # 0;
    private _magType = "zala421_dummy_mag";
    if (_magType in _mags) then {
        _found = true;
    };
} forEach _containers;

_found;
