/*
    db_charcreator: stage the player for the preview.
    Purpose: lower the weapon into a relaxed standing pose so the model reads cleanly
             in the camera. Purely cosmetic; the weapon stays in the inventory.
    Context: client, called once on open.
    Params: none.
    Returns: nothing.
*/

#include "..\script_macros.hpp"

// Remember the stance so it can be reverted on close.
SETMVAR(DB_cc_savedStance, stance player);

// Relaxed, weapon-down idle.
player switchMove "AmovPercMstpSnonWnonDnon";
