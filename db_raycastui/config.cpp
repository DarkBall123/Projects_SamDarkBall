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

            class rui_startGame { file = "\db_raycastui\functions\fn_startGame.sqf"; };
            class rui_stopGame { file = "\db_raycastui\functions\fn_stopGame.sqf"; };
            class rui_initSession { file = "\db_raycastui\functions\fn_initSession.sqf"; };
            class rui_shutdownSession { file = "\db_raycastui\functions\fn_shutdownSession.sqf"; };
            class rui_tick { file = "\db_raycastui\functions\fn_tick.sqf"; };
            class rui_handleInput { file = "\db_raycastui\functions\fn_handleInput.sqf"; };
            class rui_movePlayer { file = "\db_raycastui\functions\fn_movePlayer.sqf"; };
            class rui_castRay { file = "\db_raycastui\functions\fn_castRay.sqf"; };
            class rui_renderWalls { file = "\db_raycastui\functions\fn_renderWalls.sqf"; };
            class rui_renderSprites { file = "\db_raycastui\functions\fn_renderSprites.sqf"; };
            class rui_renderWeapon { file = "\db_raycastui\functions\fn_renderWeapon.sqf"; };
            class rui_renderHud { file = "\db_raycastui\functions\fn_renderHud.sqf"; };
            class rui_updateAI { file = "\db_raycastui\functions\fn_updateAI.sqf"; };
            class rui_fireWeapon { file = "\db_raycastui\functions\fn_fireWeapon.sqf"; };
            class rui_loadMap { file = "\db_raycastui\functions\fn_loadMap.sqf"; };
            class rui_resetRun { file = "\db_raycastui\functions\fn_resetRun.sqf"; };
            class rui_debugOverlay { file = "\db_raycastui\functions\fn_debugOverlay.sqf"; };
        };
    };
};

#include "gui\defines.hpp"
#include "gui\baseClasses.hpp"
#include "gui\dialog.hpp"
