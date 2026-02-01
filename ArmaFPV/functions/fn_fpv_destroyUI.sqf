/*
	ArmaFPV: UI/effects cleanup.
	Purpose: hides the OSD and removes post-process effects.
	Context: client when leaving FPV control.
	Params: none.
	Returns: nothing.
*/

#include "\ArmaFPV\script_macros.hpp"

params [
	["_keepPpfx", false, [false]]
];

private _clearEffects = {
	params ["_keepPpfx"];
	private _layer = GETMVAR(DB_FPV_Layer_ID, -1);
	if (_layer >= 0) then {
		_layer cutText ["", "PLAIN"];
	};

	if (!_keepPpfx) then {
		call DB_fnc_fpv_ppfx_stop;
	};
};

[_keepPpfx] call _clearEffects;

[
	{
		params ["_clearEffects", "_keepPpfx"];
		[_keepPpfx] call _clearEffects;
	},
	[_clearEffects, _keepPpfx],
	1
] call CBA_fnc_waitAndExecute;
