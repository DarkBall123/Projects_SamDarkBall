("DB_Orlan_Layer" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

private _prevHUD = missionNamespace getVariable ["DB_orlan_prevHud", true];
			
showHUD _prevHUD;

sleep 0.5;

"DynamicBlur" ppEffectEnable false;
"filmGrain" ppEffectEnable false;
"ColorCorrections" ppEffectEnable false;