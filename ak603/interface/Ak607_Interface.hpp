#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

#define AK_BASEBOX_H ( GRID_H(1.4) ) 

class ctrlControlsGroupNoScrollBars;
class ctrlStaticBackGround;
class ctrlStructuredText;

class Ak607_UI_BaseBox : ctrlControlsGroupNoScrollBars
{
    idc = -1;

    x = 0;
    y = 0;
    w = 0;
    h = AK_BASEBOX_H;

    class controls
    {
        class BackGround : ctrlStaticBackGround
        {
            idc = 102;

            colorBackGround[] = {0, 0, 0, 1};

            x = 0;
            y = 0;
            w = 0;
            h = AK_BASEBOX_H;
        };

        class Text : ctrlStructuredText
        {
            idc = 101;

            class Attributes
            {
                font = "PuristaMedium";
            };

            shadow = 0;
            size = GRID_H(1.25);

            x = 0;
            y = 0;
            w = 0;
            h = AK_BASEBOX_H;
        };
    };
};

class RscTitles
{
    class Ak607_Interface
    {
        idd = -1;
        duration = 1e10;

        class controls
        {
            class MTK_2 : Ak607_UI_BaseBox
            {
                idc = -1;

                x = safeZoneX + safeZoneW - GRID_W(10) - GRID_W(3);
                y = safeZoneY + GRID_H(5);
                w = GRID_W(10);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(10);
                    };

                    class Text : Text
                    {
                        text = "$STR_AK603_MTK_2";
                        w = GRID_W(6);
                    };
                };
            };

            class Date : Ak607_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_Ak607_date_UI"", _this # 0]";

                idc = -1;

                x = safeZoneX + GRID_W(3);
                y = safeZoneY + safeZoneH - GRID_H(3.75);
                w = GRID_W(12);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(12);
                    };

                    class Text : Text
                    {
                        text = "21-03-13   13:10:41";
                        w = GRID_W(12);
                    };
                };
            };

            class WeaponInfo : Ak607_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_Ak607_weaponInfo_UI"", _this # 0]";
                
                idc = -1;

                x = safeZoneX + GRID_W(3);
                y = safeZoneY + safeZoneH - GRID_H(2) - GRID_H(0.25);
                w = GRID_W(18);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(18);
                    };

                    class Text : Text
                    {
                        text = "КУ=-103.0°";
                        w = GRID_W(18);
                    };
                };
            };

            class AmmoInfo : Ak607_UI_BaseBox
            {
                onLoad = "uiNameSpace setVariable [""DB_Ak607_AmmoInfo_UI"", _this # 0]";

                idc = -1;

                x = safeZoneX + safeZoneW -  GRID_W(12) - GRID_W(3);
                y = safeZoneY + safeZoneH - GRID_H(2) - GRID_H(0.25);
                w = GRID_W(12);

                class controls : controls
                {
                    class BackGround : BackGround
                    {
                        w = GRID_W(12);
                    };

                    class Text : Text
                    {
                        text = "21-03-13   13:10:41";
                        w = GRID_W(12);
                    };
                };
            };
        };
    };
};