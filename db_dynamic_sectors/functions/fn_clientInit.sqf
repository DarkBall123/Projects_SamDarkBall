if (!hasInterface) exitWith {};

if (missionNamespace getVariable ["DB_DS_clientInitDone", false]) exitWith {};
missionNamespace setVariable ["DB_DS_clientInitDone", true];

[
    {
        !isNil { missionNamespace getVariable "DB_DS_sectorGrid" } &&
        !isNil { missionNamespace getVariable "DB_DS_gridSize" } &&
        !isNil { missionNamespace getVariable "DB_DS_sectorStatePayload" }
    },
    {
        private _sectorGrid = missionNamespace getVariable ["DB_DS_sectorGrid", []];
        private _gridSize = missionNamespace getVariable ["DB_DS_gridSize", 1000];
        private _halfSize = _gridSize * 0.5;
        private _sectorMarkers = [];
        private _sideBrushes = ["BDiagonal", "FDiagonal", "Vertical"];
        private _sideColors =
        [
            "#(0.16,0.43,0.96)",
            "#(0.92,0.18,0.16)",
            "#(0.14,0.78,0.24)"
        ];

        {
            _x params ["_sectorId", "_centerX", "_centerY"];

            private _markerPos = [_centerX, _centerY, 0];
            private _baseMarker = createMarkerLocal [format ["DB_DS_%1_base", _sectorId], _markerPos];
            private _westMarker = createMarkerLocal [format ["DB_DS_%1_west", _sectorId], _markerPos];
            private _eastMarker = createMarkerLocal [format ["DB_DS_%1_east", _sectorId], _markerPos];
            private _indMarker = createMarkerLocal [format ["DB_DS_%1_ind", _sectorId], _markerPos];
            private _overlayMarkers = [_westMarker, _eastMarker, _indMarker];

            {
                _x setMarkerShapeLocal "RECTANGLE";
                _x setMarkerSizeLocal [_halfSize, _halfSize];
                _x setMarkerTextLocal "";
            } forEach ([_baseMarker] + _overlayMarkers);

            _baseMarker setMarkerBrushLocal "SolidFull";
            _baseMarker setMarkerColorLocal "#(0.52,0.52,0.52)";
            _baseMarker setMarkerAlphaLocal 0;

            {
                _x setMarkerBrushLocal (_sideBrushes # _forEachIndex);
                _x setMarkerColorLocal (_sideColors # _forEachIndex);
                _x setMarkerAlphaLocal 0;
            } forEach _overlayMarkers;

            _sectorMarkers pushBack [_baseMarker, _westMarker, _eastMarker, _indMarker];
        } forEach _sectorGrid;

        missionNamespace setVariable ["DB_DS_sectorMarkers", _sectorMarkers];
        missionNamespace setVariable ["DB_DS_activeSectorIds", []];
        missionNamespace setVariable ["DB_DS_lastPayloadRevision", -1];
        missionNamespace setVariable ["DB_DS_renderedSectorState", createHashMap];

        {
            [_forEachIndex, [0, 0, 0]] call DB_DS_fnc_renderSectorState;
        } forEach _sectorMarkers;

        [missionNamespace getVariable ["DB_DS_sectorStatePayload", [0, []]]] call DB_DS_fnc_handleStateUpdate;

        private _pfhId =
        [
            {
                private _payload = missionNamespace getVariable ["DB_DS_sectorStatePayload", [0, []]];
                private _revision = _payload # 0;
                private _lastRevision = missionNamespace getVariable ["DB_DS_lastPayloadRevision", -1];

                if (_revision != _lastRevision) then
                {
                    [_payload] call DB_DS_fnc_handleStateUpdate;
                };
            },
            0.25,
            []
        ] call CBA_fnc_addPerFrameHandler;

        missionNamespace setVariable ["DB_DS_clientPfhId", _pfhId];
    },
    []
] call CBA_fnc_waitUntilAndExecute;
