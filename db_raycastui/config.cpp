class CfgPatches
{
    class DB_RaycastUI
    {
        author = "DarkBall & Sam";
        name = "DB Raycast UI";
        requiredAddons[] =
        {
            "A3_Data_F_AoW_Loadorder",
            "A3_UI_F"
        };
        requiredVersion = 0.1;
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class DB
    {
        class RaycastUI
        {
            file = "\db_raycastui\functions";

            class rui_startGame {};
            class rui_stopGame {};
            class rui_initSession {};
            class rui_shutdownSession {};
            class rui_tick {};
            class rui_handleInput {};
            class rui_movePlayer {};
            class rui_castRay {};
            class rui_renderWalls {};
            class rui_renderSprites {};
            class rui_renderWeapon {};
            class rui_renderHud {};
            class rui_updateAI {};
            class rui_fireWeapon {};
            class rui_loadMap {};
            class rui_resetRun {};
            class rui_debugOverlay {};
        };
    };
};

#include "gui\defines.hpp"
#include "gui\baseClasses.hpp"
#include "gui\dialog.hpp"
