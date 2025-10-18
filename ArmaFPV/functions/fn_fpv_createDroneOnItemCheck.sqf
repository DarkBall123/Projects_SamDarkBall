params ["_unit", "_container", "_item"];

if !(_item in ["Item_Crocus_AT", "Item_Crocus_AP"]) exitWith {};
if ((typeOf _container) != "GroundWeaponHolder") exitWith {};

private _sidePrefix = switch (side _unit) do {
        case EAST: {"O"};
        case WEST: {"B"};
        case RESISTANCE: {"I"};
        default {""};
};

if (_sidePrefix isEqualTo "") exitWith {};

private _variant = if (_item == "Item_Crocus_AP") then {"Crocus_AP"} else {"Crocus_AT"};
private _uavClass = format ["%1_%2", _sidePrefix, _variant];

if !(isClass (configFile >> "CfgVehicles" >> _uavClass)) exitWith {};

private _uav = createVehicle [_uavClass, getPosATL _container, [], 0, "CAN_COLLIDE"];
createVehicleCrew _uav;

private _fn_removeMagazineFromContainer = {
        params ["_holder", "_magazine"];

        private _cargo = magazineCargo _holder;
        private _index = _cargo find _magazine;

        if (_index == -1) exitWith {};

        clearMagazineCargo _holder;

        {
                if (_forEachIndex != _index) then {
                        _holder addMagazineCargo [_x, 1];
                };
        } forEach _cargo;
};

[_container, _item] call _fn_removeMagazineFromContainer;
