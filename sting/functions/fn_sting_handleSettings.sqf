/*
	Sting: apply UI/UAV settings.
	Purpose: updates the OSD badge text for FPV drones.
	Context: client when the UI starts.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

if (!hasInterface) exitWith {};

private _mainText = GETUVAR(Sting_ModeText, controlNull);
if (!isNull _mainText) then {
	_mainText ctrlSetText "S";
};
