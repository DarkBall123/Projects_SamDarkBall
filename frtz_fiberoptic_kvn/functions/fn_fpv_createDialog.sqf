params [["_uav", getConnectedUAV player]];

private _statusHUD = shownHUD;
private _layer     = ("DB_kvn_FPV_Layer" call BIS_fnc_rscLayer);

_layer cutRsc ["kvn_Dialog","PLAIN"];
showHUD [true,false,false,false,false,false,false,true];

missionNamespace setVariable ["DB_kvn_FPV_hudStatus", _statusHUD];
missionNamespace setVariable ["DB_kvn_FPV_Layer_ID",  _layer];

[_uav] call DB_kvn_fnc_fpv_uiAnimate;
