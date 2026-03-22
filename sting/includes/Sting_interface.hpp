class RscText;
class ctrlStaticPicture;

#define GRID_W(NUM) ( NUM * ( pixelGridNoUIScale * pixelW * 2 ) )
#define GRID_H(NUM) ( NUM * ( pixelGridNoUIScale * pixelH * 2 ) )

#define STING_X(NUM) (safeZoneXAbs + safeZoneWAbs * (NUM))
#define STING_Y(NUM) (safeZoneY + safeZoneH * (NUM))
#define STING_STYLE_LEFT 0
#define STING_STYLE_RIGHT 1
#define STING_STYLE_CENTER 2
#define STING_STYLE_PICTURE 2096
#define STING_RETICLE_SIZE_W GRID_W(2.12)
#define STING_RETICLE_SIZE_H GRID_H(2.12)

class StingHudIcon: ctrlStaticPicture
{
	idc = -1;
	style = STING_STYLE_PICTURE;
	shadow = 1;
	shadowColor[] = {0, 0, 0, 0.9};
	colorText[] = {1, 1, 1, 1};
	text = "";
};

class StingHudTextLeft: RscText
{
	idc = -1;
	shadow = 2;
	shadowColor[] = {0, 0, 0, 1};
	colorShadow[] = {0, 0, 0, 1};
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = "EurostileBoldItalic";
	style = STING_STYLE_LEFT;
	sizeEx = GRID_H(0.92);
	text = "";
};

class StingHudTextCenter: StingHudTextLeft
{
	style = STING_STYLE_CENTER;
};

class StingHudTextRight: StingHudTextLeft
{
	style = STING_STYLE_RIGHT;
};

class RscTitles
{
	class Sting_Dialog
	{
		idd = -1;
		duration = 1e+038;
		movingEnable = false;
		enableSimulation = true;
		onLoad = "uiNamespace setVariable ['Sting_Display', _this # 0];";
		onUnload = "uiNamespace setVariable ['Sting_Display', displayNull];";

		class controls
		{
			class CenterReticle: StingHudIcon
			{
				text = "\sting\pictures\hud\reticle_ring.paa";
				x = 0.5 - STING_RETICLE_SIZE_W / 2;
				y = 0.5 - STING_RETICLE_SIZE_H / 2;
				w = STING_RETICLE_SIZE_W;
				h = STING_RETICLE_SIZE_H;
			};

			class RecordDot: StingHudIcon
			{
				text = "\sting\pictures\hud\record_dot.paa";
				x = STING_X(0.835);
				y = STING_Y(0.294);
				w = GRID_W(0.66);
				h = GRID_H(0.66);
			};

			class RecordTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.92);
				text = "00:00";
				onLoad = "uiNamespace setVariable ['Sting_RecordTimeText', _this # 0];";

				x = STING_X(0.850);
				y = STING_Y(0.292);
				w = GRID_W(4.8);
				h = GRID_H(0.95);
			};

			class ModeBadge: StingHudIcon
			{
				text = "\sting\pictures\hud\mode_s.paa";
				x = STING_X(0.025);
				y = STING_Y(0.857);
				w = GRID_W(2.66);
				h = GRID_H(2.66);
			};

			class ModeText: StingHudTextCenter
			{
				shadow = 0;
				colorText[] = {0, 0, 0, 1};
				sizeEx = GRID_H(1.22);
				text = "S";
				onLoad = "uiNamespace setVariable ['Sting_ModeText', _this # 0];";

				x = STING_X(0.0264);
				y = STING_Y(0.879);
				w = GRID_W(2.30);
				h = GRID_H(1.20);
			};

