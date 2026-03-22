/*
	Sting: ClientInit.
	Purpose: basic client initialization for UI/state variables.
	Context: interface clients only.
*/

if (!hasInterface) exitWith {};

if (isNil "Sting_isControl") then {
	Sting_isControl = false;
};

if (isNil "DB_STING_Layer_ID") then {
	DB_STING_Layer_ID = -1;
};
