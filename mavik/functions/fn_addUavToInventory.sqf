params ["_uav", "_player"];

private _itemType = ["Item_Mavic3T", "Item_Mavic"] select ((typeOf _uav) isKindOf "mavic_drone_base_F");

_player addItem _itemType;

{
  deleteVehicle _x;
} forEach attachedObjects _uav;

deleteVehicle _uav;

_player action ["TakeBag", objNull];