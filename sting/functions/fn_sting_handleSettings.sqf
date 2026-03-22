/*
	Sting: apply UI/UAV settings.
	Purpose: updates OSD badge text and captive mode for FPV drones.
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
	private _mainText = GETUVAR(Sting_ModeText, controlNull);
	private _badgeText = "S";

	if (_isValid && { _defaultText != "" }) then {
		private _chars = toArray _defaultText;
		if !(_chars isEqualTo []) then {
			_badgeText = toUpper toString [_chars # 0];
		};
	};

	if (!isNull _mainText && { !isNull _player }) then {
		_mainText ctrlSetText _badgeText;
	};
};

private _droneTypes = GETMVAR(DB_sting_droneTypes, STING_DRONE_TYPES);
if (_droneTypes isEqualTo []) exitWith {};

if (isServer) then {
	{
		_x setCaptive _isCaptive;
	} forEach (vehicles select { (typeOf _x) in _droneTypes });
};