			class VerticalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.62);
				text = "0.0m/s";
				onLoad = "uiNamespace setVariable ['Sting_VerticalSpeedText', _this # 0];";

				x = STING_X(0.082);
				y = STING_Y(0.866);
				w = GRID_W(4.1);
				h = GRID_H(0.62);
			};

			class HorizontalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.62);
				text = "12.7m/s";
				onLoad = "uiNamespace setVariable ['Sting_HorizontalSpeedText', _this # 0];";

				x = STING_X(0.160);
				y = STING_Y(0.866);
				w = GRID_W(4.3);
				h = GRID_H(0.62);
			};

			class HomeAltText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.92);
				text = "H 0.0m";
				onLoad = "uiNamespace setVariable ['Sting_HomeAltText', _this # 0];";

				x = STING_X(0.077);
				y = STING_Y(0.889);
				w = GRID_W(4.9);
				h = GRID_H(0.86);
			};

			class DistanceText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.92);
				text = "D 0m";
				onLoad = "uiNamespace setVariable ['Sting_DistanceText', _this # 0];";

				x = STING_X(0.156);
				y = STING_Y(0.889);
				w = GRID_W(4.6);
				h = GRID_H(0.86);
			};

			class DownAltitudeIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\down_arrow.paa";
				colorText[] = {1, 1, 1, 1};
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeIcon', _this # 0];";

				x = STING_X(0.400);
				y = STING_Y(0.871);
				w = GRID_W(1.04);
				h = GRID_H(1.70);
			};

			class DownAltitudeText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.94);
				text = "4.1m";
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeText', _this # 0];";

				x = STING_X(0.417);
				y = STING_Y(0.889);
				w = GRID_W(3.4);
				h = GRID_H(0.86);
			};

			class BatteryPicture: StingHudIcon
			{
				text = "\sting\pictures\hud\battery_frame.paa";
				onLoad = "uiNamespace setVariable ['Sting_BatteryPicture', _this # 0];";

				x = STING_X(0.593);
				y = STING_Y(0.865);
				w = GRID_W(3.34);
				h = GRID_H(1.46);
			};

			class BatteryValueText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.60);
				text = "88";
				onLoad = "uiNamespace setVariable ['Sting_BatteryValueText', _this # 0];";

				x = STING_X(0.6);
				y = STING_Y(0.88);
				w = GRID_W(2.26);
				h = GRID_H(0.52);
			};

			class RemainingTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.96);
				text = "17'32""";
				onLoad = "uiNamespace setVariable ['Sting_RemainingTimeText', _this # 0];";

				x = STING_X(0.632);
				y = STING_Y(0.889);
				w = GRID_W(4.5);
				h = GRID_H(0.86);
			};

			class LinkLabelRc: StingHudTextRight
			{
				sizeEx = GRID_H(0.42);
				text = "RC";

				x = STING_X(0.724);
				y = STING_Y(0.882);
				w = GRID_W(1.18);
				h = GRID_H(0.36);
			};

			class LinkLabelHd: StingHudTextRight
			{
				sizeEx = GRID_H(0.42);
				text = "HD";

				x = STING_X(0.724);
				y = STING_Y(0.893);
				w = GRID_W(1.18);
				h = GRID_H(0.36);
			};

			class LinkBarsIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\link_dual_bars.paa";
				x = STING_X(0.737);
				y = STING_Y(0.878);
				w = GRID_W(1.82);
				h = GRID_H(1.22);
			};

			class BitrateValueText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.86);
				text = "50";

				x = STING_X(0.770);
				y = STING_Y(0.877);
				w = GRID_W(1.8);
				h = GRID_H(0.80);
			};

			class BitrateLabelText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.44);
				text = "Mbps";

				x = STING_X(0.770);
				y = STING_Y(0.900);
				w = GRID_W(2.2);
				h = GRID_H(0.36);
			};

			class LatencyIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\latency_icon.paa";
				x = STING_X(0.838);
				y = STING_Y(0.874);
				w = GRID_W(1.18);
				h = GRID_H(1.18);
			};

			class LatencyText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.84);
				text = "27";

				x = STING_X(0.851);
				y = STING_Y(0.888);
				w = GRID_W(1.5);
				h = GRID_H(0.82);
			};

			class LinkPercentIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\goggles_icon.paa";
				x = STING_X(0.899);
				y = STING_Y(0.874);
				w = GRID_W(1.48);
				h = GRID_H(1.02);
			};

			class LinkPercentText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.84);
				text = "67%";

				x = STING_X(0.926);
				y = STING_Y(0.888);
				w = GRID_W(2.0);
				h = GRID_H(0.82);
			};
		};
	};
};
