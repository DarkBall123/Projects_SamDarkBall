/*
    db_charcreator: build the attribute model.
    Purpose: enumerate every customizable attribute into a single model the UI and
             the cycler read from, and seed each one's index from the player's
             current appearance.
    Context: client, called once on open.
    Params: none.
    Returns: nothing (stores DB_cc_model in uiNamespace).

    Model entry layout (array):
        0: STRING  key       internal id ("face","voice","uniform","headgear","glasses")
        1: STRING  label     UI label
        2: STRING  section   "Appearance" | "Clothing"
        3: ARRAY   list      [[classname, displayName], ...]
        4: NUMBER  index     currently selected index into list
*/

#include "..\script_macros.hpp"

// Returns the index of _class within a [[class,disp],...] list, or 0 if absent.
private _indexOf = {
    params ["_list", "_class"];
    private _i = _list findIf { (_x select 0) isEqualTo _class };
    if (_i < 0) then { 0 } else { _i };
};

// --- Enumerate ----------------------------------------------------------------
private _faces  = ["faces"] call DB_fnc_cc_enumConfig;
private _voices = ["flat", configFile >> "CfgVoice", 0] call DB_fnc_cc_enumConfig;
private _glasses = ["flat", configFile >> "CfgGlasses", 2] call DB_fnc_cc_enumConfig;
private _uniforms = ["itemType", configNull, CC_TYPE_UNIFORM] call DB_fnc_cc_enumConfig;
private _headgear = ["itemType", configNull, CC_TYPE_HEADGEAR] call DB_fnc_cc_enumConfig;

// CfgVoice holds container classes that are not valid speakers; drop them.
private _voiceExclude = ["Default", "NoVoice", "Languages", "Male", "Female"];
_voices = _voices select { !((_x select 0) in _voiceExclude) };

// "None" option for the removable items.
_glasses  = [["", "None"]] + _glasses;
_headgear = [["", "None"]] + _headgear;

// --- Assemble -----------------------------------------------------------------
private _model =
[
    ["face",     "Face",     "Appearance", _faces,    [_faces, face player] call _indexOf],
    ["voice",    "Voice",    "Appearance", _voices,   [_voices, speaker player] call _indexOf],
    ["glasses",  "Glasses",  "Appearance", _glasses,  [_glasses, goggles player] call _indexOf],
    ["uniform",  "Uniform",  "Clothing",   _uniforms, [_uniforms, uniform player] call _indexOf],
    ["headgear", "Headgear", "Clothing",   _headgear, [_headgear, headgear player] call _indexOf]
];

SETUVAR(DB_cc_model, _model);
