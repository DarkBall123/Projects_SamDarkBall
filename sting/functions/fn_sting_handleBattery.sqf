/*
	Sting: battery handler.
	Purpose: updates battery percentage, inner battery progress bar and estimated remaining flight time on the OSD.
	Context: client, active only while controlling the drone.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

private _formatRemainingTime = {
	params ["_seconds"];

	private _clamped = _seconds max 0;
	private _mins = floor (_clamped / 60);
	private _secs = floor (_clamped mod 60);
	private _mm = if (_mins < 10) then { format ["0%1", _mins] } else { str _mins };
	private _ss = if (_secs < 10) then { format ["0%1", _secs] } else { str _secs };

	format ["%1'%2%3", _mm, _ss, toString [34]]
};

private _prevPfh = GETMVAR(DB_sting_batteryPFH, -1);
if (_prevPfh >= 0) then {
	[_prevPfh] call CBA_fnc_removePerFrameHandler;
};

private _pfhId = [{
	_this params ["_args", "_handle"];
	_args params ["_formatRemainingTime", "_lastShownRemainingSeconds"];
	private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
	private _uav = getConnectedUAV _player;

	if (isNull _player || { isNull _uav }) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _currentBattery = (fuel _uav) max 0 min 1;
	private _batteryText = GETUVAR(Sting_BatteryValueText, controlNull);
	private _remainingText = GETUVAR(Sting_RemainingTimeText, controlNull);
	private _batteryPicture = GETUVAR(Sting_BatteryPicture, controlNull);
	private _batteryBarFill = GETUVAR(Sting_BatteryBarFill, controlNull);
	private _batteryPercent = round (_currentBattery * 100);
	private _remainingSeconds = floor (STING_ESTIMATED_ENDURANCE_SECONDS * _currentBattery);

	if (!isNull _batteryText) then {
		_batteryText ctrlSetText str _batteryPercent;
		_batteryText ctrlSetTextColor [1, 1, 1, 1];
	};

	if (!isNull _remainingText) then {
		if (_remainingSeconds != _lastShownRemainingSeconds) then {
			_remainingText ctrlSetText ([_remainingSeconds] call _formatRemainingTime);
			_args set [1, _remainingSeconds];
		};
		_remainingText ctrlSetTextColor [1, 1, 1, 1];
	};

	if (!isNull _batteryPicture) then {
		_batteryPicture ctrlSetTextColor [1, 1, 1, 1];
	};

	private _batteryBarBackground = GETUVAR(Sting_BatteryBarBackground, controlNull);
	if (!isNull _batteryBarBackground) then {
		_batteryBarBackground ctrlSetBackgroundColor [0.22, 0.22, 0.22, 0.65];
	};

	if (!isNull _batteryBarFill) then {
		_batteryBarFill ctrlSetTextColor [0.55, 0.55, 0.55, 0.9];
		_batteryBarFill progressSetPosition _currentBattery;
	};

	if !(GETMVAR(Sting_isControl, false)) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 0.2, [_formatRemainingTime, -1]] call CBA_fnc_addPerFrameHandler;

SETMVAR(DB_sting_batteryPFH, _pfhId);
