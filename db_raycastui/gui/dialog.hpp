#define DB_RUI_RIGHT_X (safeZoneX + safeZoneW)
#define DB_RUI_BOTTOM_Y (safeZoneY + safeZoneH)
#define DB_RUI_CENTER_X (safeZoneX + (safeZoneW * 0.5))
#define DB_RUI_CENTER_Y (safeZoneY + (safeZoneH * 0.5))
#define DB_RUI_SAFE_W_UNITS (safeZoneW / (pixelGridNoUIScale * pixelW * 2))
#define DB_RUI_SAFE_H_UNITS (safeZoneH / (pixelGridNoUIScale * pixelH * 2))
#define DB_RUI_SAFE_W DB_RUI_GRID_W(DB_RUI_SAFE_W_UNITS)
#define DB_RUI_SAFE_H DB_RUI_GRID_H(DB_RUI_SAFE_H_UNITS)
#define DB_RUI_SAFE_HALF_H DB_RUI_GRID_H(DB_RUI_SAFE_H_UNITS * 0.5)
#define DB_RUI_STATUS_H DB_RUI_GRID_H(0.1)
#define DB_RUI_STATUS_Y (DB_RUI_BOTTOM_Y - DB_RUI_STATUS_H)
#define DB_RUI_SIDE_PANEL_Y (DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(9.6))
#define DB_RUI_LEFT_PANEL_X (safeZoneX + DB_RUI_GRID_W(2.0))
#define DB_RUI_LEFT_PANEL_W DB_RUI_GRID_W(12.2)
#define DB_RUI_RIGHT_PANEL_W DB_RUI_GRID_W(14.0)
#define DB_RUI_RIGHT_PANEL_X (DB_RUI_RIGHT_X - DB_RUI_RIGHT_PANEL_W - DB_RUI_GRID_W(2.0))

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
            w = DB_RUI_SAFE_W;
            h = DB_RUI_SAFE_H;
            colorBackground[] = {0, 0, 0, 1};
        };

        class Ceiling : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_CEILING;
            x = safeZoneX;
            y = safeZoneY;
            w = DB_RUI_SAFE_W;
            h = DB_RUI_SAFE_HALF_H;
            colorBackground[] = {0.22, 0.08, 0.08, 1};
        };

        class Floor : DB_RUI_RscText
        {
            idc = DB_RUI_IDC_FLOOR;
            x = safeZoneX;
            y = safeZoneY + DB_RUI_SAFE_HALF_H;
            w = DB_RUI_SAFE_W;
            h = DB_RUI_SAFE_HALF_H;
            colorBackground[] = {0.09, 0.09, 0.09, 1};
        };

        class FloorLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_FLOOR_GROUP;
            x = safeZoneX;
            y = safeZoneY + DB_RUI_SAFE_HALF_H;
            w = DB_RUI_SAFE_W;
            h = DB_RUI_SAFE_HALF_H;
        };

        class WorldLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_WORLD_GROUP;
            x = safeZoneX;
            y = safeZoneY;
            w = DB_RUI_SAFE_W;
            h = DB_RUI_SAFE_H;
        };

        class SpriteLayer : DB_RUI_RscControlsGroupNoScrollbars
        {
            idc = DB_RUI_IDC_SPRITE_GROUP;
            x = safeZoneX;
            y = safeZoneY;
            w = DB_RUI_SAFE_W;
            h = DB_RUI_SAFE_H;
        };

        class StatusBar : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_STATUS_BAR;
            text = DB_RUI_TX_STATUS_BAR;
            x = 0;
            y = DB_RUI_STATUS_Y;
            w = 0;
            h = DB_RUI_STATUS_H;
        };

        class LeftStatsPlate : DB_RUI_RscText
        {
            idc = -1;
            x = DB_RUI_LEFT_PANEL_X;
            y = DB_RUI_SIDE_PANEL_Y;
            w = DB_RUI_LEFT_PANEL_W;
            h = DB_RUI_GRID_H(7.8);
            colorBackground[] = {0.02, 0.02, 0.03, 0.54};
        };

        class RightStatsPlate : DB_RUI_RscText
        {
            idc = -1;
            x = DB_RUI_RIGHT_PANEL_X;
            y = DB_RUI_SIDE_PANEL_Y;
            w = DB_RUI_RIGHT_PANEL_W;
            h = DB_RUI_GRID_H(7.8);
            colorBackground[] = {0.02, 0.02, 0.03, 0.54};
        };

        class MapPlate : DB_RUI_RscText
        {
            idc = -1;
            x = safeZoneX + DB_RUI_GRID_W(2);
            y = safeZoneY + DB_RUI_GRID_H(2);
            w = DB_RUI_GRID_W(28);
            h = DB_RUI_GRID_H(5.2);
            colorBackground[] = {0.07, 0.03, 0.03, 0.40};
        };

        class HelpPlate : DB_RUI_RscText
        {
            idc = -1;
            x = DB_RUI_RIGHT_X - DB_RUI_GRID_W(26);
            y = safeZoneY + DB_RUI_GRID_H(2);
            w = DB_RUI_GRID_W(24);
            h = DB_RUI_GRID_H(8.5);
            colorBackground[] = {0.07, 0.03, 0.03, 0.36};
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
        class WeaponPicture : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_WEAPON;
            text = DB_RUI_TX_WPN_PISTOL;
            x = DB_RUI_CENTER_X - (DB_RUI_GRID_W(30) * 0.5);
            y = DB_RUI_BOTTOM_Y - DB_RUI_GRID_H(12.0);
            w = DB_RUI_GRID_W(30);
            h = DB_RUI_GRID_H(10.0);
        };

        class AmmoText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_AMMO;
            size = DB_RUI_TEXT_SIZE_LARGE;
            x = DB_RUI_LEFT_PANEL_X + DB_RUI_GRID_W(1.1);
            y = DB_RUI_SIDE_PANEL_Y + DB_RUI_GRID_H(0.8);
            w = DB_RUI_LEFT_PANEL_W - DB_RUI_GRID_W(2.2);
            h = DB_RUI_GRID_H(2.7);
            text = "AMMO";
        };

        class HPText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_HP;
            size = DB_RUI_TEXT_SIZE_LARGE;
            x = DB_RUI_LEFT_PANEL_X + DB_RUI_GRID_W(1.1);
            y = DB_RUI_SIDE_PANEL_Y + DB_RUI_GRID_H(4.2);
            w = DB_RUI_LEFT_PANEL_W - DB_RUI_GRID_W(2.2);
            h = DB_RUI_GRID_H(2.7);
            text = "HEALTH";
        };

        class ArmsText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_ARMS;
            size = DB_RUI_TEXT_SIZE_MEDIUM;
            x = 0;
            y = 0;
            w = 0;
            h = 0;
            text = "ARMS";
        };

        class FacePicture : DB_RUI_RscPicture
        {
            idc = DB_RUI_IDC_FACE;
            text = DB_RUI_TX_FACE_IDLE;
            x = 0;
            y = 0;
            w = 0;
            h = 0;
        };

        class ArmorText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_ARMOR;
            size = DB_RUI_TEXT_SIZE_LARGE;
            x = DB_RUI_RIGHT_PANEL_X + DB_RUI_GRID_W(1.1);
            y = DB_RUI_SIDE_PANEL_Y + DB_RUI_GRID_H(0.8);
            w = DB_RUI_RIGHT_PANEL_W - DB_RUI_GRID_W(2.2);
            h = DB_RUI_GRID_H(2.7);
            text = "ARMOR";
        };

        class AmmoTableText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_AMMO_TABLE;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = DB_RUI_RIGHT_PANEL_X + DB_RUI_GRID_W(1.1);
            y = DB_RUI_SIDE_PANEL_Y + DB_RUI_GRID_H(3.3);
            w = DB_RUI_RIGHT_PANEL_W - DB_RUI_GRID_W(2.2);
            h = DB_RUI_GRID_H(3.6);
            text = "BULL";
        };

        class MapText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_MAP;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = safeZoneX + DB_RUI_GRID_W(3);
            y = safeZoneY + DB_RUI_GRID_H(2.7);
            w = DB_RUI_GRID_W(26);
            h = DB_RUI_GRID_H(2.8);
            text = "CRIMSON FOUNDRY";
        };

        class HelpText : DB_RUI_RscStructuredText
        {
            idc = DB_RUI_IDC_HELP;
            size = DB_RUI_TEXT_SIZE_SMALL;
            x = DB_RUI_RIGHT_X - DB_RUI_GRID_W(25);
            y = safeZoneY + DB_RUI_GRID_H(2.8);
            w = DB_RUI_GRID_W(22.5);
            h = DB_RUI_GRID_H(7.2);
            text = DB_RUI_HELP_TEXT;
            class Attributes
            {
                font = "EtelkaMonospacePro";
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
#undef DB_RUI_STATUS_H
#undef DB_RUI_STATUS_Y
#undef DB_RUI_SIDE_PANEL_Y
#undef DB_RUI_LEFT_PANEL_X
#undef DB_RUI_LEFT_PANEL_W
#undef DB_RUI_RIGHT_PANEL_X
#undef DB_RUI_RIGHT_PANEL_W
