class RscText;
class ctrlStaticPicture;
class ctrlStructuredText;

#define GRID_W(NUM) ( NUM * ( pixelGridNoUIScale * pixelW * 2 ) )
#define GRID_H(NUM) ( NUM * ( pixelGridNoUIScale * pixelH * 2 ) )

#define STING_X(NUM) (safeZoneXAbs + safeZoneWAbs * (NUM))
#define STING_Y(NUM) (safeZoneY + safeZoneH * (NUM))

class StingHudIcon: ctrlStaticPicture
{
	idc = -1;
	shadow = 2;
	shadowColor[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	text = "";
};

class StingHudTextLeft: ctrlStructuredText
{
	idc = -1;
	shadow = 2;
	shadowColor[] = {0, 0, 0, 1};
	colorBackground[] = {0, 0, 0, 0};
	size = GRID_H(1.4);
	text = "";

	class Attributes
	{
		font = "RobotoCondensed";
		align = "left";
		shadow = 1;
		color = "#FFFFFFFF";
	};
};

class StingHudTextCenter: StingHudTextLeft
{
	class Attributes: Attributes
	{
		font = "RobotoCondensed";
		align = "center";
		shadow = 1;
		color = "#FFFFFFFF";
	};
};

class StingHudTextRight: StingHudTextLeft
{
	class Attributes: Attributes
	{
		font = "RobotoCondensed";
		align = "right";
		shadow = 1;
		color = "#FFFFFFFF";
	};
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
				text = "\sting\pictures\hud\reticle_ring.png";
				x = STING_X(0.515);
				y = STING_Y(0.521);
				w = GRID_W(3.4);
				h = GRID_H(3.4);
			};

			class RecordDot: StingHudIcon
			{
				text = "\sting\pictures\hud\record_dot.png";
				x = STING_X(0.829);
				y = STING_Y(0.289);
				w = GRID_W(1.0);
				h = GRID_H(1.0);
			};

			class RecordTimeText: StingHudTextLeft
			{
				size = GRID_H(1.7);
				text = "00:00";
				onLoad = "uiNamespace setVariable ['Sting_RecordTimeText', _this # 0];";

				x = STING_X(0.846);
				y = STING_Y(0.282);
				w = GRID_W(8.2);
				h = GRID_H(1.8);
			};

			class ModeBadge: StingHudIcon
			{
				text = "\sting\pictures\hud\mode_s.png";
				x = STING_X(0.019);
				y = STING_Y(0.906);
				w = GRID_W(5.2);
				h = GRID_H(5.2);
			};

			class ModeText: StingHudTextCenter
			{
				size = GRID_H(2.8);
				text = "S";
				onLoad = "uiNamespace setVariable ['Sting_ModeText', _this # 0];";

				class Attributes
				{
					font = "RobotoCondensed";
					align = "center";
					shadow = 0;
					color = "#161616";
				};

				x = STING_X(0.019);
				y = STING_Y(0.910);
				w = GRID_W(5.2);
				h = GRID_H(5.2);
			};

			class VerticalSpeedText: StingHudTextLeft
			{
				size = GRID_H(1.5);
				text = "0.0m/s";
				onLoad = "uiNamespace setVariable ['Sting_VerticalSpeedText', _this # 0];";

				x = STING_X(0.078);
				y = STING_Y(0.907);
				w = GRID_W(7.4);
				h = GRID_H(1.4);
			};

			class HorizontalSpeedText: StingHudTextLeft
			{
				size = GRID_H(1.5);
				text = "12.7m/s";
				onLoad = "uiNamespace setVariable ['Sting_HorizontalSpeedText', _this # 0];";

				x = STING_X(0.167);
				y = STING_Y(0.907);
				w = GRID_W(7.4);
				h = GRID_H(1.4);
			};

			class HomeAltText: StingHudTextLeft
			{
				size = GRID_H(2.2);
				text = "H 0.0m";
				onLoad = "uiNamespace setVariable ['Sting_HomeAltText', _this # 0];";

				x = STING_X(0.067);
				y = STING_Y(0.939);
				w = GRID_W(10.0);
				h = GRID_H(2.0);
			};

