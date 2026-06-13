/*
    db_charcreator: undo the preview staging.
    Purpose: hand animation back to the engine so the player returns to normal
             movement after closing the creator.
    Context: client, called from cc_close.
    Params: none.
    Returns: nothing.
*/

#include "..\script_macros.hpp"

player switchMove "";
