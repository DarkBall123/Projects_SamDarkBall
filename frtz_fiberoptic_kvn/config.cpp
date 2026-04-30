class CfgPatches
{
	class frtz_KVN
	{
		author="Fritz & Smoke";
		name="kvn";
		url="https://t.me/KB_Arma1161";
		requiredAddons[]=
		{
			"A3_Data_F_AoW_Loadorder",
			"A3_Data_F",
			"A3_Drones_F",
			"cba_settings"
		};
		requiredVersion=0.1;
		units[]=
		{
			"frtz_O_KVN_AT",
			"frtz_O_KVN_AP",
			"frtz_O_KVN_AT_TI",
			"frtz_O_KVN_AP_TI",
			"frtz_O_KVN_AT_20KM",
			"frtz_O_KVN_AP_20KM",
			"frtz_O_KVN_AT_TI_20KM",
			"frtz_O_KVN_AP_TI_20KM",
			"frtz_O_KVN_AT_25KM",
			"frtz_O_KVN_AP_25KM",
			"frtz_O_KVN_AT_TI_25KM",
			"frtz_O_KVN_AP_TI_25KM",
			"frtz_B_KVN_AT",
			"frtz_B_KVN_AP",
			"frtz_B_KVN_AT_TI",
			"frtz_B_KVN_AP_TI",
			"frtz_B_KVN_AT_20KM",
			"frtz_B_KVN_AP_20KM",
			"frtz_B_KVN_AT_TI_20KM",
			"frtz_B_KVN_AP_TI_20KM",
			"frtz_B_KVN_AT_25KM",
			"frtz_B_KVN_AP_25KM",
			"frtz_B_KVN_AT_TI_25KM",
			"frtz_B_KVN_AP_TI_25KM",
			"frtz_I_KVN_AT",
			"frtz_I_KVN_AP",
			"frtz_I_KVN_AT_TI",
			"frtz_I_KVN_AP_TI",
			"frtz_I_KVN_AT_20KM",
			"frtz_I_KVN_AP_20KM",
			"frtz_I_KVN_AT_TI_20KM",
			"frtz_I_KVN_AP_TI_20KM",
			"frtz_I_KVN_AT_25KM",
			"frtz_I_KVN_AP_25KM",
			"frtz_I_KVN_AT_TI_25KM",
			"frtz_I_KVN_AP_TI_25KM"
		};
		weapons[]={};
	};
};
class RscText;
class ctrlControlsGroupNoScrollBars;
class ctrlControlsGroup;
class ctrlStaticPicture;
class ctrlStructuredText;
class RscTitles
{
	class kvn_Dialog
	{
		idd=-1;
		duration=9.9999997e+037;
		movingEnable=0;
		enableSimulation=1;
		class controlsBackground
		{
			class NoImage_BG: RscText
			{
				idc=-1;
				onLoad="uiNamespace setVariable ['kvn_NoImage_BG', _this # 0]; (_this # 0) ctrlShow false;";
				colorBackground[]={0.32,0.32,0.32,1};
				text="";
				x="safeZoneXAbs";
				y="safeZoneY";
				w="safeZoneWAbs";
				h="safeZoneH";
			};
		};
		class controls
		{
			class TL_Group: ctrlControlsGroupNoScrollBars
			{
				idc=-1;
				x="(safeZoneXAbs) + ( 1 * (pixelGridNoUIScale * pixelW * 2) )";
				y="(safeZoneY) + ( 1 * (pixelGridNoUIScale * pixelH * 2) )";
				w="( 22 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 8 * (pixelGridNoUIScale * pixelH * 2) )";
				class controls
				{
					class TL_ModeText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_TL_ModeText', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.2 * (pixelGridNoUIScale * pixelH * 2) )";
						text="ACRO";
						x=0;
						y=0;
						w="( 22 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.5 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class TL_TimeText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_TL_TimeText', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.2 * (pixelGridNoUIScale * pixelH * 2) )";
						text="11:16";
						x=0;
						y="( 1.6 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 22 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.5 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class TL_AltText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_TL_AltText', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.2 * (pixelGridNoUIScale * pixelH * 2) )";
						text="6.7 alt m";
						x=0;
						y="( 3.2 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 22 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.5 * (pixelGridNoUIScale * pixelH * 2) )";
					};
				};
			};
			class TC_RXb_Text: ctrlStructuredText
			{
				idc=-1;
				class Attributes
				{ 
					font="VCROSDMono";
					align="left";
					shadow=1;
				};
				shadow=2;
				size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
				text="RXb: 0";
				x="(safeZoneXAbs) + ( 1 * (pixelGridNoUIScale * pixelW * 2) )";
				y="0.42"; 
				w="( 10 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class TC_Group: ctrlControlsGroupNoScrollBars
			{
				idc=-1;
				w="( 24 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 2 * (pixelGridNoUIScale * pixelH * 2) )";
				x="(safeZoneXAbs) + ((safeZoneWAbs)/2) - ( 24 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="(safeZoneY) + ( 1 * (pixelGridNoUIScale * pixelH * 2) )";
				class controls
				{
					class TC_Voltage1: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_TC_V1', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="center";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.2 * (pixelGridNoUIScale * pixelH * 2) )";
						text="21.3V";
						x=0;
						y=0;
						w="( 11 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 2 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class TC_Voltage2: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_TC_V2', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="center";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.2 * (pixelGridNoUIScale * pixelH * 2) )";
						text="3.55V";
						x="( 13 * (pixelGridNoUIScale * pixelW * 2) )";
						y=0;
						w="( 11 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 2 * (pixelGridNoUIScale * pixelH * 2) )";
					};
				};
			};
			class BL_Group: ctrlControlsGroupNoScrollBars
			{
				idc=-1;
				x="(safeZoneXAbs) + ( 1 * (pixelGridNoUIScale * pixelW * 2) )";
				y="(safeZoneY) + (safeZoneH) - ( 8 * (pixelGridNoUIScale * pixelH * 2) ) - ( 1 * (pixelGridNoUIScale * pixelH * 2) )";
				w="( 24 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 8 * (pixelGridNoUIScale * pixelH * 2) )";
				class controls
				{
					class BL_LinkText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_BL_Link', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="link-ok";
						x=0;
						y="( 0.01 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 24 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class BL_RxText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_BL_Rx', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="RXg: -2.232";
						x=0;
						y="( 2.8 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 24 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class BL_TxText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_BL_Tx', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="TXg: 0.961";
						x=0;
						y="( 3.6 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 24 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class BL_FWText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_BL_FW', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="left";
							shadow=2;
							color="#FFFFFFFF";
							shadowColor="#000000CC";
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="FW: 2.17";
						x=0;
						y="( 5.6 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 24 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
				};
			};
			class BC_FPS_Text: ctrlStructuredText
			{
				idc=-1;
				onLoad="uiNamespace setVariable ['kvn_BC_FPS', _this # 0];";
				class Attributes
				{
					font="VCROSDMono";
					align="center";
					shadow=1;
				};
				shadow=2;
				colorShadow[]={0,0,0,0.80000001};
				size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
				text="FPS: 31";
				w="( 12 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 1.5 * (pixelGridNoUIScale * pixelH * 2) )";
				x="0.41 - ( 12 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="(safeZoneY) + (safeZoneH) - ( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class RB_Group: ctrlControlsGroupNoScrollBars
			{
				idc=-1;
				w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 12 * (pixelGridNoUIScale * pixelH * 2) )";
				x="(safeZoneXAbs) + ((safeZoneWAbs)/2) + ( 2 * (pixelGridNoUIScale * pixelW * 2) )";
				y="(safeZoneY) + (safeZoneH) - ( 8 * (pixelGridNoUIScale * pixelH * 2) ) - ( 1 * (pixelGridNoUIScale * pixelH * 2) )";
				class controls
				{
					class RB_CurrentText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_RB_Current', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="right";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="40.6 A";
						x=0;
						y=0;
						w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class RB_mAhText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_RB_mAh', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="right";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="7721 mAh";
						x=0;
						y="( 1.4 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class RB_PercentText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_RB_Percent', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="right";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="48 %";
						x=0;
						y="( 2.8 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class RB_ThrottleText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_RB_Spd', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="right";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="spd: 57 %";
						x=0;
						y="( 4.2 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
					class RB_SNText: ctrlStructuredText
					{
						idc=-1;
						onLoad="uiNamespace setVariable ['kvn_RB_SN', _this # 0];";
						class Attributes
						{
							font="VCROSDMono";
							align="right";
							shadow=1;
						};
						shadow=2;
						colorShadow[]={0,0,0,0.80000001};
						size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						text="SN: 962139117";
						x="( -1.0 * (pixelGridNoUIScale * pixelH * 2) )";
						y="( 6.7 * (pixelGridNoUIScale * pixelH * 2) )";
						w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
						h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
					};
				};
			};
			class Center_Target: ctrlStaticPicture
			{
				idc=1005;
				onLoad="uiNamespace setVariable ['kvn_Center_Target', _this # 0];";
				colorText[]={1,1,1,1};
				text="\frtz_fiberoptic_kvn\pictures\plus_sight.paa";
				x="0.5 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="0.5 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class NoImage_Text: RscText
			{
				idc=-1;
				onLoad="uiNamespace setVariable ['kvn_NoImage_Text', _this # 0]; (_this # 0) ctrlShow false;";
				style=2;
				font="VCROSDMono";
				shadow=2;
				colorShadow[]={0,0,0,0.85000002};
				colorText[]={0.8,0.8,0.8,1};
				sizeEx="( 2.8 * (pixelGridNoUIScale * pixelH * 2) )";
				text="NO IMAGE";
				x="safeZoneXAbs";
				y="0.5 - ( 4 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="safeZoneWAbs";
				h="( 4 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class Center_PitchText: ctrlStructuredText
			{
				idc=-1;
				onLoad="uiNamespace setVariable ['kvn_RB_Pitch', _this # 0];";
				class Attributes
				{
					font="VCROSDMono";
					align="center";
					shadow=1;
				};
				shadow=2;
				colorShadow[]={0,0,0,0.80000001};
				size="( 1.0 * (pixelGridNoUIScale * pixelH * 2) )";
				text="pitch: 3.3";
				x="0.06 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="0.65 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 26 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 1.3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class H_Line_L: ctrlStaticPicture
			{
				idc=-1;
				onLoad="uiNamespace setVariable ['kvn_HLine_L', _this # 0];";
				text="\frtz_fiberoptic_kvn\pictures\h_line.paa";
				w="( 12 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 0.5 * (pixelGridNoUIScale * pixelH * 2) )";
				x="0.5 - ( 1 * (pixelGridNoUIScale * pixelW * 2) ) - ( 12 * (pixelGridNoUIScale * pixelW * 2) )";
				y="0.5 - ( 0.5 * (pixelGridNoUIScale * pixelH * 2) )/2 - ( 0.6 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class H_Line_R: ctrlStaticPicture
			{
				idc=-1;
				onLoad="uiNamespace setVariable ['kvn_HLine_R', _this # 0];";
				text="\frtz_fiberoptic_kvn\pictures\h_line.paa";
				w="( 12 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 0.5 * (pixelGridNoUIScale * pixelH * 2) )";
				x="0.5 + ( 1 * (pixelGridNoUIScale * pixelW * 2) )";
				y="0.5 - ( 0.5 * (pixelGridNoUIScale * pixelH * 2) )/2 - ( 0.6 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class UAV_Text: ctrlStaticPicture
			{
				idc=-1;
				text="\frtz_fiberoptic_kvn\pictures\text\uav.paa";
				x="-0.6335 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="1.334 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class RC_Text: ctrlStaticPicture
			{
				idc=-1;
				text="\frtz_fiberoptic_kvn\pictures\text\rc.paa";
				x="-0.4335 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="1.334 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class GCS_Text: ctrlStaticPicture
			{
				idc=-1;
				text="\frtz_fiberoptic_kvn\pictures\text\gcs.paa";
				x="-0.2335 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="1.334 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class RECORD_Text: ctrlStaticPicture
			{
				idc=-1;
				text="\frtz_fiberoptic_kvn\pictures\text\record.paa";
				x="-0.0335 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="1.334 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class TURN_ON_Text: ctrlStaticPicture
			{
				idc=-1;
				text="\frtz_fiberoptic_kvn\pictures\text\turn_on.paa";
				x="0.2335 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="1.334 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
			class STANDART_Text: ctrlStaticPicture
			{
				idc=-1;
				text="\frtz_fiberoptic_kvn\pictures\text\standart.paa";
				x="0.4335 - ( 3 * (pixelGridNoUIScale * pixelW * 2) )/2";
				y="1.334 - ( 3 * (pixelGridNoUIScale * pixelH * 2) )/2";
				w="( 3 * (pixelGridNoUIScale * pixelW * 2) )";
				h="( 3 * (pixelGridNoUIScale * pixelH * 2) )";
			};
		};
	};
};
class CfgAmmo
{
	class M_Vorona_HEAT;
	class FPV_RPG42_AT: M_Vorona_HEAT
	{
		explosive=0.80000001;
		hit=150;
		htMax=1800;
		htMin=60;
		indirectHit=25;
		indirectHitRange=3.5;
		submunitionInitSpeed=1000;
		warheadName="TandemHEAT";
		submunitionAmmo="FPV_RPG42_AT_Penetrator";
		submunitionDirectionType="SubmunitionModelDirection";
		submunitionParentSpeedCoef=0;
		submunitionInitialOffset[]={0,0,-0.1};
		triggerOnImpact=1;
		deleteParentWhenTriggered=0;
	};
	class ammo_Penetrator_Vorona;
	class FPV_RPG42_AT_Penetrator: ammo_Penetrator_Vorona
	{
		hit=480;
		indirectHit=0;
		indirectHitRange=0;
		warheadName="TandemHEAT";
	};
};
class CfgFontFamilies
{
	class VCROSDMono
	{
		fonts[]=
		{
			"\frtz_fiberoptic_kvn\font\VCROSDMono6",
			"\frtz_fiberoptic_kvn\font\VCROSDMono7",
			"\frtz_fiberoptic_kvn\font\VCROSDMono8",
			"\frtz_fiberoptic_kvn\font\VCROSDMono9",
			"\frtz_fiberoptic_kvn\font\VCROSDMono10",
			"\frtz_fiberoptic_kvn\font\VCROSDMono11",
			"\frtz_fiberoptic_kvn\font\VCROSDMono12",
			"\frtz_fiberoptic_kvn\font\VCROSDMono13",
			"\frtz_fiberoptic_kvn\font\VCROSDMono14",
			"\frtz_fiberoptic_kvn\font\VCROSDMono15",
			"\frtz_fiberoptic_kvn\font\VCROSDMono16",
			"\frtz_fiberoptic_kvn\font\VCROSDMono17",
			"\frtz_fiberoptic_kvn\font\VCROSDMono18",
			"\frtz_fiberoptic_kvn\font\VCROSDMono19",
			"\frtz_fiberoptic_kvn\font\VCROSDMono20",
			"\frtz_fiberoptic_kvn\font\VCROSDMono21",
			"\frtz_fiberoptic_kvn\font\VCROSDMono22",
			"\frtz_fiberoptic_kvn\font\VCROSDMono23",
			"\frtz_fiberoptic_kvn\font\VCROSDMono24",
			"\frtz_fiberoptic_kvn\font\VCROSDMono25",
			"\frtz_fiberoptic_kvn\font\VCROSDMono26",
			"\frtz_fiberoptic_kvn\font\VCROSDMono27",
			"\frtz_fiberoptic_kvn\font\VCROSDMono28",
			"\frtz_fiberoptic_kvn\font\VCROSDMono29",
			"\frtz_fiberoptic_kvn\font\VCROSDMono30",
			"\frtz_fiberoptic_kvn\font\VCROSDMono31",
			"\frtz_fiberoptic_kvn\font\VCROSDMono34",
			"\frtz_fiberoptic_kvn\font\VCROSDMono35",
			"\frtz_fiberoptic_kvn\font\VCROSDMono37",
			"\frtz_fiberoptic_kvn\font\VCROSDMono40",
			"\frtz_fiberoptic_kvn\font\VCROSDMono42",
			"\frtz_fiberoptic_kvn\font\VCROSDMono44",
			"\frtz_fiberoptic_kvn\font\VCROSDMono46",
			"\frtz_fiberoptic_kvn\font\VCROSDMono48"
		};
		spaceWidth=0.5;
		spacing=0.050000001;
	};
};
class CfgFunctions
{
	class DB_kvn
	{
		tag="DB_kvn";
		class FPV
		{
			file="\frtz_fiberoptic_kvn\functions";
			class fpv_createDialog
			{
			};
			class fpv_destroyUI
			{
			};
			class fpv_showNoImage
			{
			};
			class fpv_uiAnimate
			{
			};
			class fpv_handleConnect
			{
				postInit=1;
			};
			class fpv_droneInit
			{
			};
			class fpv_onDestroy
			{
			};
			class fpv_updateFiberPath
			{
			};
			class fpv_syncPath
			{
			};
			class fpv_receivePath
			{
			};
			class fpv_fiberTick
			{
			};
			class fpv_renderAllFibers
			{
				postInit=1;
			};
			class fpv_drawFiberPath
			{
			};
			class fpv_applyGravity
			{
			};
			class fpv_createKVNOnItemCheck
			{
			};
			class fpv_canDisassembly
			{
			};
			class fpv_addUavToInventory
			{
			};
		};
	};
};
class SensorTemplatePassiveRadar;
class SensorTemplateAntiRadiation;
class SensorTemplateActiveRadar;
class SensorTemplateIR;
class SensorTemplateVisual;
class SensorTemplateMan;
class SensorTemplateLaser;
class SensorTemplateNV;
class SensorTemplateDataLink;
class DefaultVehicleSystemsDisplayManagerLeft
{
	class components;
};
class DefaultVehicleSystemsDisplayManagerRight
{
	class components;
};
class CfgVehicles
{
	class Air;
	class Helicopter: Air
	{
		class Turrets;
		class HitPoints;
	};
	class Helicopter_Base_F: Helicopter
	{
		class Turrets: Turrets
		{
			class MainTurret;
		};
		class HitPoints: HitPoints
		{
			class HitHRotor;
			class HitHull;
		};
		class AnimationSources;
		class EventHandlers;
		class ViewOptics;
		class ViewPilot;
		class Components;
	};
	class frtz_drone_kvn_base_F: Helicopter_Base_F
	{
		features="Randomization: No<br />Camo selections: 1 - the whole body<br />Script door sources: None<br />Script animations: None<br />Executed scripts: None<br />Firing from vehicles: No<br />Slingload: No<br />Cargo proxy indexes: None";
		author="Fritz & Smoke";
		mapSize=4;
		class SpeechVariants
		{
			class Default
			{
				speechSingular[]=
				{
					"veh_air_UAV_s"
				};
				speechPlural[]=
				{
					"veh_air_UAV_p"
				};
			};
		};
		textSingular="$STR_A3_nameSound_veh_air_UAV_s";
		textPlural="$STR_A3_nameSound_veh_air_UAV_p";
		nameSound="veh_air_UAV_s";
		_generalMacro="frtz_drone_kvn_base_F";
		editorSubcategory="EdSubcat_Drones";
		scope=0;
		displayName="$STR_A3_CfgVehicles_UAV_01_base0";
		isUav=1;
		uavCameraDriverPos="pip_pilot_pos";
		uavCameraDriverDir="pip_pilot_dir";
		uavCameraGunnerPos="";
		uavCameraGunnerDir="";
		extCameraPosition[]={0,-0.25,-2.3499999};
		extCameraParams[]={0.93000001,10,30,0.25,1,10,30,0,1};
		formationX=10;
		formationZ=10;
		memoryPointTaskMarker="TaskMarker_1_pos";
		memoryPointDriverOptics="pip_pilot_pos";
		driverOpticsModel="\frtz_fiberoptic_kvn\empty_hud.p3d";
		GunnerOpticsModel="\frtz_fiberoptic_kvn\empty_hud.p3d";
		driverForceOptics=1;
		disableInventory=1;
		unitInfoType="RscUnitInfoParachute";
		unitInfoTypeRTD="RscUnitInfoParachute";
		driverWeaponsInfoType="RscOptics_Offroad_01";
		getInRadius=0;
		damageEffect="UAVDestructionEffects";
		damageTexDelay=0.5;
		dustEffect="UAVDust";
		waterEffect="UAVWater";
		washDownDiameter="10.0f";
		washDownStrength="0.25f";
		killFriendlyExpCoef=0.1;
		accuracy=1.5;
		camouflage=0.5;
		audible=0.1;
		armor=0.5;
		cost=20000;
		altFullForce=1400;
		altNoForce=2600;
		LODTurnedIn=-1;
		LODTurnedOut=-1;
		epeImpulseDamageCoef=5;
		fuelExplosionPower=0;
		vehicleClass="Autonomous";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		icon="\frtz_fiberoptic_kvn\data\ui\kvn_pic_ca.paa";
		picture="\frtz_fiberoptic_kvn\data\ui\kvn_map_icon_ca.paa";
		startDuration=3.8;
		maxSpeed=145;
		precision=20;
		steerAheadSimul=0.85000002;
		steerAheadPlan=0.94999999;
		predictTurnPlan=3.5;
		predictTurnSimul=1.3;
		liftForceCoef=1.65;
		cyclicAsideForceCoef=0.34999999;
		cyclicForwardForceCoef=0.60000002;
		bodyFrictionCoef=0.25;
		backRotorForceCoef=10;
		rudderInfluence=1;
		fuelCapacity=15;
		fuelUsageCoef=1;
		maxFordingDepth=0.30000001;
		threat[]={0.1,0.1,0.1};
		maxMainRotorDive=0;
		minMainRotorDive=0;
		neutralMainRotorDive=0;
		gearRetracting=0;
		mainRotorSpeed=-7;
		backRotorSpeed=7;
		tailBladeVertical=0;
		radarTargetSize=0.1;
		visualTargetSize=0.1;
		irTarget=0;
		lockDetectionSystem=0;
		incomingMissileDetectionSystem=0;
		weapons[]={};
		magazines[]={};
		irScanRangeMin=0;
		irScanRangeMax=0;
		irScanToEyeFactor=1;
		class TransportItems
		{
		};
		destrType="DestructDefault";
		driverCompartments="Compartment3";
		cargoCompartments[]=
		{
			"Compartment2"
		};
		class HitPoints: HitPoints
		{
			class HitHull: HitHull
			{
				armor=0.1;
			};
			class HitHRotor: HitHRotor
			{
				armor=999;
			};
		};
		class Damage
		{
			tex[]={};
			mat[]=
			{
				"frtz_fiberoptic_kvn\data\rvmats\body.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\body_damage.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\body_destruct.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\pg7v.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\pg7v_damage.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\pg7v_destruct.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\propellers.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\propellers_damage.rvmat",
				"frtz_fiberoptic_kvn\data\rvmats\propellers_destruct.rvmat"
			};
		};
		class ViewPilot: ViewPilot
		{
			minFov=0.25;
			maxFov=1.25;
			initFov=1;
			initAngleX=0;
			minAngleX=-65;
			maxAngleX=85;
			initAngleY=0;
			minAngleY=-150;
			maxAngleY=150;
		};
		class ViewOptics: ViewOptics
		{
			initAngleX=0;
			minAngleX=0;
			maxAngleX=0;
			initAngleY=0;
			minAngleY=0;
			maxAngleY=0;
			minFov=1.25;
			maxFov=1.25;
			initFov=1.25;
			visionMode[]=
			{
				"Normal"
			};
			thermalMode[]={0,1};
		};
		class MFD
		{
		};
		enableManualFire=1;
		reportRemoteTargets=1;
		reportOwnPosition=1;
		class Components: Components
		{
			class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft
			{
				class components
				{
				};
			};
			class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight
			{
				class components
				{
				};
			};
		};
		class Turrets
		{
		};
		attenuationEffectType="OpenHeliAttenuation";
		soundGetIn[]=
		{
			"",
			1,
			1
		};
		soundGetOut[]=
		{
			"",
			1,
			1,
			50
		};
		soundEnviron[]=
		{
			"",
			0.031622775,
			1
		};
		soundDammage[]=
		{
			"",
			0.56234133,
			1
		};
		soundEngineOnInt[]=
		{
			"frtz_fiberoptic_kvn\sounds\quad_start_full_int.wav",
			0.56234133,
			1
		};
		soundEngineOnExt[]=
		{
			"frtz_fiberoptic_kvn\sounds\quad_start_full_01.wav",
			0.56234133,
			1,
			200
		};
		soundEngineOffInt[]=
		{
			"frtz_fiberoptic_kvn\sounds\quad_stop_full_int.wav",
			0.56234133,
			1
		};
		soundEngineOffExt[]=
		{
			"frtz_fiberoptic_kvn\sounds\quad_stop_full_01.wav",
			0.56234133,
			1,
			200
		};
		soundBushCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",
			1,
			1,
			100
		};
		soundBushCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",
			1,
			1,
			100
		};
		soundBushCollision3[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",
			1,
			1,
			100
		};
		soundBushCrash[]=
		{
			"soundBushCollision1",
			0.33000001,
			"soundBushCollision2",
			0.33000001,
			"soundBushCollision3",
			0.33000001
		};
		soundWaterCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",
			1,
			1,
			100
		};
		soundWaterCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",
			1,
			1,
			100
		};
		soundWaterCrashes[]=
		{
			"soundWaterCollision1",
			0.5,
			"soundWaterCollision2",
			0.5
		};
		Crash0[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1",
			1,
			1,
			900
		};
		Crash1[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2",
			1,
			1,
			900
		};
		Crash2[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3",
			1,
			1,
			900
		};
		Crash3[]=
		{
			"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4",
			1,
			1,
			900
		};
		soundCrashes[]=
		{
			"Crash0",
			0.25,
			"Crash1",
			0.25,
			"Crash2",
			0.25,
			"Crash3",
			0.25
		};
		class Sounds
		{
			class Engine
			{
				sound[]=
				{
					"frtz_fiberoptic_kvn\sounds\quad_engine_full_01.wav",
					0.44668359,
					1,
					200
				};
				frequency="rotorSpeed";
				volume="camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorLowOut
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade",
					0.31622776,
					1,
					200
				};
				frequency="rotorSpeed";
				volume="camPos*(0 max (rotorSpeed-0.1))";
				cone[]={1.6,3.1400001,1.6,0.94999999};
			};
			class RotorHighOut
			{
				sound[]=
				{
					"A3\Sounds_F\air\Uav_01\blade_high",
					0.31622776,
					1,
					250
				};
				frequency="rotorSpeed";
				volume="camPos*10*(0 max (rotorThrust-0.9))";
				cone[]={1.6,3.1400001,1.6,0.94999999};
			};
			class EngineIn
			{
				sound[]=
				{
					"frtz_fiberoptic_kvn\sounds\quad_engine_full_int.wav",
					0.56234133,
					1
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*((rotorSpeed-0.75)*4)";
			};
			class RotorLowIn
			{
				sound[]=
				{
					"",
					0.56234133,
					1
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*(0 max (rotorSpeed-0.1))";
			};
			class RotorHighIn
			{
				sound[]=
				{
					"",
					0.56234133,
					1
				};
				frequency="rotorSpeed";
				volume="(1-camPos)*3*(rotorThrust-0.9)";
			};
		};
		class Exhausts
		{
		};
		class Library
		{
			libTextDesc="$STR_A3_CfgVehicles_UAV_01_base_Library0";
		};
		class UserActions
		{
			class DisassembleUAV
			{
				displayName="Put in inventory";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition="[this] call DB_kvn_fnc_fpv_canDisassembly";
				statement="[this, player] call DB_kvn_fnc_fpv_addUavToInventory";
			};
		};
	};
	class frtz_KVN_Base: frtz_drone_kvn_base_F
	{
		scope=0;
		class SimpleObject
		{
			eden=1;
			animate[]=
			{
				
				{
					"damagehide",
					0
				},
				
				{
					"rotorimpacthide",
					0
				},
				
				{
					"tailrotorimpacthide",
					0
				},
				
				{
					"propeller1_rotation",
					0
				},
				
				{
					"propeller1_blur_rotation",
					0
				},
				
				{
					"propeller2_rotation",
					0
				},
				
				{
					"propeller2_blur_rotation",
					0
				},
				
				{
					"propeller3_rotation",
					0
				},
				
				{
					"propeller3_blur_rotation",
					0
				},
				
				{
					"propeller4_rotation",
					0
				},
				
				{
					"propeller4_blur_rotation",
					0
				},
				
				{
					"propeller1_hide",
					0
				},
				
				{
					"propeller1_blur_hide",
					0
				},
				
				{
					"propeller2_hide",
					0
				},
				
				{
					"propeller2_blur_hide",
					0
				},
				
				{
					"propeller3_hide",
					0
				},
				
				{
					"propeller3_blur_hide",
					0
				},
				
				{
					"propeller4_hide",
					0
				},
				
				{
					"propeller4_blur_hide",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					-0.050000001
				}
			};
			hide[]=
			{
				"zasleh",
				"tail rotor blur",
				"main rotor blur",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=0.15000001;
			verticalOffsetWorld=-0.001;
			init="''";
		};
		textureList[]=
		{
			"Indep",
			1
		};
		class EventHandlers
		{
			class kvn
			{
				hit="_this call DB_kvn_fnc_fpv_onDestroy";
				init="(_this # 0) spawn DB_kvn_fnc_fpv_droneInit;";
			};
		};
	};
	class B_UAV_01_backpack_F;
	class O_UAV_01_backpack_F;
	class I_UAV_01_backpack_F;
	class frtz_O_KVN_AT: frtz_KVN_Base
	{
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="KVN AT (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AT_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AP: frtz_O_KVN_AT
	{
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="KVN AP (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AP_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AT_TI: frtz_O_KVN_AT
	{
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="KVN AT TI (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AT_TI_Bag"
			};
			displayName="";
		};
		class ViewOptics: ViewOptics
		{
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1};
		};
	};
	class frtz_O_KVN_AP_TI: frtz_O_KVN_AP
	{
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="KVN AP TI (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AP_TI_Bag"
			};
			displayName="";
		};
		class ViewOptics: ViewOptics
		{
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1};
		};
	};
	class frtz_B_KVN_AT: frtz_KVN_Base
	{
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		displayName="KVN AT (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AT_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AP: frtz_B_KVN_AT
	{
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		displayName="KVN AP (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AP_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AT_TI: frtz_B_KVN_AT
	{
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		displayName="KVN AT TI (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AT_TI_Bag"
			};
			displayName="";
		};
		class ViewOptics: ViewOptics
		{
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1};
		};
	};
	class frtz_B_KVN_AP_TI: frtz_B_KVN_AP
	{
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		displayName="KVN AP TI (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AP_TI_Bag"
			};
			displayName="";
		};
		class ViewOptics: ViewOptics
		{
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1};
		};
	};
	class frtz_I_KVN_AT: frtz_KVN_Base
	{
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		displayName="KVN AT (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AT_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AP: frtz_I_KVN_AT
	{
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		displayName="KVN AP (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AP_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AT_TI: frtz_I_KVN_AT
	{
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		displayName="KVN AT TI (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AT_TI_Bag"
			};
			displayName="";
		};
		class ViewOptics: ViewOptics
		{
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1};
		};
	};
	class frtz_I_KVN_AP_TI: frtz_I_KVN_AP
	{
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		displayName="KVN AP TI (15km)";
		editorPreview="\frtz_fiberoptic_kvn\data\ui\FPV_KVN_preview.jpg";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		author="Fritz & Smoke";
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AP_TI_Bag"
			};
			displayName="";
		};
		class ViewOptics: ViewOptics
		{
			visionMode[]=
			{
				"Normal",
				"Ti"
			};
			thermalMode[]={0,1};
		};
	};
	class frtz_O_KVN_AT_20KM: frtz_O_KVN_AT
	{
		displayName="KVN AT (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AT_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AP_20KM: frtz_O_KVN_AP
	{
		displayName="KVN AP (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AP_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AT_TI_20KM: frtz_O_KVN_AT_TI
	{
		displayName="KVN AT TI (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AT_TI_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AP_TI_20KM: frtz_O_KVN_AP_TI
	{
		displayName="KVN AP TI (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AP_TI_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AT_25KM: frtz_O_KVN_AT
	{
		displayName="KVN AT (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AT_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AP_25KM: frtz_O_KVN_AP
	{
		displayName="KVN AP (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AP_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AT_TI_25KM: frtz_O_KVN_AT_TI
	{
		displayName="KVN AT TI (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AT_TI_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AP_TI_25KM: frtz_O_KVN_AP_TI
	{
		displayName="KVN AP TI (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_O_KVN_AP_TI_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AT_20KM: frtz_B_KVN_AT
	{
		displayName="KVN AT (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AT_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AP_20KM: frtz_B_KVN_AP
	{
		displayName="KVN AP (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AP_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AT_TI_20KM: frtz_B_KVN_AT_TI
	{
		displayName="KVN AT TI (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AT_TI_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AP_TI_20KM: frtz_B_KVN_AP_TI
	{
		displayName="KVN AP TI (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AP_TI_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AT_25KM: frtz_B_KVN_AT
	{
		displayName="KVN AT (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AT_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AP_25KM: frtz_B_KVN_AP
	{
		displayName="KVN AP (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AP_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AT_TI_25KM: frtz_B_KVN_AT_TI
	{
		displayName="KVN AT TI (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AT_TI_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_B_KVN_AP_TI_25KM: frtz_B_KVN_AP_TI
	{
		displayName="KVN AP TI (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_B_KVN_AP_TI_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AT_20KM: frtz_I_KVN_AT
	{
		displayName="KVN AT (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AT_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AP_20KM: frtz_I_KVN_AP
	{
		displayName="KVN AP (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AP_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AT_TI_20KM: frtz_I_KVN_AT_TI
	{
		displayName="KVN AT TI (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AT_TI_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AP_TI_20KM: frtz_I_KVN_AP_TI
	{
		displayName="KVN AP TI (20km)";
		fuelCapacity=20;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AP_TI_20KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AT_25KM: frtz_I_KVN_AT
	{
		displayName="KVN AT (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AT_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AP_25KM: frtz_I_KVN_AP
	{
		displayName="KVN AP (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AP_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AT_TI_25KM: frtz_I_KVN_AT_TI
	{
		displayName="KVN AT TI (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AT_TI_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_I_KVN_AP_TI_25KM: frtz_I_KVN_AP_TI
	{
		displayName="KVN AP TI (25km)";
		fuelCapacity=25;
		class assembleInfo
		{
			primary=0;
			base="";
			assembleTo="";
			dissasembleTo[]=
			{
				"frtz_I_KVN_AP_TI_25KM_Bag"
			};
			displayName="";
		};
	};
	class frtz_O_KVN_AT_Bag: O_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AT (15km) Bag OPFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AT";
			base="";
			displayName="KVN AT (15km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AP_Bag: O_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AP (15km) Bag OPFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AP";
			base="";
			displayName="KVN AP (15km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AT_TI_Bag: O_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AT TI (15km) Bag OPFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AT_TI";
			base="";
			displayName="KVN AT TI (15km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AP_TI_Bag: O_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AP TI (15km) Bag OPFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AP_TI";
			base="";
			displayName="KVN AP TI (15km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AT_Bag: B_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AT (15km) Bag BLUFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AT";
			base="";
			displayName="KVN AT (15km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AP_Bag: B_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AP (15km) Bag BLUFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AP";
			base="";
			displayName="KVN AP (15km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AT_TI_Bag: B_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AT TI (15km) Bag BLUFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AT_TI";
			base="";
			displayName="KVN AT TI (15km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AP_TI_Bag: B_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AP TI (15km) Bag BLUFOR";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AP_TI";
			base="";
			displayName="KVN AP TI (15km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AT_Bag: I_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AT (15km) Bag IND";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AT";
			base="";
			displayName="KVN AT (15km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AP_Bag: I_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AP (15km) Bag IND";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AP";
			base="";
			displayName="KVN AP (15km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AT_TI_Bag: I_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AT TI (15km) Bag IND";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AT_TI";
			base="";
			displayName="KVN AT TI (15km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AP_TI_Bag: I_UAV_01_backpack_F
	{
		scope=2;
		scopeCurator=2;
		displayName="KVN AP TI (15km) Bag IND";
		author="Fritz & Smoke";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AP_TI";
			base="";
			displayName="KVN AP TI (15km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AT_20KM_Bag: frtz_O_KVN_AT_Bag
	{
		displayName="KVN AT (20km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AT_20KM";
			base="";
			displayName="KVN AT (20km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AP_20KM_Bag: frtz_O_KVN_AP_Bag
	{
		displayName="KVN AP (20km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AP_20KM";
			base="";
			displayName="KVN AP (20km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AT_TI_20KM_Bag: frtz_O_KVN_AT_TI_Bag
	{
		displayName="KVN AT TI (20km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AT_TI_20KM";
			base="";
			displayName="KVN AT TI (20km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AP_TI_20KM_Bag: frtz_O_KVN_AP_TI_Bag
	{
		displayName="KVN AP TI (20km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AP_TI_20KM";
			base="";
			displayName="KVN AP TI (20km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AT_25KM_Bag: frtz_O_KVN_AT_Bag
	{
		displayName="KVN AT (25km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AT_25KM";
			base="";
			displayName="KVN AT (25km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AP_25KM_Bag: frtz_O_KVN_AP_Bag
	{
		displayName="KVN AP (25km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AP_25KM";
			base="";
			displayName="KVN AP (25km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AT_TI_25KM_Bag: frtz_O_KVN_AT_TI_Bag
	{
		displayName="KVN AT TI (25km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AT_TI_25KM";
			base="";
			displayName="KVN AT TI (25km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_O_KVN_AP_TI_25KM_Bag: frtz_O_KVN_AP_TI_Bag
	{
		displayName="KVN AP TI (25km) Bag OPFOR";
		class assembleInfo
		{
			assembleTo="frtz_O_KVN_AP_TI_25KM";
			base="";
			displayName="KVN AP TI (25km) Bag OPFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AT_20KM_Bag: frtz_B_KVN_AT_Bag
	{
		displayName="KVN AT (20km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AT_20KM";
			base="";
			displayName="KVN AT (20km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AP_20KM_Bag: frtz_B_KVN_AP_Bag
	{
		displayName="KVN AP (20km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AP_20KM";
			base="";
			displayName="KVN AP (20km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AT_TI_20KM_Bag: frtz_B_KVN_AT_TI_Bag
	{
		displayName="KVN AT TI (20km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AT_TI_20KM";
			base="";
			displayName="KVN AT TI (20km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AP_TI_20KM_Bag: frtz_B_KVN_AP_TI_Bag
	{
		displayName="KVN AP TI (20km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AP_TI_20KM";
			base="";
			displayName="KVN AP TI (20km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AT_25KM_Bag: frtz_B_KVN_AT_Bag
	{
		displayName="KVN AT (25km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AT_25KM";
			base="";
			displayName="KVN AT (25km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AP_25KM_Bag: frtz_B_KVN_AP_Bag
	{
		displayName="KVN AP (25km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AP_25KM";
			base="";
			displayName="KVN AP (25km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AT_TI_25KM_Bag: frtz_B_KVN_AT_TI_Bag
	{
		displayName="KVN AT TI (25km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AT_TI_25KM";
			base="";
			displayName="KVN AT TI (25km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_B_KVN_AP_TI_25KM_Bag: frtz_B_KVN_AP_TI_Bag
	{
		displayName="KVN AP TI (25km) Bag BLUFOR";
		class assembleInfo
		{
			assembleTo="frtz_B_KVN_AP_TI_25KM";
			base="";
			displayName="KVN AP TI (25km) Bag BLUFOR";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AT_20KM_Bag: frtz_I_KVN_AT_Bag
	{
		displayName="KVN AT (20km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AT_20KM";
			base="";
			displayName="KVN AT (20km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AP_20KM_Bag: frtz_I_KVN_AP_Bag
	{
		displayName="KVN AP (20km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AP_20KM";
			base="";
			displayName="KVN AP (20km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AT_TI_20KM_Bag: frtz_I_KVN_AT_TI_Bag
	{
		displayName="KVN AT TI (20km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AT_TI_20KM";
			base="";
			displayName="KVN AT TI (20km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AP_TI_20KM_Bag: frtz_I_KVN_AP_TI_Bag
	{
		displayName="KVN AP TI (20km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AP_TI_20KM";
			base="";
			displayName="KVN AP TI (20km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AT_25KM_Bag: frtz_I_KVN_AT_Bag
	{
		displayName="KVN AT (25km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AT_25KM";
			base="";
			displayName="KVN AT (25km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AP_25KM_Bag: frtz_I_KVN_AP_Bag
	{
		displayName="KVN AP (25km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AP_25KM";
			base="";
			displayName="KVN AP (25km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AT_TI_25KM_Bag: frtz_I_KVN_AT_TI_Bag
	{
		displayName="KVN AT TI (25km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AT_TI_25KM";
			base="";
			displayName="KVN AT TI (25km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
	class frtz_I_KVN_AP_TI_25KM_Bag: frtz_I_KVN_AP_TI_Bag
	{
		displayName="KVN AP TI (25km) Bag IND";
		class assembleInfo
		{
			assembleTo="frtz_I_KVN_AP_TI_25KM";
			base="";
			displayName="KVN AP TI (25km) Bag IND";
			dissasembleTo[]={};
			primary=1;
		};
	};
};
class CfgMagazines
{
	class Laserbatteries;
	class frtz_Item_KVN_AT: Laserbatteries
	{
		_generalMacro="frtz_Item_KVN_AT";
		scope=2;
		author="Fritz & Smoke";
		descriptionShort="KVN FPV Drone AT (Anti-Tank, 15km fiber)";
		displayName="KVN AT Drone (15km)";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		icon="\frtz_fiberoptic_kvn\data\ui\kvn_pic_ca.paa";
		picture="\frtz_fiberoptic_kvn\data\ui\kvn_map_icon_ca.paa";
		mass=150;
		count=1;
		ammo="";
	};
	class frtz_Item_KVN_AT_20KM: frtz_Item_KVN_AT
	{
		_generalMacro="frtz_Item_KVN_AT_20KM";
		descriptionShort="KVN FPV Drone AT (Anti-Tank, 20km fiber)";
		displayName="KVN AT Drone (20km)";
	};
	class frtz_Item_KVN_AT_25KM: frtz_Item_KVN_AT
	{
		_generalMacro="frtz_Item_KVN_AT_25KM";
		descriptionShort="KVN FPV Drone AT (Anti-Tank, 25km fiber)";
		displayName="KVN AT Drone (25km)";
	};
	class frtz_Item_KVN_AP: Laserbatteries
	{
		_generalMacro="frtz_Item_KVN_AP";
		scope=2;
		author="Fritz & Smoke";
		descriptionShort="KVN FPV Drone AP (Anti-Personnel, 15km fiber)";
		displayName="KVN AP Drone (15km)";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		icon="\frtz_fiberoptic_kvn\data\ui\kvn_pic_ca.paa";
		picture="\frtz_fiberoptic_kvn\data\ui\kvn_map_icon_ca.paa";
		mass=150;
		count=1;
		ammo="";
	};
	class frtz_Item_KVN_AP_20KM: frtz_Item_KVN_AP
	{
		_generalMacro="frtz_Item_KVN_AP_20KM";
		descriptionShort="KVN FPV Drone AP (Anti-Personnel, 20km fiber)";
		displayName="KVN AP Drone (20km)";
	};
	class frtz_Item_KVN_AP_25KM: frtz_Item_KVN_AP
	{
		_generalMacro="frtz_Item_KVN_AP_25KM";
		descriptionShort="KVN FPV Drone AP (Anti-Personnel, 25km fiber)";
		displayName="KVN AP Drone (25km)";
	};
	class frtz_Item_KVN_AT_TI: Laserbatteries
	{
		_generalMacro="frtz_Item_KVN_AT_TI";
		scope=2;
		author="Fritz & Smoke";
		descriptionShort="KVN FPV Drone AT TI (Anti-Tank, Thermal, 15km fiber)";
		displayName="KVN AT TI Drone (15km)";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		icon="\frtz_fiberoptic_kvn\data\ui\kvn_pic_ca.paa";
		picture="\frtz_fiberoptic_kvn\data\ui\kvn_map_icon_ca.paa";
		mass=150;
		count=1;
		ammo="";
	};
	class frtz_Item_KVN_AT_TI_20KM: frtz_Item_KVN_AT_TI
	{
		_generalMacro="frtz_Item_KVN_AT_TI_20KM";
		descriptionShort="KVN FPV Drone AT TI (Anti-Tank, Thermal, 20km fiber)";
		displayName="KVN AT TI Drone (20km)";
	};
	class frtz_Item_KVN_AT_TI_25KM: frtz_Item_KVN_AT_TI
	{
		_generalMacro="frtz_Item_KVN_AT_TI_25KM";
		descriptionShort="KVN FPV Drone AT TI (Anti-Tank, Thermal, 25km fiber)";
		displayName="KVN AT TI Drone (25km)";
	};
	class frtz_Item_KVN_AP_TI: Laserbatteries
	{
		_generalMacro="frtz_Item_KVN_AP_TI";
		scope=2;
		author="Fritz & Smoke";
		descriptionShort="KVN FPV Drone AP TI (Anti-Personnel, Thermal, 15km fiber)";
		displayName="KVN AP TI Drone (15km)";
		model="\frtz_fiberoptic_kvn\kvn_fiber_optic.p3d";
		icon="\frtz_fiberoptic_kvn\data\ui\kvn_pic_ca.paa";
		picture="\frtz_fiberoptic_kvn\data\ui\kvn_map_icon_ca.paa";
		mass=150;
		count=1;
		ammo="";
	};
	class frtz_Item_KVN_AP_TI_20KM: frtz_Item_KVN_AP_TI
	{
		_generalMacro="frtz_Item_KVN_AP_TI_20KM";
		descriptionShort="KVN FPV Drone AP TI (Anti-Personnel, Thermal, 20km fiber)";
		displayName="KVN AP TI Drone (20km)";
	};
	class frtz_Item_KVN_AP_TI_25KM: frtz_Item_KVN_AP_TI
	{
		_generalMacro="frtz_Item_KVN_AP_TI_25KM";
		descriptionShort="KVN FPV Drone AP TI (Anti-Personnel, Thermal, 25km fiber)";
		displayName="KVN AP TI Drone (25km)";
	};
};
class Extended_PreInit_EventHandlers
{
	class kvn_preInit
	{
		init="call compile preProcessFileLineNumbers '\frtz_fiberoptic_kvn\XEH_preInit.sqf'";
	};
};
class Extended_PostInit_EventHandlers
{
	class kvn_postInit
	{
		init="call compile preProcessFileLineNumbers '\frtz_fiberoptic_kvn\XEH_postInit.sqf'";
	};
};
