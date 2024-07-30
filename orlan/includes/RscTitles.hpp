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
    class Orlan_HUD
    {
        duration = 1e10;
		movingEnable = false;
		enableSimulation = true;
		idd = -1;

        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_display', _this # 0]";

        class controls
        {
            
            class AngleBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X;
                y = ANGLE_GROUP_Y;

                class controls : controls
                {
                    class WhiteBackGround : WhiteBackGround {};
                    class TopBackGround : TopBackGround {};
                    class MainText : MainText
                    {
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_angle_mainText', _this # 0]";
                        text = "19";
                    };
                };
            };

            class AngleScale_Group : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = ANGLE_GROUP_X + INFOBOX_W / 2 - ANGLE_SCALE_W / 2;
                y = ANGLE_GROUP_Y + INFOBOX_H;
                w = 3*ANGLE_SCALE_W;
                h = ANGLE_SCALE_H;

                class controls
                {
                    class LinePicture : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\orlan\pictures\line.paa";

                        x = 0;
                        y = 0;
                        w = ANGLE_SCALE_W;
                        h = ANGLE_SCALE_H;
                    };

                    class CursorPicture : ctrlStaticPicture
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_angle_cursorPicture', _this # 0]";

                        text = "\orlan\pictures\triangle.paa";

                        x = ANGLE_SCALE_W - GRID_W(1);
                        y = 0;
                        w = GRID_W(3);
                        h = GRID_H(3);
                    };
                };
            };

            class LaserBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(1);
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
                        text = "LASER: ON";
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_laser_mainText', _this # 0]";
                        w = GRID_W(8);
                    };
                };
            };

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
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_coord_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_fuel_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_alt_mainText', _this # 0]";
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
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_status_mainText', _this # 0]";
                        w = GRID_W(12);
                    };
                };
            };

            class DirectionGroup : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = (ANGLE_GROUP_X + INFOBOX_W + 3*GRID_W(8) + GRID_W(12) + GRID_W(1) + 4*GRID_W(0.5)) + GRID_W(12) / 2 - GRID_W(5) / 2 + GRID_W(1);
                y = ANGLE_GROUP_Y + GRID_H(1.2);
                w = GRID_W(5);
                h = GRID_H(6.8);

                class controls
                {
                    class Picture : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\orlan\pictures\12.paa";

                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_direction_picture', _this # 0]";

                        x = 0;
                        y = 0;
                        w = GRID_W(5);
                        h = GRID_H(5);
                    };

                    class Box : InfoBox_Base
                    {
                        x = GRID_W(5) / 2 - INFOBOX_W / 2;
                        y = GRID_H(6.8) - INFOBOX_H;

                        class controls : controls
                        {
                            class WhiteBackGround : WhiteBackGround {};
                            class TopBackGround : TopBackGround {};
                            class MainText : MainText
                            {
                                text = "180";
                                onLoad = "uiNameSpace setVariable ['DB_orlanHUD_direction_mainText', _this # 0]";
                            };
                        };
                    };
                };
            };

            class LaserDistanceBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(1);
                y = ANGLE_GROUP_Y - INFOBOX_H  + INFOBOX_H + GRID_H(0.4);
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
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_laserDistance_mainText', _this # 0]";
                        text = "2100 м.";
                        w = GRID_W(8);
                    };
                };
            };

            class DroneSpeedBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(8) + GRID_W(1) + GRID_W(0.5);
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
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_droneSpeed_mainText', _this # 0]";
                        text = "СКОРОСТЬ: 120 КМ/Ч";
                        w = GRID_W(12);
                    };
                };
            };

            class PitchBox : InfoBox_Base
            {
                x = ANGLE_GROUP_X + INFOBOX_W + GRID_W(8) + GRID_W(12) + GRID_W(1) + 2*GRID_W(0.5);
                y = ANGLE_GROUP_Y - INFOBOX_H  + INFOBOX_H + GRID_H(0.4);
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
                        text = "ТАНГАЖ: 75 г.";
                        onLoad = "uiNameSpace setVariable ['DB_orlanHUD_pitch_mainText', _this # 0]";
                        w = GRID_W(8);
                    };
                };
            };
        };
    };
};