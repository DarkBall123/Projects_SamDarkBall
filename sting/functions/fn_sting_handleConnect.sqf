/*
	Sting: FPV connection handler.
	Purpose: manages OSD lifecycle while controlling FPV drones.
	Context: client, runs post-init.
	Params: none.
	Returns: nothing.
*/

#include "\sting\script_macros.hpp"

if (!hasInterface) exitWith {};

private _droneTypes = GETMVAR(DB_sting_droneTypes, STING_DRONE_TYPES);
private _loopInterval = GETMVAR(DB_sting_connectLoopInterval, STING_CONNECT_LOOP_INTERVAL);
private _controlGracePeriod = GETMVAR(DB_sting_controlGracePeriod, 0.75);

private _prevPfh = GETMVAR(DB_sting_connectPFH, -1);
if (_prevPfh >= 0) then {
	[_prevPfh] call CBA_fnc_removePerFrameHandler;
};

private _pfhId = [{
	params ["_args", "_pfhId"];
	_args params ["_droneTypes", "_controlGracePeriod"];

	private _player = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
	if (isNull _player) exitWith {};

	private _now = diag_tickTime;
	private _uav = getConnectedUAV _player;
	private _uavType = typeOf _uav;
	private _lastUav = GETMVAR(DB_sting_lastUav, objNull);

	if (!isNull _lastUav && { _uav isNotEqualTo _lastUav }) then {
		SETMVAR(DB_sting_controlGraceUntil, -1);
	};

	if (isNull _uav) then {
		SETMVAR(DB_sting_lastUav, objNull);
		SETMVAR(DB_sting_controlGraceUntil, -1);
	} else {
		SETMVAR(DB_sting_lastUav, _uav);
	};

	private _cameraBound = cameraOn isEqualTo _uav;
	private _cameraMode = cameraView;
	private _directControlActive = (_uavType in _droneTypes) && { _cameraBound } && { _cameraMode in ["GUNNER", "EXTERNAL"] };
	private _wasControl = GETMVAR(Sting_isControl, false);
	private _graceUntil = GETMVAR(DB_sting_controlGraceUntil, -1);

	if (_directControlActive) then {
		_graceUntil = _now + _controlGracePeriod;
		SETMVAR(DB_sting_controlGraceUntil, _graceUntil);
	};

	private _connectedControl = (_uavType in _droneTypes) && { !isNull _uav };
	private _graceControlActive = _wasControl && { _connectedControl } && { _now <= _graceUntil };
	private _controlActive = _directControlActive || { _graceControlActive };
	private _uiActive = _controlActive && { _cameraBound } && { _cameraMode == "GUNNER" };
	private _uiMissing = isNull GETUVAR(Sting_Display, displayNull);
	private _hudApplied = GETMVAR(Sting_hudApplied, false);

	if (_controlActive) then {
		if (!_wasControl) then {
			private _currentHud = shownHUD;
			if ((count _currentHud) == 11) then {
				SETMVAR(Sting_savedHUD, _currentHud);
			} else {
				SETMVAR(Sting_savedHUD, []);
			};
			SETMVAR(Sting_hudApplied, false);
		};

		if (!_wasControl) then {
			SETMVAR(Sting_isControl, true);
		};

		if (_uiActive) then {
			if (!_hudApplied) then {
				showHUD [
					true,  // scriptedHUD
					false, // info
					true,  // radar
					true,  // compass
					true,  // direction
					true,  // menu
					true,  // group
					true,  // cursors
					true,  // panels
					true,  // kills
					true   // showIcon3D
				];
				SETMVAR(Sting_hudApplied, true);
			};
			if (_uiMissing) then {
				call DB_fnc_sting_createDialog;
			};
		} else {
			if (!_uiMissing) then {
				call DB_fnc_sting_destroyUI;
			};
			if (_hudApplied) then {
				private _savedHud = GETMVAR(Sting_savedHUD, []);
				if ((count _savedHud) == 11) then {
					showHUD _savedHud;
				};
				SETMVAR(Sting_hudApplied, false);
			};
		};
	} else {
		if (_wasControl) then {
			SETMVAR(Sting_isControl, false);
			SETMVAR(DB_sting_controlGraceUntil, -1);
			call DB_fnc_sting_destroyUI;
			private _savedHud = GETMVAR(Sting_savedHUD, []);
			if ((count _savedHud) == 11) then {
				showHUD _savedHud;
			};
			SETMVAR(Sting_savedHUD, []);
			SETMVAR(Sting_hudApplied, false);
		};
	};
}, _loopInterval, [_droneTypes, _controlGracePeriod]] call CBA_fnc_addPerFrameHandler;

SETMVAR(DB_sting_connectPFH, _pfhId);

[
	{ !isNull findDisplay 46 },
	{
		if (GETMVAR(DB_sting_keyEHAdded, false)) exitWith {};
		SETMVAR(DB_sting_keyEHAdded, true);

		findDisplay 46 displayAddEventHandler ["KeyDown", {
			private _handled = false;

			if (GETMVAR(Sting_isControl, false)) then {
				if (inputAction "showMap" > 0) then {
					_handled = true;
				};
			};

			_handled;
		}];
	},
	[]
] call CBA_fnc_waitUntilAndExecute;
