/*
    db_charcreator: apply one attribute's current selection to the player.
    Purpose: push the selected class onto the real player unit so the preview camera
             shows it immediately.
    Context: client.
    Params:
        0: STRING - attribute key
    Returns: nothing.

    Note: face is applied locally (instant preview). In multiplayer other clients
          will not see the face until it is broadcast; enable the remoteExec line
          below if global face sync is wanted.
*/

#include "..\script_macros.hpp"

params ["_key"];

private _model = GETUVAR(DB_cc_model, []);
private _idx = _model findIf { (_x select 0) isEqualTo _key };
if (_idx < 0) exitWith {};

private _entry = _model select _idx;
private _list  = _entry select 3;
if (count _list == 0) exitWith {};

private _class = (_list select (_entry select 4)) select 0;

switch (_key) do {
    case "face": {
        player setFace _class;
        // [player, _class] remoteExecCall ["setFace", 0];   // optional MP face sync
    };
    case "voice": {
        player setSpeaker _class;
    };
    case "uniform": {
        if (_class != "") then { player forceAddUniform _class; };
    };
    case "headgear": {
        removeHeadgear player;
        if (_class != "") then { player addHeadgear _class; };
    };
    case "glasses": {
        removeGoggles player;
        if (_class != "") then { player addGoggles _class; };
    };
};
