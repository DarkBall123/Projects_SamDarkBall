params ["_caller"];

_vehicle = getConnectedUAV _caller;

if ((typeOf _vehicle) in ["mavik_3_OPF", "mavik_3_BLU", "mavik_3_IND", "mavik_3T_OPF", "mavik_3T_BLU", "mavik_3T_IND"]) then {
	[missionNamespace, "DB_mavic_showMessage", []] call BIS_fnc_callScriptedEventHandler;
};

private _attachedGrenades = _vehicle getVariable ["grenadeObj", []];

//detach old grenade
_droneVelocity = velocity _vehicle;
_oldGren = (attachedObjects _vehicle) select 0;
_oldGrenType = typeOf _oldGren;

_wind = wind;
_windEffectMultiplier = (missionNamespace getVariable ["Mavic_windCoef", 0.1/0.9]);
_grenadeMass = (getNumber(configFile >> "CfgAmmo" >> _oldGrenType >> "mavic_weight") / 1000) max 0.200;  // кг
_scaledWind = [
  (_wind select 0) * _windEffectMultiplier / _grenadeMass, 
  (_wind select 1) * _windEffectMultiplier / _grenadeMass
];

deleteVehicle _oldGren;

_grenade = _oldGrenType createVehicle [0,0,1000];
[_grenade, _vehicle] remoteExecCall ["disableCollisionWith", 0, _vehicle];
_grenade setPos (_vehicle modelToWorld [0, 0, -0.3]);

_grenade setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
_grenade setVelocity [
	(_droneVelocity select 0) + (_scaledWind select 0), 
	(_droneVelocity select 1) + (_scaledWind select 1), 
	-3 // hardcoded
];	

_attachedGrenades deleteAt (_attachedGrenades findIf { _oldGrenType in _x });

_vehicle setVariable ["grenadeType", ""];
_vehicle setVariable ["grenadeObj", _attachedGrenades, true];

//Re initialize drone
//[_vehicle] call mavic_drop_fnc_makeGrenadeDrone;