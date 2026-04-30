private _noImageUntil = missionNamespace getVariable ["kvn_noImageUntil", 0];
if (_noImageUntil > time) exitWith {
	if !(missionNamespace getVariable ["kvn_destroyUIDelayed", false]) then {
		missionNamespace setVariable ["kvn_destroyUIDelayed", true];
		[_noImageUntil] spawn {
			params ["_endTime"];

			sleep ((_endTime - time) max 0);
			missionNamespace setVariable ["kvn_destroyUIDelayed", false];
			missionNamespace setVariable ["kvn_noImageUntil", 0];

			if !(missionNamespace getVariable ["kvn_isControl", false]) then {
				call DB_kvn_fnc_fpv_destroyUI;
			};
		};
	};
};

private _layer = missionNamespace getVariable ["DB_kvn_FPV_Layer_ID", -1];
_layer cutText ["","PLAIN"];

private _hud = missionNamespace getVariable ["DB_kvn_FPV_hudStatus", true];
showHUD _hud;

private _eh = missionNamespace getVariable ["kvn_osdEH",-1];
if (_eh >= 0) then { removeMissionEventHandler ["Draw3D", _eh]; missionNamespace setVariable ["kvn_osdEH",-1]; };
