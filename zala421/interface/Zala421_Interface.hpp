#include "uiDefines.hpp"

class Zala16_UI_BaseBox : ctrlControlsGroupNoScrollBars
{
    idc = -1;

    x = 0;
    y = 0;
    w = 0;
    h = ZALA_BASEBOX_H;

    class controls
    {
        class BackGround : ctrlStaticBackGround
        {
            idc = -1;

            colorBackGround[] = {0, 0, 0, 0.7};

            x = 0;
            y = 0;
            w = 0;
            h = ZALA_BASEBOX_H;
        };

        class Text : ctrlStructuredText
        {
            idc = 101;

            class Attributes
            {
                font = "EtelkaMonospacePro";
            };

            shadow = 0;
            size = GRID_H(1.2);

            x = 0;
            y = 0;
            w = 0;
            h = ZALA_BASEBOX_H;
        };
    };
};

class InfoBox_Base : ctrlControlsGroupNoScrollBars
{
    idc = -1;

    x = 0;
    y = 0;
    w = INFOBOX_W;
    h = INFOBOX_H;

    class controls
    {
        class WhiteBackGround : ctrlStaticBackGround
        {
            idc = -1;

            colorBackGround[] = {1, 1, 1, 1};

            x = 0;
            y = 0;
            w = INFOBOX_W;
            h = INFOBOX_H;
        };

        class TopBackGround : ctrlStaticBackGround
        {
            idc = -1;

            colorBackGround[] = {0, 0, 0, 1};

            x = INFOBOX_PADDING_W;
            y = INFOBOX_PADDING_H;
            w = INFOBOX_W - 2*INFOBOX_PADDING_W;
            h = INFOBOX_H - 2*INFOBOX_PADDING_H;
        };
        
        class MainText : ctrlStructuredText
        {
            idc = -1;

            class Attributes
            {
                font = "PuristaLight";
                align = "center";
                valign = "middle";
            };

            size = INFOBOX_TEXT_SIZE;

            x = 0;
            y = INFOBOX_H / 2 - INFOBOX_TEXT_SIZE / 2;
            w = INFOBOX_W;
            h = INFOBOX_TEXT_SIZE;
        };
    };
};

class RscTitles
{
    class Zala421_Interface_Gunner
    {
        idd = -1;
        duration = 1e10;

        onLoad = "uiNameSpace setVariable ['DB_zala421HUD_display_gunner', _this # 0]";

        class controls
        {
            class Square_X : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_squareX_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2);
                w = GRID_W(8);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(8);
                    };

