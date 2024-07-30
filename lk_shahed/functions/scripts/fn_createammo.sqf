params["_unitPos", "_ammoName", "_pitchBankYaw", "_velocty"];

_armament = _ammoName createVehicle _unitPos;
_armament setPosATL _unitPos;
[_armament, _pitchBankYaw] call shahed_fnc_setPitchBankYaw;
_armament setVelocity _velocty;
_armament