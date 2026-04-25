private _layer = missionNamespace getVariable ["DB_kvn_FPV_Layer_ID", -1];
_layer cutText ["","PLAIN"];

private _hud = missionNamespace getVariable ["DB_kvn_FPV_hudStatus", true];
showHUD _hud;

private _eh = missionNamespace getVariable ["kvn_osdEH",-1];
if (_eh >= 0) then { removeMissionEventHandler ["Draw3D", _eh]; missionNamespace setVariable ["kvn_osdEH",-1]; };
