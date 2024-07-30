//Spawns a drone with a grenade attached
private _drone 		= param[0];
private _grenade 	= param[1,"G_40mm_Drone"];

if(is3DEN) exitWith {};

//private _offset = [[0, 0, -0.12], [0, 0, 0.1]] select ((typeOf _drone) == "mavik_3");

//waitUntil {time > 0 and !is3DEN};
private _attachedGrenades = _drone getVariable ["grenadeObj", []];
private _grenadeAmmo = getText(configFile >> "CfgMagazines" >> _grenade >> "ammo");

private _selection = [[-0.02, 0, -0.04], [0.02, 0, -0.04]] select (count _attachedGrenades > 0);

_attachedGrenades pushBack [_grenade, _grenadeAmmo];

_gren = _grenadeAmmo createVehicle [0,0,1000];
_gren setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; 
_gren attachTo [_drone, _selection]; 
_drone setVariable ["grenadeObj", _attachedGrenades, true];

