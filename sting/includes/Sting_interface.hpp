class RscText;
class RscProgress;
class ctrlStaticPicture;

#define GRID_W(NUM) ( NUM * ( pixelGridNoUIScale * pixelW * 2 ) )
#define GRID_H(NUM) ( NUM * ( pixelGridNoUIScale * pixelH * 2 ) )

#define STING_X(NUM) (safeZoneXAbs + safeZoneWAbs * (NUM))
#define STING_Y(NUM) (safeZoneY + safeZoneH * (NUM))
#define STING_STYLE_LEFT 12
#define STING_STYLE_RIGHT 13
#define STING_STYLE_CENTER 14
#define STING_STYLE_PICTURE 2096

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
				x = STING_X(0.522);
				y = STING_Y(0.530);
				w = GRID_W(3.2);
				h = GRID_H(3.2);
			};

			class RecordDot: StingHudIcon
			{
				text = "\sting\pictures\hud\record_dot.paa";
				x = STING_X(0.833);
				y = STING_Y(0.289);
				w = GRID_W(0.95);
				h = GRID_H(0.95);
			};

			class RecordTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.08);
				text = "00:00";
				onLoad = "uiNamespace setVariable ['Sting_RecordTimeText', _this # 0];";

				x = STING_X(0.849);
				y = STING_Y(0.286);
				w = GRID_W(6.2);
				h = GRID_H(1.2);
			};

			class ModeBadge: StingHudIcon
			{
				text = "\sting\pictures\hud\mode_s.paa";
				x = STING_X(0.022);
				y = STING_Y(0.857);
				w = GRID_W(4.9);
				h = GRID_H(4.9);
			};

			class ModeText: StingHudTextCenter
			{
				shadow = 0;
				colorText[] = {0, 0, 0, 1};
				sizeEx = GRID_H(2.55);
				text = "S";
				onLoad = "uiNamespace setVariable ['Sting_ModeText', _this # 0];";

				x = STING_X(0.022);
				y = STING_Y(0.865);
				w = GRID_W(4.9);
				h = GRID_H(2.7);
			};

			class VerticalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.84);
				text = "0.0m/s";
				onLoad = "uiNamespace setVariable ['Sting_VerticalSpeedText', _this # 0];";

				x = STING_X(0.071);
				y = STING_Y(0.869);
				w = GRID_W(5.2);
				h = GRID_H(0.95);
			};

			class HorizontalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.84);
				text = "12.7m/s";
				onLoad = "uiNamespace setVariable ['Sting_HorizontalSpeedText', _this # 0];";

				x = STING_X(0.154);
				y = STING_Y(0.869);
				w = GRID_W(5.8);
				h = GRID_H(0.95);
			};

			class HomeAltText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.26);
				text = "H 0.0m";
				onLoad = "uiNamespace setVariable ['Sting_HomeAltText', _this # 0];";

				x = STING_X(0.064);
				y = STING_Y(0.904);
				w = GRID_W(7.6);
				h = GRID_H(1.2);
			};

			class DistanceText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.26);
				text = "D 0m";
				onLoad = "uiNamespace setVariable ['Sting_DistanceText', _this # 0];";

				x = STING_X(0.149);
				y = STING_Y(0.904);
				w = GRID_W(7.0);
				h = GRID_H(1.2);
			};

			class DownAltitudeIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\down_arrow.paa";
				colorText[] = {1, 1, 1, 1};
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeIcon', _this # 0];";

				x = STING_X(0.357);
				y = STING_Y(0.889);
				w = GRID_W(1.5);
				h = GRID_H(2.5);
			};

			class DownAltitudeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.30);
				text = "4.1m";
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeText', _this # 0];";

				x = STING_X(0.378);
				y = STING_Y(0.904);
				w = GRID_W(5.2);
				h = GRID_H(1.2);
			};

			class BatteryBarBackground: StingHudSolid
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarBackground', _this # 0];";
				colorBackground[] = {0.22, 0.22, 0.22, 0.65};

				x = STING_X(0.623);
				y = STING_Y(0.889);
				w = GRID_W(3.20);
				h = GRID_H(0.92);
			};

			class BatteryBarFill: StingHudProgress
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarFill', _this # 0];";

				x = STING_X(0.623);
				y = STING_Y(0.889);
				w = GRID_W(3.20);
				h = GRID_H(0.92);
			};

			class BatteryPicture: StingHudIcon
			{
				text = "\sting\pictures\hud\battery_frame.paa";
				onLoad = "uiNamespace setVariable ['Sting_BatteryPicture', _this # 0];";

				x = STING_X(0.619);
				y = STING_Y(0.884);
				w = GRID_W(4.55);
				h = GRID_H(2.05);
			};

			class BatteryValueText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.82);
				text = "88";
				onLoad = "uiNamespace setVariable ['Sting_BatteryValueText', _this # 0];";

				x = STING_X(0.621);
				y = STING_Y(0.892);
				w = GRID_W(3.45);
				h = GRID_H(0.8);
			};

			class RemainingTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.42);
				text = "17'32""";
				onLoad = "uiNamespace setVariable ['Sting_RemainingTimeText', _this # 0];";

				x = STING_X(0.664);
				y = STING_Y(0.900);
				w = GRID_W(7.0);
				h = GRID_H(1.2);
			};

			class LinkLabelRc: StingHudTextRight
			{
				sizeEx = GRID_H(0.54);
				text = "RC";

				x = STING_X(0.756);
				y = STING_Y(0.895);
				w = GRID_W(1.7);
				h = GRID_H(0.50);
			};

			class LinkLabelHd: StingHudTextRight
			{
				sizeEx = GRID_H(0.54);
				text = "HD";

				x = STING_X(0.756);
				y = STING_Y(0.908);
				w = GRID_W(1.7);
				h = GRID_H(0.50);
			};

			class LinkBarsIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\link_dual_bars.paa";
				x = STING_X(0.774);
				y = STING_Y(0.885);
				w = GRID_W(2.8);
				h = GRID_H(1.95);
			};

			class BitrateValueText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.12);
				text = "50";

				x = STING_X(0.805);
				y = STING_Y(0.901);
				w = GRID_W(2.8);
				h = GRID_H(1.0);
			};

			class BitrateLabelText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.58);
				text = "Mbps";

				x = STING_X(0.806);
				y = STING_Y(0.914);
				w = GRID_W(3.2);
				h = GRID_H(0.5);
			};

			class LatencyIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\latency_icon.paa";
				x = STING_X(0.872);
				y = STING_Y(0.887);
				w = GRID_W(1.85);
				h = GRID_H(1.75);
			};

			class LatencyText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.10);
				text = "27";

				x = STING_X(0.891);
				y = STING_Y(0.901);
				w = GRID_W(2.2);
				h = GRID_H(1.0);
			};

			class LinkPercentIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\goggles_icon.paa";
				x = STING_X(0.937);
				y = STING_Y(0.889);
				w = GRID_W(2.3);
				h = GRID_H(1.65);
			};

			class LinkPercentText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.10);
				text = "67%";

				x = STING_X(0.958);
				y = STING_Y(0.901);
				w = GRID_W(3.2);
				h = GRID_H(1.0);
			};
		};
	};
};
