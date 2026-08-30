params ["_uav"];

private _typeParts = typeOf _uav splitString "_";
private _coreType  = _typeParts select [2, count _typeParts - 2] joinString "_";
private _itemType = format ["frtz_Item_%1", _coreType];
private _validItems = missionNamespace getVariable ["DB_kvn_fpv_dronesArray_items", []];

(_itemType in _validItems) && {alive _uav && player canAdd _itemType && cameraOn == player && {((speed _uav) < 1) && {!(isEngineOn _uav)}}}
