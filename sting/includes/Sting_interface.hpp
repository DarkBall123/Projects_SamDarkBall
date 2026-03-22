class RscText;
class RscProgress;
class ctrlStaticPicture;

#define GRID_W(NUM) ( NUM * ( pixelGridNoUIScale * pixelW * 2 ) )
#define GRID_H(NUM) ( NUM * ( pixelGridNoUIScale * pixelH * 2 ) )

#define STING_X(NUM) (safeZoneXAbs + safeZoneWAbs * (NUM))
#define STING_Y(NUM) (safeZoneY + safeZoneH * (NUM))
#define STING_STYLE_LEFT 0
#define STING_STYLE_RIGHT 1
#define STING_STYLE_CENTER 2
#define STING_STYLE_PICTURE 2096
#define STING_RETICLE_SIZE_W GRID_W(2.45)
#define STING_RETICLE_SIZE_H GRID_H(2.45)

class StingHudIcon: ctrlStaticPicture
{
	idc = -1;
	style = STING_STYLE_PICTURE;
	shadow = 2;
	shadowColor[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	text = "";
};

class StingHudSolid: RscText
{
	idc = -1;
	shadow = 0;
	text = "";
	colorText[] = {1, 1, 1, 0};
	colorBackground[] = {0, 0, 0, 0};
};

class StingHudProgress: RscProgress
{
	idc = -1;
	type = 8;
	style = 0;
	shadow = 0;
	colorFrame[] = {0, 0, 0, 0};
	colorBar[] = {0.55, 0.55, 0.55, 0.9};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
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
				x = STING_X(0.837);
				y = STING_Y(0.294);
				w = GRID_W(0.78);
				h = GRID_H(0.78);
			};

