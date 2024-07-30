params ["_uav"];

private _itemType = ["Item_Mavic3T", "Item_Mavic"] select ((typeOf _uav) isKindOf "mavic_drone_base_F");

alive _uav && player canAdd _itemType && cameraOn == player && {((speed _uav) < 1) && {!(isEngineOn _uav)}}