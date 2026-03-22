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

class StingHudIcon: ctrlStaticPicture
{
	idc = -1;
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
				x = STING_X(0.515);
				y = STING_Y(0.521);
				w = GRID_W(3.4);
				h = GRID_H(3.4);
			};

			class RecordDot: StingHudIcon
			{
				text = "\sting\pictures\hud\record_dot.paa";
				x = STING_X(0.829);
				y = STING_Y(0.289);
				w = GRID_W(1.0);
				h = GRID_H(1.0);
			};

			class RecordTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.15);
				text = "00:00";
				onLoad = "uiNamespace setVariable ['Sting_RecordTimeText', _this # 0];";

				x = STING_X(0.846);
				y = STING_Y(0.286);
				w = GRID_W(7.0);
				h = GRID_H(1.3);
			};

			class ModeBadge: StingHudIcon
			{
				text = "\sting\pictures\hud\mode_s.paa";
				x = STING_X(0.019);
				y = STING_Y(0.906);
				w = GRID_W(5.2);
				h = GRID_H(5.2);
			};

			class ModeText: StingHudTextCenter
			{
				shadow = 0;
				colorText[] = {0.09, 0.09, 0.09, 1};
				sizeEx = GRID_H(1.95);
				text = "S";
				onLoad = "uiNamespace setVariable ['Sting_ModeText', _this # 0];";

				x = STING_X(0.019);
				y = STING_Y(0.919);
				w = GRID_W(5.2);
				h = GRID_H(5.2);
			};

			class VerticalSpeedText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.98);
				text = "0.0m/s";
				onLoad = "uiNamespace setVariable ['Sting_VerticalSpeedText', _this # 0];";

				x = STING_X(0.078);
				y = STING_Y(0.912);
				w = GRID_W(6.0);
				h = GRID_H(1.1);
			};

			class HorizontalSpeedText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.98);
				text = "12.7m/s";
				onLoad = "uiNamespace setVariable ['Sting_HorizontalSpeedText', _this # 0];";

				x = STING_X(0.167);
				y = STING_Y(0.912);
				w = GRID_W(6.4);
				h = GRID_H(1.1);
			};

			class HomeAltText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.48);
				text = "H 0.0m";
				onLoad = "uiNamespace setVariable ['Sting_HomeAltText', _this # 0];";

				x = STING_X(0.067);
				y = STING_Y(0.949);
				w = GRID_W(8.2);
				h = GRID_H(1.4);
			};

			class DistanceText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.48);
				text = "D 0m";
				onLoad = "uiNamespace setVariable ['Sting_DistanceText', _this # 0];";

				x = STING_X(0.162);
				y = STING_Y(0.949);
				w = GRID_W(7.0);
				h = GRID_H(1.4);
			};

			class DownAltitudeIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\down_arrow.paa";
				colorText[] = {1, 1, 1, 1};
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeIcon', _this # 0];";

				x = STING_X(0.357);
				y = STING_Y(0.934);
				w = GRID_W(1.7);
				h = GRID_H(2.8);
			};

			class DownAltitudeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.42);
				text = "4.1m";
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeText', _this # 0];";

				x = STING_X(0.381);
				y = STING_Y(0.949);
				w = GRID_W(6.0);
				h = GRID_H(1.4);
			};

			class BatteryBarBackground: StingHudSolid
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarBackground', _this # 0];";
				colorBackground[] = {0.22, 0.22, 0.22, 0.65};

				x = STING_X(0.621);
				y = STING_Y(0.935);
				w = GRID_W(3.45);
				h = GRID_H(1.05);
			};

			class BatteryBarFill: StingHudProgress
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarFill', _this # 0];";

				x = STING_X(0.621);
				y = STING_Y(0.935);
				w = GRID_W(3.45);
				h = GRID_H(1.05);
			};

			class BatteryPicture: StingHudIcon
			{
				text = "\sting\pictures\hud\battery_frame.paa";
				onLoad = "uiNamespace setVariable ['Sting_BatteryPicture', _this # 0];";

				x = STING_X(0.617);
				y = STING_Y(0.930);
				w = GRID_W(4.8);
				h = GRID_H(2.2);
			};

			class BatteryValueText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.95);
				text = "88";
				onLoad = "uiNamespace setVariable ['Sting_BatteryValueText', _this # 0];";

				x = STING_X(0.620);
				y = STING_Y(0.938);
				w = GRID_W(3.7);
				h = GRID_H(0.9);
			};

			class RemainingTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.62);
				text = "17'32";
				onLoad = "uiNamespace setVariable ['Sting_RemainingTimeText', _this # 0];";

				x = STING_X(0.666);
				y = STING_Y(0.947);
				w = GRID_W(8.0);
				h = GRID_H(1.4);
			};

			class LinkLabelRc: StingHudTextRight
			{
				sizeEx = GRID_H(0.58);
				text = "RC";

				x = STING_X(0.753);
				y = STING_Y(0.940);
				w = GRID_W(1.8);
				h = GRID_H(0.55);
			};

			class LinkLabelHd: StingHudTextRight
			{
				sizeEx = GRID_H(0.58);
				text = "HD";

				x = STING_X(0.753);
				y = STING_Y(0.954);
				w = GRID_W(1.8);
				h = GRID_H(0.55);
			};

			class LinkBarsIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\link_dual_bars.paa";
				x = STING_X(0.773);
				y = STING_Y(0.930);
				w = GRID_W(3.0);
				h = GRID_H(2.1);
			};

			class BitrateValueText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.32);
				text = "50";

				x = STING_X(0.806);
				y = STING_Y(0.947);
				w = GRID_W(3.2);
				h = GRID_H(1.2);
			};

			class BitrateLabelText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.64);
				text = "Mbps";

				x = STING_X(0.807);
				y = STING_Y(0.959);
				w = GRID_W(4.0);
				h = GRID_H(0.6);
			};

			class LatencyIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\latency_icon.paa";
				x = STING_X(0.874);
				y = STING_Y(0.932);
				w = GRID_W(2.0);
				h = GRID_H(1.9);
			};

			class LatencyText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.3);
				text = "27";

				x = STING_X(0.894);
				y = STING_Y(0.948);
				w = GRID_W(2.8);
				h = GRID_H(1.1);
			};

			class LinkPercentIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\goggles_icon.paa";
				x = STING_X(0.941);
				y = STING_Y(0.934);
				w = GRID_W(2.5);
				h = GRID_H(1.8);
			};

			class LinkPercentText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.3);
				text = "67%";

				x = STING_X(0.961);
				y = STING_Y(0.947);
				w = GRID_W(4.0);
				h = GRID_H(1.1);
			};
		};
	};
};
