params ["_vehicle"];

private _panels = [];
private _seatEntries = [];
private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
if (isNull _unit) then {
    _unit = player;
};

{
    _x params ["_roleFilter", "_defaultLabel", "_iconPath"];

    private _seatData = fullCrew [_vehicle, _roleFilter, true];

    {
        _x params ["_occupant", "_role", "_cargoIndex", "_turretPath", "_personTurret", "_assignedUnit", "_positionName"];
        private _normalizedRole = toLowerANSI _role;

        if (
            isNull _occupant &&
            {isNull _assignedUnit || {_assignedUnit isEqualTo _unit}} &&
            {!(_normalizedRole isEqualTo "turret" && {_personTurret})}
        ) then {
            private _seatLabel = _defaultLabel;

            if !(_positionName isEqualTo "") then {
                _seatLabel = localize _positionName;

                if (_seatLabel isEqualTo _positionName && {(_positionName find "$STR_") isEqualTo 0}) then {
                    _seatLabel = _defaultLabel;
                };
            };

            private _seatIndex = if (_normalizedRole isEqualTo "cargo") then {
                _forEachIndex + 1
            } else {
                0
            };

            _seatEntries pushBack [
                "action",
                ["seat", _vehicle, _normalizedRole, _cargoIndex, _turretPath, _personTurret],
                _seatIndex,
                _iconPath,
                _seatLabel
            ];
        };
    } forEach _seatData;
} forEach [
    ["driver", "Driver", "\a3\ui_f\data\igui\cfg\actions\getindriver_ca.paa"],
    ["commander", "Commander", "\a3\ui_f\data\igui\cfg\actions\getincommander_ca.paa"],
    ["gunner", "Gunner", "\a3\ui_f\data\igui\cfg\actions\getingunner_ca.paa"],
    ["turret", "Turret", "\a3\ui_f\data\igui\cfg\actions\getingunner_ca.paa"],
    ["cargo", "Passenger", "\a3\ui_f\data\igui\cfg\actions\getincargo_ca.paa"]
];

if !(_seatEntries isEqualTo []) then {
    _panels pushBack ["seats", "\a3\ui_f\data\igui\cfg\actions\getindriver_ca.paa", "Seats", _seatEntries];
};

private _cargoPanels = [_vehicle] call DB_dsi_fnc_inv_buildCargoPanel;
if !(_cargoPanels isEqualTo []) then {
    private _cargoPanel = +(_cargoPanels # 0);
    _cargoPanel set [1, "\a3\ui_f\data\igui\cfg\actions\gear_ca.paa"];
    _cargoPanel set [2, "Cargo"];
    _panels pushBack _cargoPanel;
};

_panels
