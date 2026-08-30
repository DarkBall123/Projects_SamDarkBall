#define S(ID) (_ui getVariable [ID,controlNull])

params [["_uav",objNull]];
if (isNull _uav) exitWith {};

private _ehOld = missionNamespace getVariable ["kvn_osdEH",-1];
if (_ehOld >= 0) then { removeMissionEventHandler ["Draw3D", _ehOld]; };

private _sn = _uav getVariable ["kvn_sn",""];
if (_sn isEqualTo "") then {
	_sn = format ["%1d", floor random 1e5];
	_uav setVariable ["kvn_sn", _sn, true];
};
private _fw        = _uav getVariable ["kvn_fw","2.17"];
private _savedTime = _uav getVariable ["kvn_time",0];
private _t0        = time - _savedTime;

private _mahUsed  = _uav getVariable ["kvn_mahUsed",0];
private _rx       = _uav getVariable ["kvn_rx",-60];
private _tx       = _uav getVariable ["kvn_tx",50];
private _lastFuel = _uav getVariable ["kvn_lastFuel", fuel _uav];
private _lastT    = time;

private _hCoef = (pixelGridNoUIScale * pixelH * 2) * 0.20;
missionNamespace setVariable ["kvn_hCoef", _hCoef];

private _eh = addMissionEventHandler [
	"Draw3D",
	{
		_thisArgs params ["_uav","_t0","_mahUsed","_sn","_fw","_rx","_tx","_lastFuel","_lastT"];

		if (isNull _uav || !(missionNamespace getVariable ["kvn_isControl",false])) exitWith {
			removeMissionEventHandler ["Draw3D", _thisEventHandler];
			missionNamespace setVariable ["kvn_osdEH",-1];
		};

		private _ui  = uiNamespace;
		private _now = time;
		private _dt  = _now - _lastT;
		_lastT = _now;

		private _t     = _now - _t0;
		private _alt   = (getPosATL _uav select 2) max 0;
		private _spd   = speed _uav;

		private _pitchD = (_uav call BIS_fnc_getPitchBank) # 0;
		private _pitch  = round _pitchD;

		private _fuel   = fuel _uav;
		private _fuelDrop = (_lastFuel - _fuel) max 0;
		_lastFuel = _fuel;

		private _curr = 30 + (_spd * 0.15);
		_curr = _curr max 0 min 120;
		_mahUsed = _mahUsed + ((_curr * _dt) / 3600) * 1000;

		_uav setVariable ["kvn_mahUsed", _mahUsed, true];
		_uav setVariable ["kvn_time",   _t,        true];
		_uav setVariable ["kvn_lastFuel", _lastFuel];

		private _perc = round (_fuel * 100);
		private _v1   = (_fuel * 24) toFixed 1;
		private _v2   = (_fuel * 3.7) toFixed 2;
		private _fps  = round diag_fps;

		private _pl   = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
		private _dist = _pl distance _uav;

		private _rxTarget = -40 - (_dist * 0.015);
		_rx = _rx + (_rxTarget - _rx) * 0.08 + (random 0.2 - 0.1);
		_rx = _rx max -120 min -20;

		private _txTarget = 30 + (_dist * 0.03);
		_tx = _tx + (_txTarget - _tx) * 0.08 + (random 1.0 - 0.5);
		_tx = _tx max 0 min 1000;

		_fw = _uav getVariable ["kvn_fw", _fw];

		private _target = cursorTarget;
		if (isNull _target) then {
			_target = cursorObject;
		};

		private _hasTarget =
			!isNull _target &&
			{alive _target} &&
			{_target != _uav} &&
			{
				(_target isKindOf "Man") ||
				{(_target isKindOf "LandVehicle") ||
				{_target isKindOf "Air"}}
			};

		private _sight = S("kvn_Center_Target");
		if (!isNull _sight) then {
			private _sightColor = [1,1,1,1];
			if (_alt < 5) then {
				_sightColor = [1,0,0,1];
			};
			if (_hasTarget) then {
				_sightColor = [0,1,0,1];
			};
			_sight ctrlSetTextColor _sightColor;
		};

		S("kvn_TL_TimeText")  ctrlSetText ([_t,"MM:SS"] call BIS_fnc_secondsToString);
		S("kvn_TL_AltText")   ctrlSetText format["%1 alt m", round _alt];

		S("kvn_TC_V1") ctrlSetText format["%1V", _v1];
		S("kvn_TC_V2") ctrlSetText format["%1V", _v2];

		S("kvn_RB_Current") ctrlSetText format["%1 A",   round _curr];
		S("kvn_RB_mAh")     ctrlSetText format["%1 mAh", round _mahUsed];
		S("kvn_RB_Percent") ctrlSetText format["%1 %%",  _perc];
		S("kvn_RB_Spd")     ctrlSetText format["spd: %1", round _spd];
		S("kvn_RB_Pitch")   ctrlSetText format["pitch: %1", _pitch];
		S("kvn_RB_SN")      ctrlSetText format["SN: %1",  _sn];

		S("kvn_BL_Rx") ctrlSetText format["RXg: %1 dBm", (_rx toFixed 1)];
		S("kvn_BL_Tx") ctrlSetText format["TXg: %1 mW",  (_tx toFixed 0)];
		S("kvn_BL_FW") ctrlSetText format["FW: %1", _fw];

		S("kvn_BC_FPS") ctrlSetText format["FPS: %1", _fps];


		private _showHorizon = missionNamespace getVariable ["kvn_showHorizon", true];

		private _l = S("kvn_HLine_L");
		private _r = S("kvn_HLine_R");

		_l ctrlShow _showHorizon;
		_r ctrlShow _showHorizon;

		if (!isNull _l && !isNull _r && _showHorizon) then {
			private _base = missionNamespace getVariable ["kvn_hBasePos", []];
			if (_base isEqualTo [] || {count _base != 2}) then {
				_base = [ctrlPosition _l, ctrlPosition _r];
				missionNamespace setVariable ["kvn_hBasePos", _base];
			};

			private _k   = missionNamespace getVariable ["kvn_hCoef", (pixelGridNoUIScale * pixelH * 2) * 0.20];
			private _off = _pitchD * _k;

			private _pL = +(_base#0);
			private _pR = +(_base#1);

			_pL set [1, (_base#0)#1 + _off];
			_pR set [1, (_base#1)#1 + _off];

			_l ctrlSetPosition _pL;
			_r ctrlSetPosition _pR;
			_l ctrlCommit 0;
			_r ctrlCommit 0;
		};

		_thisArgs set [2, _mahUsed];
		_thisArgs set [5, _rx];
		_thisArgs set [6, _tx];
		_thisArgs set [7, _lastFuel];
		_thisArgs set [8, _lastT];
	},
	[_uav,_t0,_mahUsed,_sn,_fw,_rx,_tx,_lastFuel,_lastT]
];

missionNamespace setVariable ["kvn_osdEH", _eh];
