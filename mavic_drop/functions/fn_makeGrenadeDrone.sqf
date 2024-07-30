//Allows a grenade to be attached to a drone but doesn't spawn one
_drone = param[0];
_number = param[1,1];

_drone addEventHandler ["Disassembled", {
	params ["_entity", "_primaryBag", "_secondaryBag"];
	removeAllActions _entity;
}];

//Loop for multiple grenades
for "_j" from 1 to _number do {
	_dropId = _drone addAction ["<t color='#FF0000'>Attach grenade</t>", {
		_this call mavic_drop_fnc_uiGrenadeSelector;
	}, nil, 10, true, true, "", "!(_this in _target) and (alive _target) and (count (_target getVariable [""grenadeObj"", []]) < 2)", 3];

	_detachId = _drone addAction ["<t color='#00FF00'>Detach grenades</t>", {
		_this call mavic_drop_fnc_detach_uiGrenadeSelector;
	}, nil, 10, true, true, "", "!(_this in _target) and (alive _target) and (count (_target getVariable [""grenadeObj"", []]) > 0)", 3];
};


[_drone] spawn {
	_drone = _this select 0;
	waitUntil {!alive _drone};
	_actions = removeAllActions _drone;
};