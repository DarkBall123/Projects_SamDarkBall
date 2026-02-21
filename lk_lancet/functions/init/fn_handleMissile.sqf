#include "..\includes.hpp"
//params["_projectile", "_offset", "_speedArr"];

private _projectile = param [0,objNull];
private _offset 	= param [1, 2.0];
private _speedArr 	= param [2, []];
private _dialogName = param [3, "lancet_seeker"];

//Handle camera
private _camera = [_projectile, 2.0] call lancet_fnc_camCreate; // 2.0 def

//Create dialog
private _diag = createDialog ["lancet_seeker", true];

//Change FOV / thermals / autolock
uiNamespace setVariable ["isSlewing", false];
uiNamespace setVariable ["_mainCamera", _camera];
uiNamespace setVariable ["_thermalState", true];
uiNamespace setVariable ["_autoLockState", true];
uiNamespace setVariable ["_zoomStatus", false];
uiNamespace setVariable ["_itemLock", false];
uiNamespace setVariable ["DB_isSlewing", false];
uiNamespace setVariable ["lancet_mouseStick", [0, 0]];

//Current projectile for manual detonation
uiNamespace setVariable ["lancet_currentProjectile", _projectile];

//Missile stuff
//Main variables
private _target = objNull;
private _posProj = []; //Projectile pos
private _posWorld = []; //World target position
private _v = []; //Target versor (from projectile)
private _timeManouver = 0; //Time for manouver
private _timeCheck = time; //Time now
private _targetEnabled = true; //Smart targetting
private _crossTarget = []; //Position for the crosshair
private _crtlSize = []; //Size of the control thing 
private _wordToScreenPos = []; //Position on the screen of the current target
private _targetOffset = [0,0,0]; //Offset from target center 
private _targetArr = []; 

private _lastControlUpdate = diag_tickTime;
private _returnRate = 2.6;
private _steerYawRate = 85;
private _steerPitchRate = 75;
private _manualVectorDist = 1200;
private _cursorRangeX = 0.18;
private _cursorRangeY = 0.18;
private _guideTick = 0.04;
private _nextGuideAt = 0;

//Fast cleanup when the missile dies
_projectile setVariable ["_projAttachedCamera", _camera, true];
_projectile addEventHandler ["Explode", {
	params ["_projectile"];
	//_camera is saved to uiNamespace meaning if you are using another projectile it's overwritten
	_camera = uiNamespace getVariable "_mainCamera";
	_attachedCam = _projectile getVariable "_projAttachedCamera";

	private _uav_temp = _projectile getVariable ["DB_lancet_subUAV", objNull];
	deleteVehicle _uav_temp;

	if(_camera == _attachedCam) then {
		[_camera] call lancet_fnc_cleanEffectsCam;
	};
}];

_projectile addEventHandler ["Explode", {
	[] spawn {
		if (isNull (uiNamespace getVariable ["_mainCamera", objNull])) exitWith {};
		
		PP_film = ppEffectCreate ["FilmGrain",2000]; 
		PP_film ppEffectAdjust [1,0,0,1.03,1.05,true];
		PP_film ppEffectCommit 0;
		PP_film ppEffectEnable true;

		waitUntil {isNull (uiNamespace getVariable "_mainCamera")};


		PP_film = ppEffectCreate ["FilmGrain",2000]; 
		PP_film ppEffectAdjust [1,0,0,1.03,1.05,true];
		PP_film ppEffectCommit 0;
		PP_film ppEffectEnable true;

		sleep 0.8;

		ppEffectDestroy PP_film;
	};
}];

//Effects
[] call lancet_fnc_handleEffects;

//Detect button presses
[_diag] call lancet_fnc_dialogEventHandlers;

if(count _speedArr > 0) then {
	[_projectile, _speedArr] spawn lancet_fnc_handleSpeed;
};

//Updates all the text values for the seeker
[_diag, _projectile] spawn lancet_fnc_handleText;

//Target cursor box and crosshair
private _crosshair = _diag displayCtrl seeker_head;
private _targetCursor = _diag displayCtrl target_cursor;
_targetCursor ctrlShow false;

