class RscText;
class ctrlControlsGroupNoScrollBars;
class ctrlControlsGroup;
class ctrlStaticPicture;
class ctrlStructuredText;

#define GRID_W(num) ( num * (pixelGridNoUIScale * pixelW * 2) )
#define GRID_H(num) ( num * (pixelGridNoUIScale * pixelH * 2) )

#define WX_POS    (safeZoneXAbs)
#define WY_POS    (safeZoneY)
#define W_WIDTH   (safeZoneWAbs)
#define W_HEIGHT  (safeZoneH)

#define SZ_S   GRID_H(1.0)
#define SZ_M   GRID_H(1.2)
#define SZ_L   GRID_H(1.4)

class RscTitles
{
    class vnd_Dialog
    {
        idd = -1;
        duration = 1e+038;
        movingEnable = 0;
        enableSimulation = 1;
        
        class controls
        {
            class TL_Group: ctrlControlsGroupNoScrollBars
            {
                idc = -1;
                x = WX_POS + GRID_W(1);
                y = WY_POS + GRID_H(1);
                w = GRID_W(22);
                h = GRID_H(8);

                class controls
                {
                    class TL_ModeText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_TL_ModeText', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size = SZ_M;
                        text = "ACRO";
                        x = 0; y = 0; w = GRID_W(22); h = GRID_H(1.5);
                    };
                    class TL_TimeText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_TL_TimeText', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_M;
                        text = "11:16";
                        x = 0; y = GRID_H(1.6); w = GRID_W(22); h = GRID_H(1.5);
                    };
                    class TL_AltText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_TL_AltText', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_M;
                        text = "6.7 alt m";
                        x = 0; y = GRID_H(3.2); w = GRID_W(22); h = GRID_H(1.5);
                    };
                };
            };

            class TC_Group: ctrlControlsGroupNoScrollBars
            {
                idc = -1;
                w = GRID_W(24);
                h = GRID_H(2);
                x = WX_POS + (W_WIDTH/2) - GRID_W(24)/2;
                y = WY_POS + GRID_H(1);

                class controls
                {
                    class TC_Voltage1: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_TC_V1', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "center"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_M;
                        text = "21.3V";
                        x = 0; y = 0; w = GRID_W(11); h = GRID_H(2);
                    };
                    class TC_Voltage2: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_TC_V2', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "center"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_M;
                        text = "3.55V";
                        x = GRID_W(13); y = 0; w = GRID_W(11); h = GRID_H(2);
                    };
                };
            };

            class BL_Group: ctrlControlsGroupNoScrollBars
            {
                idc = -1;
                x = WX_POS + GRID_W(1);
                y = WY_POS + W_HEIGHT - GRID_H(8) - GRID_H(1);
                w = GRID_W(24);
                h = GRID_H(8);

                class controls
                {
                    class BL_LinkText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_BL_Link', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "link-ok";
                        x = 0; y = 0; w = GRID_W(24); h = GRID_H(1.3);
                    };
                    class BL_RxText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_BL_Rx', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "rx: -2.232";
                        x = 0; y = GRID_H(1.4); w = GRID_W(24); h = GRID_H(1.3);
                    };
                    class BL_TxText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_BL_Tx', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "tx: 0.961";
                        x = 0; y = GRID_H(2.8); w = GRID_W(24); h = GRID_H(1.3);
                    };
                    class BL_FWText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_BL_FW', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "left"; shadow = 2; color = "#FFFFFFFF"; shadowColor = "#000000CC"; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "FW: 2.17";
                        x = 0; y = GRID_H(4.2); w = GRID_W(24); h = GRID_H(1.3);
                    };
                };
            };

            class BC_FPS_Text: ctrlStructuredText
            {
                idc = -1;
                onLoad = "uiNamespace setVariable ['vnd_BC_FPS', _this # 0];";
                class Attributes { font = "VCROSDMono"; align = "center"; shadow = 1; };
                shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                text = "FPS: 31";
                w = GRID_W(12); h = GRID_H(1.5);
                x = 0.5 - GRID_W(12)/2;
                y = WY_POS + W_HEIGHT - GRID_H(3);
            };

            class RB_Group: ctrlControlsGroupNoScrollBars
            {
                idc = -1;
                w = GRID_W(26);
                h = GRID_H(12);
                x = WX_POS + (W_WIDTH/2) + GRID_W(2);
                y = WY_POS + W_HEIGHT - GRID_H(8) - GRID_H(1);

                class controls
                {
                    class RB_CurrentText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_RB_Current', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "right"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "40.6 A";
                        x = 0; y = 0; w = GRID_W(26); h = GRID_H(1.3);
                    };
                    class RB_mAhText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_RB_mAh', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "right"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "7721 mAh";
                        x = 0; y = GRID_H(1.4); w = GRID_W(26); h = GRID_H(1.3);
                    };
                    class RB_PercentText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_RB_Percent', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "right"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "48 %";
                        x = 0; y = GRID_H(2.8); w = GRID_W(26); h = GRID_H(1.3);
                    };
                    class RB_ThrottleText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_RB_Spd', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "right"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "spd: 57 %";
                        x = 0; y = GRID_H(4.2); w = GRID_W(26); h = GRID_H(1.3);
                    };
                    class RB_PitchText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_RB_Pitch', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "right"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "pitch: 3.3";
                        x = 0; y = GRID_H(5.6); w = GRID_W(26); h = GRID_H(1.3);
                    };
                    class RB_SNText: ctrlStructuredText
                    {
                        idc = -1;
                        onLoad = "uiNamespace setVariable ['vnd_RB_SN', _this # 0];";
                        class Attributes { font = "VCROSDMono"; align = "right"; shadow = 1; };
                        shadow = 2; colorShadow[] = {0,0,0,0.8}; size= SZ_S;
                        text = "SN: 9621391";
                        x = 0; y = GRID_H(7.0); w = GRID_W(26); h = GRID_H(1.3);
                    };
                };
            };

            class Center_Target: ctrlStaticPicture
            {
                idc = -1;
                text = "\vnd_main\pictures\plus_sight.paa";
                x = 0.5 - GRID_W(3)/2;
                y = 0.5 - GRID_H(3)/2;
                w = GRID_W(3);
                h = GRID_H(3);
            };

            class H_Line_L: ctrlStaticPicture
            {
                idc = -1;
                onLoad = "uiNamespace setVariable ['vnd_HLine_L', _this # 0];";
                text = "\vnd_main\pictures\h_line.paa";
                w = GRID_W(12);
                h = GRID_H(0.5);
                x = 0.5 - GRID_W(1) - GRID_W(12);
                y = 0.5 - GRID_H(0.5)/2 - GRID_H(0.6);
            };
            class H_Line_R: ctrlStaticPicture
            {
                idc = -1;
                onLoad = "uiNamespace setVariable ['vnd_HLine_R', _this # 0];";
                text = "\vnd_main\pictures\h_line.paa";
                w = GRID_W(12);
                h = GRID_H(0.5);
                x = 0.5 + GRID_W(1);
                y = 0.5 - GRID_H(0.5)/2 - GRID_H(0.6);
            };

        };
    };
};