                    class Text : Text
                    {
                        text = "КВ X";
                        w = GRID_W(8);
                    };
                };
            };

            class Square_Y : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_squareY_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + ZALA_BASEBOX_H;
                w = GRID_W(8);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(8);
                    };

                    class Text : Text
                    {
                        text = "КВ Y";
                        w = GRID_W(8);
                    };
                };
            };

            class Laser : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_laser_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 2*ZALA_BASEBOX_H;
                w = GRID_W(8);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(8);
                    };

                    class Text : Text
                    {
                        text = "ЛАЗЕР";
                        w = GRID_W(8);
                    };
                };
            };

            class Speed : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_speed_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 3*ZALA_BASEBOX_H;
                w = GRID_W(8);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(8);
                    };

                    class Text : Text
                    {
                        text = "СКОР";
                        w = GRID_W(8);
                    };
                };
            };

            class Height : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_height_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 4*ZALA_BASEBOX_H;
                w = GRID_W(6);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(6);
                    };

                    class Text : Text
                    {
                        text = "ВЫС";
                        w = GRID_W(6);
                    };
                };
            };

            class Direction : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_direction_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 5*ZALA_BASEBOX_H;
                w = GRID_W(6);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(6);
                    };

                    class Text : Text
                    {
                        text = "КУРС";
                        w = GRID_W(6);
                    };
                };
            };

            class Temperature : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_temperature_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 6*ZALA_BASEBOX_H;
                w = GRID_W(4);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(4);
                    };

                    class Text : Text
                    {
                        text = "Т";
                        w = GRID_W(4);
                    };
                };
            };

            class Date : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_date_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 6*ZALA_BASEBOX_H + GRID_H(4);
                w = GRID_W(5);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(5);
                    };

                    class Text : Text
                    {
                        text = "14/05/19";
                        w = GRID_W(5);
                    };
                };
            };

            class Time : Zala16_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_zala421_time_HUD"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(1.5);
                y = safeZoneY + GRID_H(1.2) + 7*ZALA_BASEBOX_H + GRID_H(4);
                w = GRID_W(5);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(5);
                    };

                    class Text : Text
                    {
                        text = "02:22:41";
                        w = GRID_W(5);
                    };
                };
            };
        };
    };

    class Zala421_Interface_Driver
    {
        duration = 1e10;
		movingEnable = false;
		enableSimulation = true;
		idd = -1;

        onLoad = "uiNameSpace setVariable ['DB_zala421HUD_display_driver', _this # 0]";

        class controls
        {
            class CoordinateBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(8) + GRID_W(1) + GRID_W(0.5);
                y = ANGLE_GROUP_Y - INFOBOX_H;
                w = GRID_W(12);

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {
                        w = GRID_W(12);
                    };
                    class TopBackGround : TopBackGround {
                        w = GRID_W(12) - 2*INFOBOX_PADDING_W;
                    };
                    class MainText : MainText
                    {
                        onLoad = "uiNameSpace setVariable ['DB_zala421_HUD_coord_mainText', _this # 0]";
                        text = "3535.85, 4887.42, 500";
                        w = GRID_W(12);
                    };
                };
            };

            class BatteryBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(8) + GRID_W(12) + GRID_W(1) + 2*GRID_W(0.5);
                y = ANGLE_GROUP_Y - INFOBOX_H;
                w = GRID_W(8);

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {
                        w = GRID_W(8);
                    };
                    class TopBackGround : TopBackGround {
                        w = GRID_W(8) - 2*INFOBOX_PADDING_W;
                    };
                    class MainText : MainText
                    {
                        text = "BATTERY: 100";
                        onLoad = "uiNameSpace setVariable ['DB_zala421_HUD_fuel_mainText', _this # 0]";
                        w = GRID_W(8);
                    };
                };
            };

            class AltitudeBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + 2*GRID_W(8) + GRID_W(12) + GRID_W(1) + 3*GRID_W(0.5);
                y = ANGLE_GROUP_Y - INFOBOX_H;
                w = GRID_W(8);

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {
                        w = GRID_W(8);
                    };
                    class TopBackGround : TopBackGround {
                        w = GRID_W(8) - 2*INFOBOX_PADDING_W;
                    };
                    class MainText : MainText
                    {
                        text = "ALT: 19";
                        onLoad = "uiNameSpace setVariable ['DB_zala421_HUD_alt_mainText', _this # 0]";
                        w = GRID_W(8);
                    };
                };
            };

            class StatusBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + 3*GRID_W(8) + GRID_W(12) + GRID_W(1) + 4*GRID_W(0.5);
                y = ANGLE_GROUP_Y - INFOBOX_H;
                w = GRID_W(12);

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {
                        w = GRID_W(12);
                    };
                    class TopBackGround : TopBackGround {
                        w = GRID_W(12) - 2*INFOBOX_PADDING_W;
                    };
                    class MainText : MainText
                    {
                        text = "STATUS: OPERATIONAL";
                        onLoad = "uiNameSpace setVariable ['DB_zala421_HUD_status_mainText', _this # 0]";
                        w = GRID_W(12);
                    };
                };
            };

            class DroneSpeedBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(8) + GRID_W(1) - GRID_W(12);
                y = ANGLE_GROUP_Y - INFOBOX_H;
                w = GRID_W(12);

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {
                        w = GRID_W(12);
                    };
                    class TopBackGround : TopBackGround {
                        w = GRID_W(12) - 2*INFOBOX_PADDING_W;
                    };
                    class MainText : MainText
                    {
                        onLoad = "uiNameSpace setVariable ['DB_zala421_HUD_droneSpeed_mainText', _this # 0]";
                        text = "СКОРОСТЬ: 120 КМ/Ч";
                        w = GRID_W(12);
                    };
                };
            };

            class PitchBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(8) + GRID_W(1) - GRID_W(12);
                y = ANGLE_GROUP_Y - INFOBOX_H  + INFOBOX_H + GRID_H(0.4);
                w = GRID_W(12);

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {
                        w = GRID_W(12);
                    };
                    class TopBackGround : TopBackGround {
                        w = GRID_W(12) - 2*INFOBOX_PADDING_W;
                    };
                    class MainText : MainText
                    {
                        text = "ТАНГАЖ: 75 г.";
                        onLoad = "uiNameSpace setVariable ['DB_zala421_HUD_pitch_mainText', _this # 0]";
                        w = GRID_W(12);
                    };
                };
            };
        };
    };
};