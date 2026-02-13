#include "\vnd_main\script_macros.hpp"

private _layer = GETMVAR(DB_vnd_FPV_Layer_ID, -1);
_layer cutText ["","PLAIN"];

private _hud = GETMVAR(DB_vnd_FPV_hudStatus, true);
showHUD _hud;

private _eh = GETMVAR(vnd_osdEH, -1);
if (_eh >= 0) then {
    removeMissionEventHandler ["Draw3D", _eh];
    SETMVAR(vnd_osdEH, -1);
};
