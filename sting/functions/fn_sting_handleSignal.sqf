/*
	Sting: telemetry handler.
	Purpose: updates the FPV OSD telemetry blocks for altitude, distance and speed.
	Context: client, active only while controlling the drone.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

private _formatOneDecimal = {
	params ["_value"];

	private _rounded = (round (_value * 10)) / 10;
	private _sign = "";
	private _absolute = abs _rounded;
	private _whole = floor _absolute;
	private _decimal = round ((_absolute - _whole) * 10);

	if (_decimal >= 10) then {
		_whole = _whole + 1;
		_decimal = 0;
	};

	if (_rounded < -0.05) then {
		_sign = "-";
	};

	format ["%1%2.%3", _sign, _whole, _decimal]
};

private _prevPfh = GETMVAR(DB_sting_signalPFH, -1);
if (_prevPfh >= 0) then {
	[_prevPfh] call CBA_fnc_removePerFrameHandler;
};

private _pfhId = [{
	_this params ["_args", "_handle"];
	_args params ["_formatOneDecimal"];

	private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
	private _uav = getConnectedUAV _player;

	if (isNull _player || { isNull _uav } || { !(GETMVAR(Sting_isControl, false)) }) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _altitudeAtl = ((getPosATL _uav) select 2) max 0;
	private _altitudeAsl = (getPosASL _uav) select 2;
	private _homeAltitudeAsl = _uav getVariable ["DB_sting_homeAltitudeASL", -10000];
	if (_homeAltitudeAsl <= -10000) then {
		_homeAltitudeAsl = _altitudeAsl;
		_uav setVariable ["DB_sting_homeAltitudeASL", _homeAltitudeAsl];
	};

	private _verticalSpeedText = GETUVAR(Sting_VerticalSpeedText, controlNull);
	private _horizontalSpeedText = GETUVAR(Sting_HorizontalSpeedText, controlNull);
	private _homeAltText = GETUVAR(Sting_HomeAltText, controlNull);
	private _distanceText = GETUVAR(Sting_DistanceText, controlNull);
	private _downIcon = GETUVAR(Sting_DownAltitudeIcon, controlNull);
	private _downText = GETUVAR(Sting_DownAltitudeText, controlNull);

	private _distance = _player distance _uav;
	private _velocity = velocity _uav;
	private _verticalSpeed = _velocity # 2;
	private _horizontalSpeed = vectorMagnitude [_velocity # 0, _velocity # 1, 0];
	private _relativeAltitude = (_altitudeAsl - _homeAltitudeAsl) max 0;
	private _clearanceColor = if (_altitudeAtl <= STING_LOW_ALT_WARNING) then {
		[0.96, 0.66, 0.17, 1]
	} else {
		[1, 1, 1, 1]
	};

	if (!isNull _verticalSpeedText) then {
		_verticalSpeedText ctrlSetText format ["%1m/s", [_verticalSpeed] call _formatOneDecimal];
	};

	if (!isNull _horizontalSpeedText) then {
		_horizontalSpeedText ctrlSetText format ["%1m/s", [_horizontalSpeed] call _formatOneDecimal];
	};

	if (!isNull _homeAltText) then {
		_homeAltText ctrlSetText format ["H %1m", [_relativeAltitude] call _formatOneDecimal];
	};

	if (!isNull _distanceText) then {
		_distanceText ctrlSetText format ["D %1m", round _distance];
	};

	if (!isNull _downIcon) then {
		_downIcon ctrlSetTextColor _clearanceColor;
	};

	if (!isNull _downText) then {
		_downText ctrlSetText format ["%1m", [_altitudeAtl] call _formatOneDecimal];
		_downText ctrlSetTextColor _clearanceColor;
	};
}, 0, [_formatOneDecimal]] call CBA_fnc_addPerFrameHandler;

SETMVAR(DB_sting_signalPFH, _pfhId);
