("DB_AK603_Layer" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

private _prevHUD = missionNamespace getVariable ["DB_AK603_prevHud", true];
showHUD _prevHUD;