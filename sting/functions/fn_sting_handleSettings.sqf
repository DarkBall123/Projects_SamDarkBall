/*
	Sting: apply UI/UAV settings.
	Purpose: updates OSD text and captive mode for FPV drones.
	Context: client or server when settings change or UI starts.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

private _defaultText = GETMVAR(STING_DefaultText, "STING");
private _isCaptive = GETMVAR(STING_isUavCaptive, true);
private _textArray = toArray _defaultText;
private _allowedChars = toArray "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,;\\/ ";

private _isValid = true;
{
	if !(_x in _allowedChars) exitWith { _isValid = false; };
} forEach _textArray;

if (hasInterface) then {
	private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
	private _mainText = GETUVAR(Sting_DefaultText, controlNull);

	if (!isNull _mainText && { !isNull _player }) then {
		if (_isValid) then {
			_mainText ctrlSetText _defaultText;
		} else {
			_mainText ctrlSetText "";
		};
	};
};

private _droneTypes = GETMVAR(DB_sting_droneTypes, STING_DRONE_TYPES);
if (_droneTypes isEqualTo []) exitWith {};

if (isServer) then {
	{
		_x setCaptive _isCaptive;
	} forEach (vehicles select { (typeOf _x) in _droneTypes });
};
