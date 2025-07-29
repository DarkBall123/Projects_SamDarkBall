params [["_uav", getConnectedUAV player]];

private _statusHUD = shownHUD;
private _layer     = ("DB_vnd_FPV_Layer" call BIS_fnc_rscLayer);

_layer cutRsc ["vnd_Dialog","PLAIN"];
showHUD [true,false,false,false,false,false,false,true];

missionNamespace setVariable ["DB_vnd_FPV_hudStatus", _statusHUD];
missionNamespace setVariable ["DB_vnd_FPV_Layer_ID",  _layer];

[_uav] call DB_vnd_fnc_fpv_uiAnimate;
