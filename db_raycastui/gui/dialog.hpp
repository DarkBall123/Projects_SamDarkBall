#define DB_RUI_RIGHT_X (safeZoneX + safeZoneW)
#define DB_RUI_BOTTOM_Y (safeZoneY + safeZoneH)
#define DB_RUI_CENTER_X (safeZoneX + (safeZoneW * 0.5))
#define DB_RUI_CENTER_Y (safeZoneY + (safeZoneH * 0.5))

class DB_RaycastUIDialog
{
    idd = DB_RUI_IDD;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['DB_RUI_Display', _this # 0];";
    onUnload = "(_this # 0) call DB_fnc_rui_shutdownSession;";

    class controlsBackground
    {
        class Backdrop : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_BACKDROP;
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH;
            colorBackground[] = {0, 0, 0, 1};
        };

        class Ceiling : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_CEILING;
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH * 0.50;
            colorBackground[] = {0.22, 0.08, 0.08, 1};
        };

        class Floor : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_FLOOR;
            x = safeZoneX;
            y = safeZoneY + (safeZoneH * 0.50);
            w = safeZoneW;
            h = safeZoneH * 0.50;
            colorBackground[] = {0.09, 0.09, 0.09, 1};
        };

        class WeaponStrip : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_WEAPON_STRIP;
            x = safeZoneX;
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(14);
            w = safeZoneW;
            h = DB_RUI_GRID_H(14);
            colorBackground[] = {0.02, 0.02, 0.03, 0.90};
        };

        class MapPlate : DB_RUI_RscText
        {
            idc = -1;
            x = safeZoneX + DB_RUI_GRID_W(2);
            y = safeZoneY + DB_RUI_GRID_H(2);
            w = DB_RUI_GRID_W(34);
            h = DB_RUI_GRID_H(6);
            colorBackground[] = {0.02, 0.02, 0.02, 0.28};
        };

        class HelpPlate : DB_RUI_RscText
        {
            idc = -1;
            x = DB_RUI_RIGHT_X - DB_RUI_GRID_W(32);
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(15);
            w = DB_RUI_GRID_W(30);
            h = DB_RUI_GRID_H(13);
            colorBackground[] = {0.02, 0.02, 0.02, 0.24};
        };

        class DebugBackground : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_DEBUG_BG;
            x = safeZoneX + DB_RUI_GRID_W(2);
            y = safeZoneY + DB_RUI_GRID_H(2);
            w = DB_RUI_GRID_W(38);
            h = DB_RUI_GRID_H(18);
            colorBackground[] = {0, 0, 0, 0};
        };
    };

    class controls
    {
        class WorldLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_WORLD_GROUP;
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH;
        };

        class SpriteLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_SPRITE_GROUP;
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH;
        };

        class WeaponPicture : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_WEAPON;
            text = "\db_raycastui\data\ui\weapon\blaster.paa";
            x = DB_RUI_CENTER_X - (DB_RUI_GRID_W(46) * 0.5);
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(12.5);
            w = DB_RUI_GRID_W(46);
            h = DB_RUI_GRID_H(11);
        };

        class HPText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_HP;
            size = DB_RUI_TEXT_SIZE_MEDIUM;
            x = safeZoneX + DB_RUI_GRID_W(3);
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(9.5);
            w = DB_RUI_GRID_W(18);
            h = DB_RUI_GRID_H(2.4);
            text = "HP 100";
        };

        class AmmoText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_AMMO;
            size = DB_RUI_TEXT_SIZE_MEDIUM;
            x = safeZoneX + DB_RUI_GRID_W(3);
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(6.4);
            w = DB_RUI_GRID_W(24);
            h = DB_RUI_GRID_H(3.0);
            text = "PISTOL 12 | 24";
        };

        class MapText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_MAP;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = safeZoneX + DB_RUI_GRID_W(3);
            y = safeZoneY + DB_RUI_GRID_H(2.7);
            w = DB_RUI_GRID_W(32);
            h = DB_RUI_GRID_H(3.2);
            text = "CRIMSON FOUNDRY";
        };

        class HelpText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_HELP;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = DB_RUI_RIGHT_X - DB_RUI_GRID_W(31);
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(13);
            w = DB_RUI_GRID_W(28);
            h = DB_RUI_GRID_H(10.5);
            text = DB_RUI_HELP_TEXT;
            class Attributes
            {
                font = "PuristaMedium";
                color = "#F2E7BF";
                align = "right";
                valign = "top";
                shadow = 1;
            };
        };

        class OutcomeText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_OUTCOME;
            size = DB_RUI_TEXT_SIZE_LARGE;
            x = DB_RUI_CENTER_X - (DB_RUI_GRID_W(36) * 0.5);
            y = safeZoneY + (safeZoneH * 0.22);
            w = DB_RUI_GRID_W(36);
            h = DB_RUI_GRID_H(12);
            text = "";
            class Attributes
            {
                font = "PuristaMedium";
                color = "#F2E7BF";
                align = "center";
                valign = "middle";
                shadow = 1;
            };
        };

        class CrosshairH : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_CROSS_H;
            x = DB_RUI_CENTER_X - (DB_RUI_GRID_W(1.4) * 0.5);
            y = DB_RUI_CENTER_Y - (DB_RUI_GRID_H(0.18) * 0.5);
            w = DB_RUI_GRID_W(1.4);
            h = DB_RUI_GRID_H(0.18);
            colorBackground[] = {0.95, 0.92, 0.72, 1};
        };

        class CrosshairV : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_CROSS_V;
            x = DB_RUI_CENTER_X - (DB_RUI_GRID_W(0.18) * 0.5);
            y = DB_RUI_CENTER_Y - (DB_RUI_GRID_H(1.6) * 0.5);
            w = DB_RUI_GRID_W(0.18);
            h = DB_RUI_GRID_H(1.6);
            colorBackground[] = {0.95, 0.92, 0.72, 1};
        };

        class DebugText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_DEBUG_TEXT;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = safeZoneX + DB_RUI_GRID_W(3);
            y = safeZoneY + DB_RUI_GRID_H(2.8);
            w = DB_RUI_GRID_W(34);
            h = DB_RUI_GRID_H(15.5);
            text = "";
        };

        class LogoCard : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_LOGO;
            text = "\db_raycastui\data\ui\logo\doomcard.paa";
            x = DB_RUI_RIGHT_X - DB_RUI_GRID_W(29);
            y = safeZoneY + DB_RUI_GRID_H(2);
            w = DB_RUI_GRID_W(27);
            h = DB_RUI_GRID_H(7);
        };

        class InputCapture : DB_RUI_RscEditReadOnly
        {
            idc = DB_RUI_IDC_INPUT_CAPTURE;
            x = safeZoneX + DB_RUI_GRID_W(0.2);
            y = safeZoneY + DB_RUI_GRID_H(0.2);
            w = DB_RUI_GRID_W(0.5);
            h = DB_RUI_GRID_H(0.5);
            text = " ";
        };
    };
};

#undef DB_RUI_RIGHT_X
#undef DB_RUI_BOTTOM_Y
#undef DB_RUI_CENTER_X
#undef DB_RUI_CENTER_Y
