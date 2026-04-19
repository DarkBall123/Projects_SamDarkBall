params
[
    ["_gridSize", [] call DB_DS_fnc_pickGridSize],
    ["_mapSize", worldSize]
];

private _sectorGrid = [];
private _sectorLookup = createHashMap;
private _halfSize = _gridSize * 0.5;
private _sectorId = 0;

for "_xPos" from _halfSize to (_mapSize - _halfSize) step _gridSize do
{
    private _xIndex = floor (_xPos / _gridSize);

    for "_yPos" from _halfSize to (_mapSize - _halfSize) step _gridSize do
    {
        private _center = [_xPos, _yPos, 0];

        if ([_center, _halfSize] call DB_DS_fnc_isLandSector) then
        {
            private _yIndex = floor (_yPos / _gridSize);
            private _cellKey = format ["%1_%2", _xIndex, _yIndex];

            _sectorGrid pushBack [_sectorId, _xPos, _yPos];
            _sectorLookup set [_cellKey, _sectorId];

            _sectorId = _sectorId + 1;
        };
    };
};

[_sectorGrid, _sectorLookup]
