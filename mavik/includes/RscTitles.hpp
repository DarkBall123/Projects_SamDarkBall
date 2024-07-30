#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

#define MAIN_PADDING ( GRID_W(1.5) )
#define MAIN_PADDING_H ( GRID_H(1.3) ) 

class ctrlStaticPicture;
class ctrlControlsGroupNoScrollBars;
class ctrlStaticBackGround;
class ctrlStructuredText;

class RscTitles
{
	class Mavic_Interface
    {
        idd = -1;
        duration = 1e10;

        class controls
        {
            class Camera_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\camera.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) / 2 - GRID_W(2.0)/2 - MAIN_PADDING;
                y = safeZoneY + safeZoneH - GRID_H(2.0) - MAIN_PADDING_H;
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class Settings_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\dots.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) / 2 - GRID_W(2.0)/2 - MAIN_PADDING;
                y = safeZoneY + MAIN_PADDING_H;
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class Exit_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\triangle.paa";

                x = safeZoneX + MAIN_PADDING;
                y = safeZoneY + MAIN_PADDING_H;
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class FlightMode_Text : ctrlStructuredText
            {
                idc = -1;

                text = "$STR_mavic_fligtMode";

                x = safeZoneX + MAIN_PADDING + GRID_W(2.0) + GRID_W(3.0);
                y = safeZoneY + MAIN_PADDING_H + GRID_H(0.3);
                w = GRID_W(5.0);
                h = GRID_H(2.0);

                size = GRID_H(1.2);

                class Attributes
                {
                    font = "PuristaMedium";
                };
            };

            class FlightStatus_Text : FlightMode_Text
            {
                text = "In Flight";

                onLoad = "uiNameSpace setVariable ['DB_mavic_FlightStatus_Text', _this # 0];";

                x = safeZoneX + MAIN_PADDING + GRID_W(2.0) + GRID_W(3.0) + 2*GRID_W(3.0);
            };

            class Cross : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\kross.paa";

