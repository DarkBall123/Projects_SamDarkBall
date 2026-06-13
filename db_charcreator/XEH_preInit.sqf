/*
    db_charcreator: preInit.
    Purpose: reserved early-init hook. The mod has no compile-time state to seed
             yet; functions are registered through CfgFunctions and the scroll-wheel
             action is wired up in XEH_postInit.
    Context: runs on every machine during mission load.
    Params: none.
    Returns: nothing.
*/

#include "script_macros.hpp"

SETMVAR(DB_cc_preInitDone, true);
