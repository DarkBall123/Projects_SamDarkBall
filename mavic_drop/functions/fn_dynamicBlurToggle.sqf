params [
	["_statement", "ONLOAD"]
];

switch ( toUpper _statement ) do {
	case "ONLOAD": {
		[
			{
				"dynamicBlur" ppEffectEnable true; 
                "dynamicBlur" ppEffectAdjust [2];
                "dynamicBlur" ppEffectCommit 0.5;
			}, 
			[], 
			0.1
		] call CBA_fnc_waitAndExecute;
	};

	case "UNLOAD": {
		[
			{
				"dynamicBlur" ppEffectEnable true; 
                "dynamicBlur" ppEffectAdjust [0];
                "dynamicBlur" ppEffectCommit 0.5;
			}, 
			[], 
			0.1
		] call CBA_fnc_waitAndExecute;
	};
	default { };
};