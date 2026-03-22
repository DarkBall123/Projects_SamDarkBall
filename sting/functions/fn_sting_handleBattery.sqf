/*
	Sting: battery handler.
	Purpose: updates battery percentage and estimated remaining flight time on the OSD.
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
	_args params ["_formatRemainingTime"];
	private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
	private _uav = getConnectedUAV _player;

	if (isNull _player || { isNull _uav }) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _currentBattery = (fuel _uav) max 0 min 1;
	private _batteryText = GETUVAR(Sting_BatteryValueText, controlNull);
	private _remainingText = GETUVAR(Sting_RemainingTimeText, controlNull);
	private _batteryPicture = GETUVAR(Sting_BatteryPicture, controlNull);
	private _batteryPercent = round (_currentBattery * 100);
	private _remainingSeconds = round (STING_ESTIMATED_ENDURANCE_SECONDS * _currentBattery);
	private _batteryColor = [1, 1, 1, 1];

	switch (true) do {
		case (_currentBattery <= 0.1): { _batteryColor = [0.91, 0.30, 0.24, 1] };
		case (_currentBattery <= 0.25): { _batteryColor = [0.96, 0.66, 0.17, 1] };
		default { _batteryColor = [1, 1, 1, 1] };
	};

	if (!isNull _batteryText) then {
		_batteryText ctrlSetText str _batteryPercent;
		_batteryText ctrlSetTextColor _batteryColor;
	};

	if (!isNull _remainingText) then {
		_remainingText ctrlSetText ([_remainingSeconds] call _formatRemainingTime);
		_remainingText ctrlSetTextColor _batteryColor;
	};

	if (!isNull _batteryPicture) then {
		_batteryPicture ctrlSetTextColor _batteryColor;
	};

	if !(GETMVAR(Sting_isControl, false)) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 0, [_formatRemainingTime]] call CBA_fnc_addPerFrameHandler;

SETMVAR(DB_sting_batteryPFH, _pfhId);