//Main loop
while {alive _projectile and dialog} do {
	if(time - _timeCheck > _guideTick) then {
		_targetEnabled = uiNamespace getVariable ["_autoLockState", true];

		if(!_targetEnabled) then {
			_target = objNull;
			_targetOffset = [0,0,0]; 
		};

		private _isAutoSlewing = uiNamespace getVariable ["DB_isSlewing", false];
		if (!_isAutoSlewing) then {
			private _nowTick = diag_tickTime;
			private _dt = _nowTick - _lastControlUpdate;
			_lastControlUpdate = _nowTick;

			private _stick = uiNamespace getVariable ["lancet_mouseStick", [0, 0]];
			private _spring = 1 - (_returnRate * _dt);
			if (_spring < 0) then {
				_spring = 0;
			};

			private _stickX = (_stick # 0) * _spring;
			private _stickY = (_stick # 1) * _spring;

			if (abs _stickX < 0.002) then { _stickX = 0; };
			if (abs _stickY < 0.002) then { _stickY = 0; };

			_stick = [_stickX, _stickY];
			uiNamespace setVariable ["lancet_mouseStick", _stick];

			private _seekerLock = uiNamespace getVariable ["DB_seeker_lock", controlNull];
			if !(isNull _seekerLock) then {
				private _lockPos = ctrlPosition _seekerLock;
				private _lockW = _lockPos # 2;
				private _lockH = _lockPos # 3;

				private _newX = (0.5 - (_lockW / 2)) + (_stickX * _cursorRangeX);
				private _newY = (0.5 - (_lockH / 2)) - (_stickY * _cursorRangeY);

				private _halfW = _lockW / 2;
				private _halfH = _lockH / 2;
				_newX = _newX max (safeZoneX + _halfW) min (safeZoneX + safeZoneW - _halfW);
				_newY = _newY max (safeZoneY + _halfH) min (safeZoneY + safeZoneH - _halfH);

				_seekerLock ctrlSetPosition [_newX, _newY, _lockW, _lockH];
				_seekerLock ctrlCommit 0;
			};

			if (time >= _nextGuideAt) then {
				_posProj = AGLTOASL positionCameraToWorld [0,0,0];
				private _dirAndUp = [
					[vectorDir _projectile, vectorUp _projectile],
					_stickX * _steerYawRate * _dt,
					_stickY * _steerPitchRate * _dt,
					0
				] call BIS_fnc_transformVectorDirAndUp;
				private _manualDir = vectorNormalized (_dirAndUp # 0);

				_v = _manualDir vectorMultiply _manualVectorDist;
				_posWorld = _posProj vectorAdd _v;

				if(_targetEnabled) then {
					_targetArr = [_projectile, _v] call lancet_fnc_findTarget;
					_target = _targetArr # 0;
					_targetOffset = _targetArr # 1;
					if(!isNull _target) then {
						_v = ((getPosASL _target) vectorAdd _targetOffset) vectorDiff _posProj;
						_posWorld = _posProj vectorAdd _v;
					};
				} else {
					_target = objNull;
					_targetOffset = [0,0,0];
				};

				uiNamespace setVariable ["_itemLock", !(isNull _target)];

				private _angleFac = (1 - abs((vectorDir _projectile) vectorCos _v));
				_timeManouver = [_projectile, 0.06 + (_angleFac * 0.08), 0.16] call lancet_fnc_manouverTime;
				[_projectile, _v, _timeManouver] spawn lancet_fnc_handleGuidance;

				_nextGuideAt = time + _guideTick;
			};
		};
			
		//Target cursor
		if(ctrlShown _targetCursor) then {
			_crtlSize = (ctrlPosition _targetCursor) # 3;
			_crossTarget = [];
			if(isNull _target) then {
				_wordToScreenPos = worldToScreen ((ASLTOAGL _posWorld) vectorAdd _targetOffset);
				if(count _wordToScreenPos > 0) then {
					_crossTarget = _wordToScreenPos vectorDiff [_crtlSize/2, _crtlSize/2];
				};
			} else {
				_wordToScreenPos = (worldToScreen ((ASLTOAGL getposASl _target) vectorAdd _targetOffset)); 
				if(count _wordToScreenPos > 0) then {
					_crossTarget = _wordToScreenPos vectorDiff [_crtlSize/2, _crtlSize/2];
				};
			};
			//Check if the cursor is outside the screen, in that case disable it
			if(count _crossTarget > 0) then {
				_crossTarget vectorAdd [random [-0.14, 0, 0.14], random [-0.15, 0, 0.15]];
				_crossTarget deleteAt 2;
				_targetCursor ctrlSetPosition _crossTarget;
				_targetCursor ctrlCommit 0;
				} else {
					_targetCursor ctrlShow false;
				};

				uiNamespace setVariable ["_itemLock", !(isNull _target)];
			};

		_timeCheck = time;
	};

	sleep 0.01;
};

//If we closed the dialog while the missile is still alive, it will auto track the target, if any
if(alive _projectile and !isNull _target) then {
	_projectile setMissileTarget _target; //Some projectiles allow handoff
};

//Clean 
if(!isNull _camera) then {
	closeDialog 1;
	false setCamUseTI 0;
	_camera cameraEffect ["terminate","back"];
	camDestroy _camera;
};

private _effects = (uiNamespace getVariable ["lancet_effectsArr", []]);
if(count _effects > 0) then {
	{
		ppEffectDestroy _x;
	}forEach _effects;
};
uiNamespace setVariable ["lancet_effectsArr",  []];

		//_id = [str _projectile, "onEachFrame", { drawLine3D [_this # 0, _this # 1, [1,1,1,1]]}, [aslToAGL positionCameraToWorld [0,0,0], (aslToAGL _posProj) vectorAdd _v]] call BIS_fnc_addStackedEventHandler;
		
