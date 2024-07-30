class CfgPatches
{
	class DB_wpFix
	{
		author="DarkBall";
		name="Waypoint Fix";
		url="https://www.arma3.com";
		requiredAddons[]=
		{
			"A3_Ui_F"
		};
		requiredVersion=0.1;
		units[]={};
		weapons[]={};
	};
};
class RscDisplayUavTerminalWaypointMenu
{
	idc=108;
	type=14;
	font="RobotoCondensed";
	sizeEx="0.028*SafezoneH";
	style=0;
	colorBackground[]={0,0,0,0.5};
	colorBorder[]={0,0,0,0};
	colorSeparator[]={0.94999999,0.94999999,0.94999999,1};
	colorSelectBackground[]={1,1,1,0.30000001};
	colorChecked[]=
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
	colorEnabled[]={1,1,1,1};
	colorDisabled[]={1,1,1,0.25};
	x=0;
	y=0;
	w=0;
	h=0;
	onMenuSelected="_this call DB_fnc_setUavWaypointToLand";
};
class CfgFunctions
{
	class DB
	{
		class WpFix
		{
			file="\wpFix";
			class setUavWaypointToLand
			{
			};
			class monitorUavLanding
			{
				postInit=1;
			};
		};
	};
};
class cfgMods
{
	author="[SEAL TEAM] DarkBall";
	timepacked="1702139293";
};
