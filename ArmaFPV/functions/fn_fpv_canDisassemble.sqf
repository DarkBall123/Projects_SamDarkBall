params ["_uav"];

if (isNull _uav) exitWith {false};

private _player = player;

if (!alive _uav) exitWith {false};
if (cameraOn != _player) exitWith {false};
if (speed _uav >= 1) exitWith {false};
if (isEngineOn _uav) exitWith {false};

private _uavType = typeOf _uav;
private _itemType = "";

switch (true) do {
        case (_uavType find "_AP_TI" > -1): {
                _itemType = "Item_Crocus_AP_TI";
        };
        case (_uavType find "_AT_TI" > -1): {
                _itemType = "Item_Crocus_AT_TI";
        };
        case (_uavType find "_AP" > -1): {
                _itemType = "Item_Crocus_AP";
        };
        case (_uavType find "_AT" > -1): {
                _itemType = "Item_Crocus_AT";
        };
};

if (_itemType isEqualTo "") exitWith {false};

_player canAdd _itemType