			class DistanceText: StingHudTextLeft
			{
				size = GRID_H(2.2);
				text = "D 0m";
				onLoad = "uiNamespace setVariable ['Sting_DistanceText', _this # 0];";

				x = STING_X(0.162);
				y = STING_Y(0.939);
				w = GRID_W(9.0);
				h = GRID_H(2.0);
			};

			class DownAltitudeIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\down_arrow.png";
				colorText[] = {1, 1, 1, 1};
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeIcon', _this # 0];";

				x = STING_X(0.357);
				y = STING_Y(0.934);
				w = GRID_W(1.7);
				h = GRID_H(2.8);
			};

			class DownAltitudeText: StingHudTextLeft
			{
				size = GRID_H(2.1);
				text = "4.1m";
				onLoad = "uiNamespace setVariable ['Sting_DownAltitudeText', _this # 0];";

				x = STING_X(0.381);
				y = STING_Y(0.939);
				w = GRID_W(6.0);
				h = GRID_H(1.8);
			};

			class BatteryPicture: StingHudIcon
			{
				text = "\sting\pictures\hud\battery_frame.png";
				onLoad = "uiNamespace setVariable ['Sting_BatteryPicture', _this # 0];";

				x = STING_X(0.617);
				y = STING_Y(0.930);
				w = GRID_W(4.8);
				h = GRID_H(2.2);
			};

			class BatteryValueText: StingHudTextCenter
			{
				size = GRID_H(1.35);
				text = "88";
				onLoad = "uiNamespace setVariable ['Sting_BatteryValueText', _this # 0];";

				x = STING_X(0.620);
				y = STING_Y(0.933);
				w = GRID_W(3.7);
				h = GRID_H(1.2);
			};

			class RemainingTimeText: StingHudTextLeft
			{
				size = GRID_H(2.3);
				text = "17'32";
				onLoad = "uiNamespace setVariable ['Sting_RemainingTimeText', _this # 0];";

				x = STING_X(0.666);
				y = STING_Y(0.936);
				w = GRID_W(8.0);
				h = GRID_H(2.0);
			};

			class LinkLabelRc: StingHudTextRight
			{
				size = GRID_H(0.8);
				text = "RC";

				x = STING_X(0.753);
				y = STING_Y(0.931);
				w = GRID_W(1.8);
				h = GRID_H(0.8);
			};

			class LinkLabelHd: StingHudTextRight
			{
				size = GRID_H(0.8);
				text = "HD";

				x = STING_X(0.753);
				y = STING_Y(0.949);
				w = GRID_W(1.8);
				h = GRID_H(0.8);
			};

			class LinkBarsIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\link_dual_bars.png";
				x = STING_X(0.773);
				y = STING_Y(0.930);
				w = GRID_W(3.0);
				h = GRID_H(2.1);
			};

			class BitrateValueText: StingHudTextLeft
			{
				size = GRID_H(2.2);
				text = "50";

				x = STING_X(0.806);
				y = STING_Y(0.936);
				w = GRID_W(3.2);
				h = GRID_H(1.6);
			};

			class BitrateLabelText: StingHudTextLeft
			{
				size = GRID_H(0.95);
				text = "Mbps";

				x = STING_X(0.807);
				y = STING_Y(0.955);
				w = GRID_W(4.0);
				h = GRID_H(0.9);
			};

			class LatencyIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\latency_icon.png";
				x = STING_X(0.874);
				y = STING_Y(0.932);
				w = GRID_W(2.0);
				h = GRID_H(1.9);
			};

			class LatencyText: StingHudTextLeft
			{
				size = GRID_H(1.9);
				text = "27";

				x = STING_X(0.894);
				y = STING_Y(0.938);
				w = GRID_W(2.8);
				h = GRID_H(1.5);
			};

			class LinkPercentIcon: StingHudIcon
			{
				text = "\sting\pictures\hud\goggles_icon.png";
				x = STING_X(0.941);
				y = STING_Y(0.934);
				w = GRID_W(2.5);
				h = GRID_H(1.8);
			};

			class LinkPercentText: StingHudTextLeft
			{
				size = GRID_H(2.0);
				text = "67%";

				x = STING_X(0.961);
				y = STING_Y(0.937);
				w = GRID_W(4.0);
				h = GRID_H(1.6);
			};
		};
	};
};