                x = 0.5 - GRID_W(5.0) / 2;
                y = 0.5 - GRID_H(5.0) / 2;
                w = GRID_W(5.0);
                h = GRID_H(5.0);
            };

            class MapTriangle_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\maptriangle.paa";

                x = safeZoneX + MAIN_PADDING
                y = 0.5 - GRID_H(2.0);
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class RTH_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\arrow.paa";

                x = safeZoneX + MAIN_PADDING
                y = 0.5 + GRID_H(2.0);
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };
            
            class Record_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\redcircle.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) - MAIN_PADDING;
                y = 0.5 - GRID_H(3) / 2;
                w = GRID_W(3);
                h = GRID_H(3);
            };

            class Play_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\play.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) / 2 - GRID_W(2.0)/2 - MAIN_PADDING;
                y = 0.5 - GRID_H(2.0) / 2 + GRID_H(3) + MAIN_PADDING_H;
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class Galery_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\galery.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) / 2 - GRID_W(2.0)/2 - MAIN_PADDING;
                y = 0.5 - GRID_H(2.0) / 2 - GRID_H(3) - MAIN_PADDING_H;
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class Zoom_Display : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\zoom\zoom.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) - GRID_W(2.2) - 2*MAIN_PADDING;
                y = 0.5 - GRID_H(2.2) / 2;
                w = GRID_W(2.2);
                h = GRID_H(2.2);
            };

            class Zoom_Text : ctrlStructuredText
            {
                idc = -1;

                text = "4x";

                onLoad = "uiNameSpace setVariable ['DB_mavic_Zoom_Text', _this # 0];";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) - GRID_W(2.2) - 2*MAIN_PADDING;
                y = 0.5 - GRID_H(2.2) / 2 + GRID_H(0.5);
                w = GRID_W(2.2);
                h = GRID_H(2.2);

                size = GRID_H(1.1);

                class Attributes
                {
                    align = "center";
                    font = "PuristaSemiBold";
                };
            };

            class MemoryPicture : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\main\memory.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) - GRID_W(2.2) - 2*MAIN_PADDING;
                y = safeZoneY + safeZoneH - GRID_H(2.0) - MAIN_PADDING_H;
                w = GRID_W(2.0);
                h = GRID_H(2.0);
            };

            class AF_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\zoom\AF.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) - GRID_W(2.2) - 2*MAIN_PADDING;
                y = 0.5 - GRID_H(2.2) / 2 + GRID_H(2.2) + GRID_H(0.05);
                w = GRID_W(2.2);
                h = GRID_H(2.2);
            };

            class Binoc_Button : ctrlStaticPicture
            {
                idc = -1;

                text = "\mavik\interface\zoom\binocular.paa";

                x = safeZoneX + safeZoneWAbs - GRID_W(3) - GRID_W(2.2) - 2*MAIN_PADDING;
                y = 0.5 - GRID_H(2.2) / 2 - GRID_H(2.2) - GRID_H(0.3);
                w = GRID_W(2.2);
                h = GRID_H(2.2);
            };

            class UAVInfo_Group : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = safeZoneXAbs + GRID_W(0.8);
                y = safezoneY + safeZoneH - GRID_H(3) - GRID_H(0.4);
                w = GRID_W(15);
                h = GRID_H(3);

                class controls
                {
                    class Map_Picture : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\mavik\interface\main\map.paa";

                        x = 0;
                        y = 0;
                        w = GRID_W(3.0);
                        h = GRID_H(3.0);
                    };
                    
                    class H_Text : ctrlStructuredText
                    {
                        idc = -1;

                        x = GRID_W(3.0) + GRID_W(0.2);
                        y = GRID_H(3) - GRID_H(1.4);
                        w = GRID_W(1.4);
                        h = GRID_H(1.4);

                        text = "H";
                        size = GRID_H(1.4);

                        class Attributes
                        {
                            color = "#ccc5c5";
                            font = "PuristaMedium";
                        };
                    };

                    class VSpeed : ctrlStructuredText
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_mavic_VSpeed_control', _this # 0];";

                        x = GRID_W(3.0) + GRID_W(1.4) + GRID_W(0.2);
                        y = GRID_H(0.7);
                        w = GRID_W(6);
                        h = GRID_H(3) - GRID_H(0.7);

                        text = "0.0 km/h";
                        size = GRID_H(0.9);


                        class Attributes
                        {
                            font = "PuristaMedium";
                        };
                    };

                    class Height : VSpeed
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_mavic_Height_control', _this # 0];";

                        y = GRID_H(3) - GRID_H(1.3) - GRID_H(0.1);
                        h = GRID_H(1.3);

                        text = "0.0 ft";
                        size = GRID_H(1.3);
                    };

                    class D_Text : H_Text
                    {
                        idc = -1;

                        x = GRID_W(3.0) + 4*GRID_W(1.4) + GRID_W(1.0) - GRID_W(1.4);
                        text = "D";
                    };

                    class HSpeed : ctrlStructuredText
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_mavic_HSpeed_control', _this # 0];";

                        x = GRID_W(3.0) + 4*GRID_W(1.4) + GRID_W(1.0);
                        y = GRID_H(0.7);
                        w = GRID_W(6);
                        h = GRID_H(3) - GRID_H(0.7);

                        text = "0.0 km/h";
                        size = GRID_H(0.9);

                        class Attributes
                        {
                            font = "PuristaMedium";
                        };
                    };

                    class Distance : HSpeed
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable ['DB_mavic_Distance_control', _this # 0];";

                        y = GRID_H(3) - GRID_H(1.3) - GRID_H(0.1);
                        h = GRID_H(1.3);

                        text = "0.0 ft";
                        size = GRID_H(1.3);
                    };
                };
            };

            class StatusInfo_Group : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                x = safeZoneX + safeZoneWAbs - GRID_W(5) - GRID_W(11.2);
                y = safeZoneY + MAIN_PADDING_H;
                w = GRID_W(15);
                h = GRID_H(2.0);

                class controls
                {
                    class Battery : ctrlStaticPicture
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable [""DB_mavic_batteryPicture"", _this # 0]";

                        text = "\mavik\interface\bat\100.paa";

                        x = 0;
                        y = 0;
                        w = GRID_W(1.5);
                        h = GRID_H(1.5);
                    };

                    class BatteryText : ctrlStructuredText
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable [""DB_mavic_batteryText"", _this # 0]";

                        text = "99";

                        x = 0;
                        y = GRID_H(0.8) / 2 - GRID_H(0.08);
                        w = GRID_W(1.5);
                        h = GRID_H(1.5) - GRID_H(0.8);

                        size = GRID_H(0.8);

                        class Attributes
                        {
                            color = "#4cbb90";
                            font = "PuristaMedium";
                            align = "center";
                        };
                    };

                    class RemainingTime : ctrlStructuredText
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable [""DB_mavic_RemainingTimeText"", _this # 0]";

                        text = "00'00""";

                        size = GRID_H(1.2);

                        class Attributes
                        {
                            font = "PuristaMedium";
                        };

                        x = GRID_W(1.5) + GRID_W(0.1);
                        y = 0;
                        w = GRID_W(4);
                        h = GRID_H(2);
                    };

                    class Signal : ctrlStaticPicture
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable [""DB_mavic_SignalText"", _this # 0]";

                        text = "\mavik\interface\signal\100.paa";

                        x = GRID_W(1.5) + GRID_W(3.2) + GRID_W(0.1);
                        y = GRID_H(1.5) / 2 - GRID_H(1.2) / 2;
                        w = GRID_W(1.2);
                        h = GRID_H(1.2);
                    }; 

                    class Sensor : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\mavik\interface\main\sensor.paa";

                        x = GRID_W(1.5) + GRID_W(3.2) + GRID_W(1.2) + 4*GRID_W(0.1);
                        y = GRID_H(1.5) / 2 - GRID_H(1.2) / 2;
                        w = GRID_W(1.2);
                        h = GRID_H(1.2);
                    }; 

                    class Satellite : ctrlStaticPicture
                    {
                        idc = -1;

                        onLoad = "uiNameSpace setVariable [""DB_mavic_SatellitePicture"", _this # 0]";

                        text = "\mavik\interface\main\sat0.paa";

                        x = GRID_W(1.5) + GRID_W(3.2) + GRID_W(1.2) + 4*GRID_W(0.1) + GRID_W(1.2) + GRID_W(0.1);
                        y = GRID_H(1.5) / 2 - GRID_H(1.2) / 2;
                        w = GRID_W(1.2);
                        h = GRID_H(1.2);
                    }; 

                    class Datchik : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\mavik\interface\main\datchik.paa";

                        x = GRID_W(1.5) + GRID_W(3.2) + GRID_W(1.2) + 5*GRID_W(0.1) + 2*GRID_W(1.2) + GRID_W(0.1);
                        y = GRID_H(1.5) / 2 - GRID_H(1.2) / 2;
                        w = GRID_W(1.2);
                        h = GRID_H(1.2);
                    };
                };
            };

            class DetachGrenade : ctrlControlsGroupNoScrollBars
            {
                idc = -1;

                fade = 1;

                onLoad = "uiNameSpace setVariable [""DB_DetachGrenade_group"", _this # 0]";

                x = 0.5 - GRID_W(11) / 2;
                y = 0.5 - GRID_H(6) / 2;
                w = GRID_W(11);
                h = GRID_H(6);

                class controls
                {
                    class BackGround : ctrlStaticPicture
                    {
                        idc = -1;

                        text = "\mavik\interface\detach\big.paa";

                        x = 0;
                        y = 0;
                        w = GRID_W(11);
                        h = GRID_H(6);  
                    };

                    class Text : ctrlStructuredText
                    {
                        idc = -1;

                        class Attributes
                        {
                            align = "center";
                            font = "PuristaMedium";
                        };

                        size = GRID_H(0.9);

                        text = "$STR_mavic_dropMessage";

                        x = 0;
                        y = GRID_H(6) - GRID_H(1) - GRID_H(0.9);
                        w = GRID_W(11);
                        h = GRID_H(1);
                    };
                };
            };
        };

        class controlsBackground
        {
            class Gradient : ctrlStaticPicture
            {
                idc = -1;

                onLoad = "uiNamespace setVariable [""DB_gradient_control"", _this # 0];";

                text = "\mavik\interface\signal\gradient.paa";
                
                x = safeZoneXAbs;
                y = safeZoneY;
                w = safeZoneWAbs;
                h = safeZoneH;

                show = 0;
            };
        };
    };
}; 