("DB_Orion_Layer_Gunner" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
("DB_Orion_Layer_Driver" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

private _prevHUD = missionNamespace getVariable ["DB_orion_prevHud", true];
			
showHUD _prevHUD;

missionNamespace setVariable ["fn_orion_currentRole", ""];

sleep 0.5;

"DynamicBlur" ppEffectEnable false;
"filmGrain" ppEffectEnable false;
"ColorCorrections" ppEffectEnable false;