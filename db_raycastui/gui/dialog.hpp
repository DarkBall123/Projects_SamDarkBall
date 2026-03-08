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
            x = DB_RUI_X;
            y = DB_RUI_Y;
            w = DB_RUI_W;
            h = DB_RUI_H;
            colorBackground[] = {0, 0, 0, 1};
        };

        class Ceiling : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_CEILING;
            x = DB_RUI_X;
            y = DB_RUI_Y;
            w = DB_RUI_W;
            h = DB_RUI_H * 0.50;
            colorBackground[] = {0.22, 0.08, 0.08, 1};
        };

        class Floor : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_FLOOR;
            x = DB_RUI_X;
            y = DB_RUI_Y + (DB_RUI_H * 0.50);
            w = DB_RUI_W;
            h = DB_RUI_H * 0.50;
            colorBackground[] = {0.09, 0.09, 0.09, 1};
        };

        class WeaponStrip : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_WEAPON_STRIP;
            x = DB_RUI_X;
            y = DB_RUI_Y + (DB_RUI_H * 0.74);
            w = DB_RUI_W;
            h = DB_RUI_H * 0.26;
            colorBackground[] = {0.03, 0.03, 0.03, 0.92};
        };

        class DebugBackground : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_DEBUG_BG;
            x = DB_RUI_X + (DB_RUI_W * 0.018);
            y = DB_RUI_Y + (DB_RUI_H * 0.02);
            w = DB_RUI_W * 0.27;
            h = DB_RUI_H * 0.20;
            colorBackground[] = {0, 0, 0, 0.72};
        };
    };

    class controls
    {
        class WorldLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_WORLD_GROUP;
            x = DB_RUI_X;
            y = DB_RUI_Y;
            w = DB_RUI_W;
            h = DB_RUI_H;
        };

        class SpriteLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_SPRITE_GROUP;
            x = DB_RUI_X;
            y = DB_RUI_Y;
            w = DB_RUI_W;
            h = DB_RUI_H;
        };

        class WeaponPicture : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_WEAPON;
            text = "\db_raycastui\data\ui\weapon\blaster.paa";
            x = DB_RUI_X + (DB_RUI_W * 0.32);
            y = DB_RUI_Y + (DB_RUI_H * 0.72);
            w = DB_RUI_W * 0.36;
            h = DB_RUI_H * 0.27;
        };

        class HPText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_HP;
            size = DB_RUI_TEXT_SIZE_MEDIUM;
            x = DB_RUI_X + (DB_RUI_W * 0.025);
            y = DB_RUI_Y + (DB_RUI_H * 0.78);
            w = DB_RUI_W * 0.18;
            h = DB_RUI_H * 0.06;
            text = "HP 100";
        };

        class AmmoText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_AMMO;
            size = DB_RUI_TEXT_SIZE_MEDIUM;
            x = DB_RUI_X + (DB_RUI_W * 0.025);
            y = DB_RUI_Y + (DB_RUI_H * 0.84);
            w = DB_RUI_W * 0.18;
            h = DB_RUI_H * 0.06;
            text = "AMMO 16";
        };

        class MapText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_MAP;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = DB_RUI_X + (DB_RUI_W * 0.025);
            y = DB_RUI_Y + (DB_RUI_H * 0.03);
            w = DB_RUI_W * 0.24;
            h = DB_RUI_H * 0.06;
            text = "CRIMSON FOUNDRY";
        };

        class HelpText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_HELP;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = DB_RUI_X + (DB_RUI_W * 0.72);
            y = DB_RUI_Y + (DB_RUI_H * 0.78);
            w = DB_RUI_W * 0.24;
            h = DB_RUI_H * 0.14;
            text = "W/S move<br/>A/D turn<br/>SPACE/LMB fire<br/>R restart | X/Esc exit";
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
            x = DB_RUI_X + (DB_RUI_W * 0.20);
            y = DB_RUI_Y + (DB_RUI_H * 0.22);
            w = DB_RUI_W * 0.60;
            h = DB_RUI_H * 0.22;
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
            x = DB_RUI_X + (DB_RUI_W * 0.495);
            y = DB_RUI_Y + (DB_RUI_H * 0.499);
            w = DB_RUI_W * 0.010;
            h = DB_RUI_H * 0.0025;
            colorBackground[] = {0.95, 0.92, 0.72, 1};
        };

        class CrosshairV : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_CROSS_V;
            x = DB_RUI_X + (DB_RUI_W * 0.499);
            y = DB_RUI_Y + (DB_RUI_H * 0.492);
            w = DB_RUI_W * 0.0025;
            h = DB_RUI_H * 0.016;
            colorBackground[] = {0.95, 0.92, 0.72, 1};
        };

        class DebugText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_DEBUG_TEXT;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = DB_RUI_X + (DB_RUI_W * 0.028);
            y = DB_RUI_Y + (DB_RUI_H * 0.03);
            w = DB_RUI_W * 0.25;
            h = DB_RUI_H * 0.18;
            text = "";
        };

        class LogoCard : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_LOGO;
            text = "\db_raycastui\data\ui\logo\doomcard.paa";
            x = DB_RUI_X + (DB_RUI_W * 0.78);
            y = DB_RUI_Y + (DB_RUI_H * 0.03);
            w = DB_RUI_W * 0.18;
            h = DB_RUI_H * 0.08;
        };
    };
};
