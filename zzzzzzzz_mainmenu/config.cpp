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
class CfgFunctions
{
	class DB_MainMenu
	{
		class MainMenu
		{
			file="\zzzzzzzz_mainmenu\functions";
			class preInit
			{
				preInit=1;
			};
		};
	};
};
class RscDisplayMain: RscStandardDisplay
{
	onLoad="(_this # 0) setVariable ['DB_mainMenuDisplay',true]; _this execVM '\zzzzzzzz_mainmenu\IntroMission.Stratis\initIntro.sqf'; ['onLoad',_this,'RscDisplayMain','GUI'] call (uiNamespace getVariable ['BIS_fnc_initDisplay',{}]);";
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
			text="\zzzzzzzz_mainmenu\pictures\Screen_1.paa";
			colorText[]={1,1,1,1};
			x="safeZoneXAbs";
			y="safeZoneY";
			w="safeZoneWAbs";
			h="safeZoneH";
			onLoad="(ctrlParent (_this # 0)) setVariable ['DB_mainMenuDisplay',true]; uiNamespace setVariable ['DB_mainMenuBgCurrent',_this # 0]; _this execVM '\zzzzzzzz_mainmenu\IntroMission.Stratis\initIntro.sqf';";
		};
		class BackgroundSlideNext: RscPicture
		{
			idc=1010;
			text="";
			colorText[]={1,1,1,1};
			x="safeZoneXAbs";
			y="safeZoneY";
			w="safeZoneWAbs";
			h="safeZoneH";
		};
	};
};
class CfgMusic
{
	tracks[]=
	{
		"DB_MainMenu_Fonk"
	};
	class DB_MainMenu_Fonk
	{
		name="DB_MainMenu_Fonk";
		sound[]=
		{
			"\zzzzzzzz_mainmenu\IntroMission.Stratis\music\fonk.ogg",
			1,
			1
		};
		duration=159.420839;
		musicClass="DB_MainMenu";
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
