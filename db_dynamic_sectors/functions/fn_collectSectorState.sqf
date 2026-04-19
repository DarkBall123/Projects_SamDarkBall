params
[
    ["_units", allUnits],
    ["_gridSize", missionNamespace getVariable ["DB_DS_gridSize", [] call DB_DS_fnc_pickGridSize]]
];

private _sectorLookup = missionNamespace getVariable ["DB_DS_sectorLookup", createHashMap];
private _stateLookup = createHashMap;

{
    private _unit = _x;

    if (alive _unit) then
    {
        private _unitSide = side group _unit;

        if (_unitSide in [west, east, resistance]) then
        {
            private _carrier = vehicle _unit;
            private _canAffectSector = (_carrier isKindOf "CAManBase") || {isTouchingGround _carrier};

            if (_canAffectSector) then
            {
                private _position = getPosWorld _carrier;
                private _xIndex = floor ((_position # 0) / _gridSize);
                private _yIndex = floor ((_position # 1) / _gridSize);
                private _cellKey = format ["%1_%2", _xIndex, _yIndex];
                private _sectorId = _sectorLookup getOrDefault [_cellKey, -1];

                if (_sectorId >= 0) then
                {
                    private _counts = _stateLookup getOrDefault [_sectorId, [0, 0, 0]];

                    switch (_unitSide) do
                    {
                        case west:
                        {
                            _counts set [0, (_counts # 0) + 1];
                        };
                        case east:
                        {
                            _counts set [1, (_counts # 1) + 1];
                        };
                        default
                        {
                            _counts set [2, (_counts # 2) + 1];
                        };
                    };

                    _stateLookup set [_sectorId, _counts];
                };
            };
        };
    };
} forEach _units;

private _sectorState = [];

{
    private _sectorId = _x;
    private _counts = _y;

    _sectorState pushBack
    [
        _sectorId,
        _counts # 0,
        _counts # 1,
        _counts # 2
    ];
} forEach _stateLookup;

_sectorState sort true;
_sectorState
