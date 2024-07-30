params ["_uav"];

("DB_Mavic_Layer" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

private _prevHUD = missionNamespace getVariable ["DB_mavic_prevHud", true];
showHUD _prevHUD;

(uiNamespace getVariable ["DB_gradient_control", controlNull]) ctrlShow false;

sleep 0.5;

if !(isNil "DB_PP_dynamic") then { DB_PP_dynamic ppEffectEnable false; DB_PP_dynamic ppEffectCommit 0;  };
if !(isNil "DB_SIGNAL_PP_dynamic") then { DB_SIGNAL_PP_dynamic ppEffectEnable false; DB_SIGNAL_PP_dynamic ppEffectCommit 0; };