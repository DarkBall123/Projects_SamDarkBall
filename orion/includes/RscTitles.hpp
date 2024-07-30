#include "uiDefines.hpp"

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
    class orion_HUD_Gunner
    {
        duration = 1e10;
		movingEnable = false;
		enableSimulation = true;
		idd = -1;

        onLoad = "uiNameSpace setVariable ['DB_orionHUD_display', _this # 0]";

        class controls
        {
            class DirectionGroup : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = 0.5 - GRID_W(20) / 2;
                y = 0.5 - GRID_H(20) / 2;
                w = GRID_W(20);
                h = GRID_H(20);

                class controls
                {
                    class CameraDirectionLine : ctrlStaticPicture
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_CameraDirectionLine', _this # 0]";

                        text = "\orion\pictures\display\line\6.paa";

                        x = 0;
                        y = 0;
                        w = GRID_W(20);
                        h = GRID_H(20);
                    };
            
                    class UavDirectionLine : ctrlStaticPicture
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_UavDirectionLine', _this # 0]";

                        text = "\orion\pictures\display\trio\12.paa";

                        x = 0;
                        y = 0;
                        w = GRID_W(20);
                        h = GRID_H(20);
                    };
                };
            };

            class HorizontalDirectionGroup : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = 0.5 - GRID_W(40.25) / 2;
                y = safeZoneY;
                w = GRID_W(40.25);
                h = GRID_H(4.25);

                class controls
                {
                    class Line : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\orion\pictures\display\direction\line.paa";

                        x = 0;
                        y = GRID_H(0);
                        w = GRID_W(40.25);
                        h = GRID_H(4.25);
                    };

                    class Cursor : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\orion\pictures\display\direction\triangle.paa";

                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_horDirectionCursor', _this # 0]";

                        x = GRID_W(40.25) / 2 - GRID_W(0.5) / 2;
                        y = GRID_H(0.55);
                        w = GRID_W(0.5);
                        h = GRID_H(0.5);
                    };
                };  
            };

            class VerticalAngleGroup : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = safeZoneX + safeZoneW - GRID_W(4.25) - GRID_W(1);
                y = 0.5 - GRID_H(30) / 2;
                w = GRID_W(4.25);
                h = GRID_H(30);

                class controls
                {
                    class Line : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\orion\pictures\display\direction\vert.paa";

                        x = 0;
                        y = GRID_H(0);
                        w = GRID_W(4.25);
                        h = GRID_H(30);
                    };

                    class Cursor : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\orion\pictures\display\direction\triangle_side.paa";

                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_verAngleCursor', _this # 0]";

                        x = GRID_W(0.55);
                        y = GRID_H(30) / 2 - GRID_H(0.5) / 2;
                        w = GRID_W(0.5);
                        h = GRID_H(0.5);
                    };
                };  
            };

            class ScaleText : ctrlStructuredText
            {
                idc = -1;

                x = 0.5 + GRID_W(3.2);
                y = 0.5 - GRID_H(0.9) - GRID_H(0.1);
                w = GRID_W(5);
                h = GRID_H(1.2);

                onLoad = "uiNameSpace setVariable ['DB_orionHUD_scaleFactor', _this # 0]";

                text = "12 м";
                size = GRID_H(0.9);

                class Attributes
                {
                    font = "RobotoCondensed";
                };
            };

            class LaserText : ctrlStructuredText
            {
                idc = -1;

                x = 0.5 + GRID_W(3.2);
                y = 0.5 + GRID_H(0.9) - GRID_H(0.1);
                w = GRID_W(5);
                h = GRID_H(2.2);

                onLoad = "uiNameSpace setVariable ['DB_orionHUD_laserText', _this # 0]";

                text = "";
                size = GRID_H(0.9);

                class Attributes
                {
                    font = "RobotoCondensed";
                };
            };

            class WeaponInfo : ctrlStructuredText
            {
                idc = -1;

                size = GRID_H(1.2);

                onLoad = "uiNameSpace setVariable ['DB_orionHUD_weaponText', _this # 0]";

                text = "";

                class Attributes
                {
                    font = "PuristaLight";
                };

                x = safeZoneX + GRID_W(1);
                y = safeZoneY + safeZoneH - GRID_H(1.4) - GRID_H(0.5);
                w = GRID_W(20); // for safety
                h = GRID_H(1.4);
            };

            class LaunchAccessPicture : ctrlStaticPicture
            {
                idc = -1;

                onLoad = "uiNameSpace setVariable ['DB_orionHUD_launchAccessPicture', _this # 0]";

                text = "";

                x = safeZoneX + GRID_W(3);
                y = safeZoneY + safeZoneH - GRID_H(2) - 4*GRID_H(0.5);
                w = GRID_W(2);
                h = GRID_H(2);
            };
        };
    };

    class orion_HUD_Driver
    {
        duration = 1e10;
		movingEnable = false;
		enableSimulation = true;
		idd = -1;

        onLoad = "uiNameSpace setVariable ['DB_orionHUD_display_driver', _this # 0]";

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
                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_coord_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_fuel_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_alt_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_status_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_droneSpeed_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orionHUD_pitch_mainText', _this # 0]";
                        w = GRID_W(12);
                    };
                };
            };
        };
    };
};