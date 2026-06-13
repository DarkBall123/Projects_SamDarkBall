/*
    db_charcreator: enumerate selectable classes from a config root.
    Purpose: generic config walk used to fill every attribute list. Returns pairs of
             [classname, displayName] filtered by scope, sorted by display name.
    Context: client, called while building the model.
    Params:
        0: STRING - mode, one of:
             "faces"    walk CfgFaces (nested gender sections, scope >= 1)
             "flat"     walk a flat root, scope >= the given minimum
             "itemType" walk CfgWeapons, keep ItemInfo >> type == given value
        1: CONFIG - root config entry to walk (for "flat" / "faces")
        2: NUMBER - minimum scope ("flat") or required ItemInfo type ("itemType")
    Returns: ARRAY of [classname (STRING), displayName (STRING)].
*/

#include "..\script_macros.hpp"

params ["_mode", ["_root", configNull], ["_arg", 2]];

private _out = [];

private _label = {
    params ["_cfg"];
    private _name = configName _cfg;
    private _disp = getText (_cfg >> "displayName");
    if (_disp isEqualTo "") then { _disp = _name; };
    [_name, _disp];
};

switch (_mode) do {
    case "faces": {
        // CfgFaces holds gender/section subclasses, each holding face classes.
        {
            private _section = _x;
            {
                if (getNumber (_x >> "scope") >= 1) then {
                    _out pushBack ([_x] call _label);
                };
            } forEach ("true" configClasses _section);
        } forEach ("true" configClasses (configFile >> "CfgFaces"));
    };

    case "flat": {
        {
            if (getNumber (_x >> "scope") >= _arg) then {
                _out pushBack ([_x] call _label);
            };
        } forEach ("true" configClasses _root);
    };

    case "itemType": {
        {
            private _cfg = _x;
            if (getNumber (_cfg >> "scope") >= 2
                && {getNumber (_cfg >> "ItemInfo" >> "type") == _arg}) then {
                _out pushBack ([_cfg] call _label);
            };
        } forEach ("true" configClasses (configFile >> "CfgWeapons"));
    };
};

// De-duplicate by class name (mod merges can repeat classes).
private _seen = [];
private _unique = [];
{
    _x params ["_class"];
    if !(_class in _seen) then {
        _seen pushBack _class;
        _unique pushBack _x;
    };
} forEach _out;

// Sort ascending by display name (field 1).
[_unique, [], { _x select 1 }, "ASCEND"] call BIS_fnc_sortBy;
