("DB_zala421_Layer_Gunner" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
("DB_zala421_Layer_Driver" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];

private _prevHUD = missionNamespace getVariable ["DB_zala421_prevHud", true];
			
showHUD _prevHUD;

missionNamespace setVariable ["fn_zala421_currentRole", ""];

[{
    "DynamicBlur" ppEffectEnable false;
    "filmGrain" ppEffectEnable false;
    "ColorCorrections" ppEffectEnable false;
}, [], 0.5] call CBA_fnc_waitAndExecute;