/*
	ArmaFPV: UI/effects cleanup.
	Purpose: hides the OSD and removes post-process effects.
	Context: client when leaving FPV control.
	Params: stopEffects (Bool, default true) - also stops PPFX when true.
	Returns: nothing.
*/

#include "\ArmaFPV\script_macros.hpp"

params [
	["_stopEffects", true, [true]]
];

private _clearEffects = {
	private _stopEffects = _this;
	if (!(_stopEffects isEqualType true)) then {
		_stopEffects = true;
	};

	private _layer = GETMVAR(DB_FPV_Layer_ID, -1);
	if (_layer >= 0) then {
		_layer cutText ["", "PLAIN"];
	};

	private _uiVars = [
		["ArmaFPV_Display", displayNull],
		["ArmaFPV_SignalPicture", controlNull],
		["ArmaFPV_SignalText", controlNull],
		["ArmaFPV_CompassGroup", controlNull],
		["ArmaFPV_CompassN", controlNull],
		["ArmaFPV_CompassE", controlNull],
		["ArmaFPV_CompassS", controlNull],
		["ArmaFPV_CompassW", controlNull],
		["ArmaFPV_HeadingText", controlNull],
		["ArmaFPV_VBarLeft", controlNull],
		["ArmaFPV_VBarRight", controlNull],
		["ArmaFPV_VPointerLeft", controlNull],
		["ArmaFPV_VPointerRight", controlNull],
		["ArmaFPV_AltText", controlNull],
		["ArmaFPV_RightText", controlNull],
		["ArmaFPV_DefaultText", controlNull],
		["ArmaFPV_LeftVoltText", controlNull],
		["ArmaFPV_LeftCurrentText", controlNull],
		["ArmaFPV_LeftMahText", controlNull],
		["ArmaFPV_BatteryPicture", controlNull],
		["ArmaFPV_RightVoltText", controlNull],
		["ArmaFPV_TimeText", controlNull]
	];

	{
		uiNamespace setVariable [_x # 0, _x # 1];
	} forEach _uiVars;

	if (_stopEffects) then {
		call DB_fnc_fpv_ppfx_stop;
	};
};

_stopEffects call _clearEffects;

[
	{
		params ["_clearEffects", "_stopEffects"];
		_stopEffects call _clearEffects;
	},
	[_clearEffects, _stopEffects],
	1
] call CBA_fnc_waitAndExecute;
