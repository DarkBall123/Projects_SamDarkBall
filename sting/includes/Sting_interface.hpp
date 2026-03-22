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
				x = STING_X(0.523);
				y = STING_Y(0.531);
				w = GRID_W(2.8);
				h = GRID_H(2.8);
			};

			class RecordDot: StingHudIcon
			{
				text = "\sting\pictures\hud\record_dot.paa";
				x = STING_X(0.836);
				y = STING_Y(0.292);
				w = GRID_W(0.82);
				h = GRID_H(0.82);
			};

			class RecordTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.96);
				text = "00:00";
				onLoad = "uiNamespace setVariable ['Sting_RecordTimeText', _this # 0];";

				x = STING_X(0.853);
				y = STING_Y(0.289);
				w = GRID_W(5.0);
				h = GRID_H(1.0);
			};

			class ModeBadge: StingHudIcon
			{
				text = "\sting\pictures\hud\mode_s.paa";
				x = STING_X(0.022);
				y = STING_Y(0.892);
				w = GRID_W(3.9);
				h = GRID_H(3.9);
			};

			class ModeText: StingHudTextCenter
			{
				shadow = 0;
				colorText[] = {0, 0, 0, 1};
				sizeEx = GRID_H(1.85);
				text = "S";
				onLoad = "uiNamespace setVariable ['Sting_ModeText', _this # 0];";

				x = STING_X(0.022);
				y = STING_Y(0.900);
				w = GRID_W(3.9);
				h = GRID_H(1.9);
			};

			class VerticalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.76);
				text = "0.0m/s";
				onLoad = "uiNamespace setVariable ['Sting_VerticalSpeedText', _this # 0];";

				x = STING_X(0.074);
				y = STING_Y(0.896);
				w = GRID_W(4.6);
				h = GRID_H(0.82);
			};

			class HorizontalSpeedText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.76);
				text = "12.7m/s";
				onLoad = "uiNamespace setVariable ['Sting_HorizontalSpeedText', _this # 0];";

				x = STING_X(0.161);
				y = STING_Y(0.896);
				w = GRID_W(5.0);
				h = GRID_H(0.82);
			};

			class HomeAltText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.05);
				text = "H 0.0m";
				onLoad = "uiNamespace setVariable ['Sting_HomeAltText', _this # 0];";

				x = STING_X(0.061);
				y = STING_Y(0.924);
				w = GRID_W(6.4);
				h = GRID_H(1.0);
			};

			class DistanceText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.05);
				text = "D 0m";
				onLoad = "uiNamespace setVariable ['Sting_DistanceText', _this # 0];";

				x = STING_X(0.144);
				y = STING_Y(0.924);
				w = GRID_W(5.8);
				h = GRID_H(1.0);
			};

			class DownAltitudeIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\down_arrow.paa";
				colorText[] = {1, 1, 1, 1};
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeIcon', _this # 0];";

				x = STING_X(0.355);
				y = STING_Y(0.910);
				w = GRID_W(1.3);
				h = GRID_H(2.1);
			};

			class DownAltitudeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.08);
				text = "4.1m";
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeText', _this # 0];";

				x = STING_X(0.376);
				y = STING_Y(0.924);
				w = GRID_W(4.4);
				h = GRID_H(1.0);
			};

			class BatteryBarBackground: StingHudSolid
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarBackground', _this # 0];";
				colorBackground[] = {0.22, 0.22, 0.22, 0.65};

				x = STING_X(0.622);
				y = STING_Y(0.910);
				w = GRID_W(2.92);
				h = GRID_H(0.80);
			};

			class BatteryBarFill: StingHudProgress
			{
				onLoad = "uiNamespace setVariable ['Sting_BatteryBarFill', _this # 0];";

				x = STING_X(0.622);
				y = STING_Y(0.910);
				w = GRID_W(2.92);
				h = GRID_H(0.80);
			};

			class BatteryPicture: StingHudIcon
			{
				text = "\sting\pictures\hud\battery_frame.paa";
				onLoad = "uiNamespace setVariable ['Sting_BatteryPicture', _this # 0];";

				x = STING_X(0.618);
				y = STING_Y(0.905);
				w = GRID_W(4.15);
				h = GRID_H(1.82);
			};

			class BatteryValueText: StingHudTextCenter
			{
				sizeEx = GRID_H(0.74);
				text = "88";
				onLoad = "uiNamespace setVariable ['Sting_BatteryValueText', _this # 0];";

				x = STING_X(0.620);
				y = STING_Y(0.913);
				w = GRID_W(3.15);
				h = GRID_H(0.68);
			};

			class RemainingTimeText: StingHudTextLeft
			{
				sizeEx = GRID_H(1.16);
				text = "17'32""";
				onLoad = "uiNamespace setVariable ['Sting_RemainingTimeText', _this # 0];";

				x = STING_X(0.661);
				y = STING_Y(0.922);
				w = GRID_W(5.8);
				h = GRID_H(1.0);
			};

			class LinkLabelRc: StingHudTextRight
			{
				sizeEx = GRID_H(0.46);
				text = "RC";

				x = STING_X(0.751);
				y = STING_Y(0.916);
				w = GRID_W(1.5);
				h = GRID_H(0.42);
			};

			class LinkLabelHd: StingHudTextRight
			{
				sizeEx = GRID_H(0.46);
				text = "HD";

				x = STING_X(0.751);
				y = STING_Y(0.927);
				w = GRID_W(1.5);
				h = GRID_H(0.42);
			};

			class LinkBarsIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\link_dual_bars.paa";
				x = STING_X(0.769);
				y = STING_Y(0.908);
				w = GRID_W(2.45);
				h = GRID_H(1.70);
			};

			class BitrateValueText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.98);
				text = "50";

				x = STING_X(0.799);
				y = STING_Y(0.922);
				w = GRID_W(2.2);
				h = GRID_H(0.9);
			};

			class BitrateLabelText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.50);
				text = "Mbps";

				x = STING_X(0.799);
				y = STING_Y(0.933);
				w = GRID_W(2.6);
				h = GRID_H(0.42);
			};

			class LatencyIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\latency_icon.paa";
				x = STING_X(0.866);
				y = STING_Y(0.910);
				w = GRID_W(1.60);
				h = GRID_H(1.55);
			};

			class LatencyText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.96);
				text = "27";

				x = STING_X(0.882);
				y = STING_Y(0.922);
				w = GRID_W(1.8);
				h = GRID_H(0.9);
			};

			class LinkPercentIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\goggles_icon.paa";
				x = STING_X(0.932);
				y = STING_Y(0.911);
				w = GRID_W(2.05);
				h = GRID_H(1.45);
			};

			class LinkPercentText: StingHudTextLeft
			{
				sizeEx = GRID_H(0.96);
				text = "67%";

				x = STING_X(0.950);
				y = STING_Y(0.922);
				w = GRID_W(2.4);
				h = GRID_H(0.9);
			};
		};
	};
};
