class BIS_AddonInfo
{
	author="[SEAL TEAM] DarkBall";
	timepacked="1656536061";
};
class CfgPatches
{
	class DB_MainMenu_Edit
	{
		name="Main Menu Edit";
		author="DarkBall";
		url="";
		requiredVersion=2.0799999;
		requiredAddons[]=
		{
			"A3_Data_F_AoW_Loadorder"
		};
		units[]={};
		weapons[]={};
	};
};
class RscStandardDisplay;
class RscPicture;
class RscActivePicture;
class RscText;
class RscDisplayMain: RscStandardDisplay
{
	delete Spotlight;
	class controls
	{
		class Logo;
		delete Spotlight1;
		delete Spotlight2;
		delete Spotlight3;
		delete BackgroundSpotlightRight;
		delete BackgroundSpotlightLeft;
		delete BackgroundSpotlight;
	};
	class ControlsBackground
	{
		class Background: RscText
		{
			idc=-1;
			colorBackground[]={0,0,0,1};
			x="safeZoneXAbs";
			y="safeZoneY";
			w="safeZoneWAbs";
			h="safeZoneH";
		};
		class BackgroundHover: RscPicture
		{
			idc=1009;
			x="safeZoneXAbs";
			y="safeZoneY";
			w="safeZoneWAbs";
			h="safeZoneH";
		};
	};
};
class cfgMods
{
	author="[SEAL TEAM] DarkBall";
	timepacked="1777076298";
};
class CfgWorlds
{
	class CAWorld;
	class Stratis: CAWorld
	{
		cutscenes[]=
		{
			"DB_IntroMission"
		};
	};
	initWorld="Stratis";
	demoWorld="Stratis";
};
class CfgMissions
{
	class Cutscenes
	{
		class DB_IntroMission
		{
			directory="\zzzzzzzz_mainmenu\IntroMission.Stratis";
		};
	};
};
