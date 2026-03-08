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
            class rui_handleKeyEvent { file = "\db_raycastui\functions\fn_handleKeyEvent.sqf"; };
            class rui_handleInput { file = "\db_raycastui\functions\fn_handleInput.sqf"; };
            class rui_movePlayer { file = "\db_raycastui\functions\fn_movePlayer.sqf"; };
            class rui_isBlocked { file = "\db_raycastui\functions\fn_isBlocked.sqf"; };
            class rui_castRay { file = "\db_raycastui\functions\fn_castRay.sqf"; };
            class rui_hasLineOfSight { file = "\db_raycastui\functions\fn_hasLineOfSight.sqf"; };
            class rui_renderWalls { file = "\db_raycastui\functions\fn_renderWalls.sqf"; };
            class rui_renderSprites { file = "\db_raycastui\functions\fn_renderSprites.sqf"; };
            class rui_renderWeapon { file = "\db_raycastui\functions\fn_renderWeapon.sqf"; };
            class rui_renderHud { file = "\db_raycastui\functions\fn_renderHud.sqf"; };
            class rui_getWeaponInfo { file = "\db_raycastui\functions\fn_getWeaponInfo.sqf"; };
            class rui_playSound { file = "\db_raycastui\functions\fn_playSound.sqf"; };
            class rui_updateAI { file = "\db_raycastui\functions\fn_updateAI.sqf"; };
            class rui_fireWeapon { file = "\db_raycastui\functions\fn_fireWeapon.sqf"; };
            class rui_loadMap { file = "\db_raycastui\functions\fn_loadMap.sqf"; };
            class rui_resetRun { file = "\db_raycastui\functions\fn_resetRun.sqf"; };
            class rui_debugOverlay { file = "\db_raycastui\functions\fn_debugOverlay.sqf"; };
        };
    };
};

class CfgSounds
{
    sounds[] =
    {
        DB_RUI_PistolShot,
        DB_RUI_ShotgunShot,
        DB_RUI_MonsterAttack,
        DB_RUI_MonsterHurt,
        DB_RUI_MonsterDie
    };

    class DB_RUI_PistolShot
    {
        name = "DB_RUI_PistolShot";
        sound[] = {"\db_raycastui\data\sfx\pistol_shot.ogg", 1.2, 1, 50};
        titles[] = {};
    };

    class DB_RUI_ShotgunShot
    {
        name = "DB_RUI_ShotgunShot";
        sound[] = {"\db_raycastui\data\sfx\shotgun_shot.ogg", 1.4, 1, 60};
        titles[] = {};
    };

    class DB_RUI_MonsterAttack
    {
        name = "DB_RUI_MonsterAttack";
        sound[] = {"\db_raycastui\data\sfx\monster_attack.ogg", 1.0, 1, 40};
        titles[] = {};
    };

    class DB_RUI_MonsterHurt
    {
        name = "DB_RUI_MonsterHurt";
        sound[] = {"\db_raycastui\data\sfx\monster_hurt.ogg", 0.95, 1, 35};
        titles[] = {};
    };

    class DB_RUI_MonsterDie
    {
        name = "DB_RUI_MonsterDie";
        sound[] = {"\db_raycastui\data\sfx\monster_die.ogg", 1.0, 1, 45};
        titles[] = {};
    };
};

#include "gui\defines.hpp"
#include "gui\baseClasses.hpp"
#include "gui\dialog.hpp"
