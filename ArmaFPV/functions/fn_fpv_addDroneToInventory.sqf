params ["_uav", "_player"];

if (isNull _uav || {isNull _player}) exitWith {};

private _itemType = "";
private _uavType = typeOf _uav;

if (_uavType find "_AP" > -1) then {
        _itemType = "Item_Crocus_AP";
} else {
        if (_uavType find "_AT" > -1) then {
                _itemType = "Item_Crocus_AT";
        };
};

if (_itemType isEqualTo "") exitWith {};
if !(_player canAdd _itemType) exitWith {};

_player addItem _itemType;

{
        deleteVehicle _x;
} forEach attachedObjects _uav;

deleteVehicle _uav;

_player action ["TakeBag", objNull];