			class RecordTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.92);
				text = "00:00";
				onLoad = "uiNamespace setVariable ['Sting_RecordTimeText', _this # 0];";

				x = STING_X(0.852);
				y = STING_Y(0.291);
				w = GRID_W(4.8);
				h = GRID_H(0.95);
			};

			class ModeBadge: StingHudIcon
			{
				text = "\sting\pictures\hud\mode_s.paa";
				x = STING_X(0.024);
				y = STING_Y(0.899);
				w = GRID_W(3.25);
				h = GRID_H(3.25);
			};

			class ModeText: StingHudTextCenter
			{
				shadow = 0;
				colorText[] = {0, 0, 0, 1};
				sizeEx = GRID_H(1.52);
				text = "S";
				onLoad = "uiNamespace setVariable ['Sting_ModeText', _this # 0];";

				x = STING_X(0.024);
				y = STING_Y(0.905);
				w = GRID_W(3.25);
				h = GRID_H(1.55);
			};

			class VerticalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.72);
				text = "0.0m/s";
				onLoad = "uiNamespace setVariable ['Sting_VerticalSpeedText', _this # 0];";

				x = STING_X(0.086);
				y = STING_Y(0.904);
				w = GRID_W(4.3);
				h = GRID_H(0.74);
			};

			class HorizontalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.72);
				text = "12.7m/s";
				onLoad = "uiNamespace setVariable ['Sting_HorizontalSpeedText', _this # 0];";

				x = STING_X(0.169);
				y = STING_Y(0.904);
				w = GRID_W(4.6);
				h = GRID_H(0.74);
			};

			class HomeAltText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.98);
				text = "H 0.0m";
				onLoad = "uiNamespace setVariable ['Sting_HomeAltText', _this # 0];";

				x = STING_X(0.078);
				y = STING_Y(0.928);
				w = GRID_W(5.4);
				h = GRID_H(0.92);
			};

			class DistanceText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.98);
				text = "D 0m";
				onLoad = "uiNamespace setVariable ['Sting_DistanceText', _this # 0];";

				x = STING_X(0.165);
				y = STING_Y(0.928);
				w = GRID_W(4.9);
				h = GRID_H(0.92);
			};

			class DownAltitudeIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\down_arrow.paa";
				colorText[] = {1, 1, 1, 1};
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeIcon', _this # 0];";

				x = STING_X(0.360);
				y = STING_Y(0.913);
				w = GRID_W(1.18);
				h = GRID_H(1.92);
			};

			class DownAltitudeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.00);
				text = "4.1m";
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeText', _this # 0];";

				x = STING_X(0.378);
				y = STING_Y(0.929);
				w = GRID_W(3.9);
				h = GRID_H(0.92);
			};

			class BatteryBarBackground: StingHudSolid
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarBackground', _this # 0];";
				colorBackground[] = {0.22, 0.22, 0.22, 0.65};

				x = STING_X(0.624);
				y = STING_Y(0.914);
				w = GRID_W(2.55);
				h = GRID_H(0.66);
			};

			class BatteryBarFill: StingHudProgress
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarFill', _this # 0];";

				x = STING_X(0.624);
				y = STING_Y(0.914);
				w = GRID_W(2.55);
				h = GRID_H(0.66);
			};

			class BatteryPicture: StingHudIcon
			{
				text = "\sting\pictures\hud\battery_frame.paa";
				onLoad = "uiNamespace setVariable ['Sting_BatteryPicture', _this # 0];";

				x = STING_X(0.620);
				y = STING_Y(0.910);
				w = GRID_W(3.72);
				h = GRID_H(1.60);
			};

			class BatteryValueText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.66);
				text = "88";
				onLoad = "uiNamespace setVariable ['Sting_BatteryValueText', _this # 0];";

				x = STING_X(0.622);
				y = STING_Y(0.916);
				w = GRID_W(2.80);
				h = GRID_H(0.58);
			};

			class RemainingTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.04);
				text = "17'32""";
				onLoad = "uiNamespace setVariable ['Sting_RemainingTimeText', _this # 0];";

				x = STING_X(0.657);
				y = STING_Y(0.928);
				w = GRID_W(4.9);
				h = GRID_H(0.92);
			};

			class LinkLabelRc: StingHudTextRight
			{
				sizeEx = GRID_H(0.42);
				text = "RC";

				x = STING_X(0.746);
				y = STING_Y(0.919);
				w = GRID_W(1.35);
				h = GRID_H(0.36);
			};

			class LinkLabelHd: StingHudTextRight
			{
				sizeEx = GRID_H(0.42);
				text = "HD";

				x = STING_X(0.746);
				y = STING_Y(0.929);
				w = GRID_W(1.35);
				h = GRID_H(0.36);
			};

			class LinkBarsIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\link_dual_bars.paa";
				x = STING_X(0.762);
				y = STING_Y(0.912);
				w = GRID_W(2.12);
				h = GRID_H(1.46);
			};

			class BitrateValueText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.90);
				text = "50";

				x = STING_X(0.790);
				y = STING_Y(0.928);
				w = GRID_W(1.9);
				h = GRID_H(0.82);
			};

			class BitrateLabelText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.44);
				text = "Mbps";

				x = STING_X(0.790);
				y = STING_Y(0.938);
				w = GRID_W(2.2);
				h = GRID_H(0.36);
			};

			class LatencyIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\latency_icon.paa";
				x = STING_X(0.855);
				y = STING_Y(0.913);
				w = GRID_W(1.35);
				h = GRID_H(1.28);
			};

			class LatencyText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.88);
				text = "27";

				x = STING_X(0.869);
				y = STING_Y(0.928);
				w = GRID_W(1.5);
				h = GRID_H(0.82);
			};

			class LinkPercentIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\goggles_icon.paa";
				x = STING_X(0.920);
				y = STING_Y(0.914);
				w = GRID_W(1.72);
				h = GRID_H(1.18);
			};

			class LinkPercentText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.88);
				text = "67%";

				x = STING_X(0.935);
				y = STING_Y(0.928);
				w = GRID_W(2.0);
				h = GRID_H(0.82);
			};
		};
	};
};
