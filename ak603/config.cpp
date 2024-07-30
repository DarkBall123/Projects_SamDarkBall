class CfgPatches
{
	class ak630m3
	{
		addonRootClass="A3_Static_F_Jets";
		requiredAddons[]=
		{
			"A3_Static_F_Jets"
		};
		requiredVersion=0.1;
		units[]=
		{
			"ak603_O",
			"ak603_B"
		};
		weapons[]={"Ak603_MainWeapon"};
	};
};

#include "interface\Ak607_Interface.hpp"

class CfgWeapons
{
    class Gatling_30mm_Plane_CAS_01_F;
    class Ak603_MainWeapon : Gatling_30mm_Plane_CAS_01_F
    {
        displayName = "2X AO-18KD";
        ballisticsComputer = 4;
        magazines[] = {"Ak603_Mag"};        
    };
};
class CfgAmmo
{
    class Gatling_30mm_HE_Plane_CAS_01_F;
    class Ak603_ammo : Gatling_30mm_HE_Plane_CAS_01_F
    {
        displayName = "AO-18KD 30×165mm";
        author = "Bohemia Interactive";
        tracerColor[] = {0.7,0.7,0.5,0.04};
        tracerColorR[] = {0.7,0.7,0.5,0.04};
        tracerEndTime = 4.7;
        tracerScale = 2.5;
        tracerStartTime = 0.1;        
    };
};
class CfgMagazines
{
    class 1000Rnd_Gatling_30mm_Plane_CAS_01_F;
    class Ak603_Mag : 1000Rnd_Gatling_30mm_Plane_CAS_01_F
    {
        displayName = "AO-18KD 30×165mm Magazine";
        ammo = "Ak603_ammo";
        count = 2000;
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
class VehicleSystemsTemplateLeftPilot: DefaultVehicleSystemsDisplayManagerLeft
{
	class components;
};
class VehicleSystemsTemplateRightPilot: DefaultVehicleSystemsDisplayManagerRight
{
	class components;
};
class Eventhandlers;
class CfgVehicles
{
	class NonStrategic;
	class StaticShip;
	class Building;
	class House_F;
	class FloatingStructure_F;
	class thingx;
	class Ship;
	class LandVehicle;
	class StaticWeapon: LandVehicle
	{
		class Turrets;
		class HitPoints;
	};
	class StaticMGWeapon: StaticWeapon
	{
		class Turrets: Turrets
		{
			class MainTurret;
		};
		class Components;
	};
	class ak603_base_F: StaticMGWeapon
	{
		author="$STR_A3_author_B01";
		scope=0;
		scopeCurator=0;
		vehicleClass="Autonomous";
		picture="\ak603\textures\preview_ak630.jpg";
		uiPicture="\ak603\textures\preview_ak630.jpg";
		icon="\A3\Static_F_Jets\AAA_system_01\Data\UI\AAA_system_01_icon_CA.paa";
		displayName="AK630m2Duet";
		DLC="Jets";
		hasDriver=0;
		hasGunner=1;
		isUav=1;
		getInRadius=0;
		uavCameraGunnerPos="pos_gunner_view";
		uavCameraGunnerDir="pos_gunner_view_dir";
		memoryPointGun="pos_barrel_end";
		threat[]={0.30000001,0.30000001,1};
		cost=150000;
		accuracy=0.12;
		editorPreview="\A3\EditorPreviews_F_Jets\Data\Cfgvehicles\B_AAA_system_01_F.jpg";
		unitInfoType="RscUnitInfoTank";
		model="\ak603\ak603.p3d";
		destrType="DestructWreck";
		hiddenSelections[]=
		{
			"Camo1",
			"Camo2"
		};
		hiddenSelectionsTextures[]=
		{
			"a3\static_f_jets\aaa_system_01\data\aaa_system_01_co.paa",
			"a3\static_f_jets\aaa_system_01\data\aaa_system_02_co.paa"
		};
		extCameraPosition[]={0,1.5,-10};
		canFloat=0;
		class TextureSources
		{
			class LightGrey
			{
				displayName="$STR_A3_TEXTURESOURCES_LIGHTGREY0";
				author="$STR_A3_author_B01";
				textures[]=
				{
					"a3\static_f_jets\aaa_system_01\data\aaa_system_01_co.paa",
					"a3\static_f_jets\aaa_system_01\data\aaa_system_02_co.paa"
				};
				factions[]=
				{
					"BLU_F"
				};
			};
			class Sand
			{
				displayName="$STR_A3_TEXTURESOURCES_SAND0";
				author="$STR_A3_author_B01";
				textures[]=
				{
					"a3\static_f_jets\aaa_system_01\data\aaa_system_01_TAN_co.paa",
					"a3\static_f_jets\aaa_system_01\data\aaa_system_02_TAN_co.paa"
				};
				factions[]=
				{
					"BLU_F"
				};
			};
			class Green
			{
				displayName="$STR_A3_TEXTURESOURCES_GREEN0";
				author="$STR_A3_author_B01";
				textures[]=
				{
					"a3\static_f_jets\aaa_system_01\data\aaa_system_01_olive_co.paa",
					"a3\static_f_jets\aaa_system_01\data\aaa_system_02_olive_co.paa"
				};
				factions[]=
				{
					"BLU_F"
				};
			};
		};
		animationList[]={};
		textureList[]=
		{
			"LightGrey",
			1,
			"Sand",
			0,
			"Green",
			0
		};
		enableGPS=1;
		radartype=2;
		radarTarget=1;
		radarTargetSize=0.89999998;
		visualTarget=1;
		visualTargetSize=1.2;
		irTarget=1;
		irTargetSize=0.5;
		reportRemoteTargets=1;
		receiveRemoteTargets=1;
		reportOwnPosition=1;
		lockDetectionSystem=0;
		incomingMissileDetectionSystem=16;
		class Components: Components
		{
			class SensorsManagerComponent
			{
				class Components
				{
					class IRSensorComponent: SensorTemplateIR
					{
						class AirTarget
						{
							minRange=500;
							maxRange=4000;
							objectDistanceLimitCoef=-1;
							viewDistanceLimitCoef=1;
						};
						class GroundTarget
						{
							minRange=500;
							maxRange=3500;
							objectDistanceLimitCoef=1;
							viewDistanceLimitCoef=1;
						};
						typeRecognitionDistance=3500;
						maxTrackableSpeed=600;
						angleRangeHorizontal=60;
						angleRangeVertical=40;
						animDirection="mainGun";
						aimDown=-0.5;
					};
					class ActiveRadarSensorComponent: SensorTemplateActiveRadar
					{
						class AirTarget
						{
							minRange=10000;
							maxRange=10000;
							objectDistanceLimitCoef=-1;
							viewDistanceLimitCoef=-1;
						};
						class GroundTarget
						{
							minRange=7000;
							maxRange=7000;
							objectDistanceLimitCoef=-1;
							viewDistanceLimitCoef=-1;
						};
						typeRecognitionDistance=7000;
						angleRangeHorizontal=360;
						angleRangeVertical=100;
						aimDown=-45;
						maxTrackableSpeed=1388.89;
					};
					class DataLinkSensorComponent: SensorTemplateDataLink
					{
					};
				};
			};
		};
		animated=1;
		class AnimationSources
		{
			class Revolving
			{
				source="revolving";
				weapon="Gatling_30mm_Plane_CAS_01_F";
			};
			class muzzle_rot_20mm: Revolving
			{
				source="ammorandom";
			};
		};
		armor=80;
		armorStructural=2;
		damageResistance=0.0040000002;
		damageEffect="AirDestructionEffects";
		class HitPoints: HitPoints
		{
			class HitHull
			{
				armor=3;
				name="hit_hull";
				visual="zbytek";
				radius=0.25;
				minimalHit=0.050000001;
				explosionShielding=0.2;
				depends="Total";
				passThrough=0.1;
				material=51;
			};
			class Hitoptics: HitHull
			{
				armor=0.2;
				name="hit_optics";
				visual="optics";
				convexComponent="optics";
				radius=0.059999999;
				minimalHit=0.0099999998;
				explosionShielding=0.1;
			};
			class HitTurret: HitHull
			{
				armor=3;
				name="hit_turret";
				convexComponent="turret";
				visual="turret";
				passThrough=0.1;
				minimalHit=0.1;
				explosionShielding=0.2;
				class DestructionEffects
				{
					class light1
					{
						simulation="light";
						type="ObjectDestructionLight";
						position="turretdestruct_pos";
						intensity=0.001;
						interval=1;
						lifeTime=3;
					};
					class smoke1
					{
						simulation="particles";
						type="ObjectDestructionSmoke";
						position="turretdestruct_pos";
						intensity=0.15000001;
						interval=1;
						lifeTime=3.5;
					};
					class fire1
					{
						simulation="particles";
						type="ObjectDestructionFire1";
						position="turretdestruct_pos";
						intensity=0.15000001;
						interval=1;
						lifeTime=3;
					};
					class sparks1
					{
						simulation="particles";
						type="ObjectDestructionSparks";
						position="turretdestruct_pos";
						intensity=0;
						interval=1;
						lifeTime=0;
					};
					class sound
					{
						simulation="sound";
						position="turretdestruct_pos";
						intensity=1;
						interval=1;
						lifeTime=1;
						type="Fire";
					};
				};
			};
			class Hitgun: HitTurret
			{
				name="hit_gun";
				visual="gun";
				convexComponent="gun";
				armor=2;
				passThrough=0.1;
				explosionShielding=1;
				class DestructionEffects: DestructionEffects
				{
					class light1: light1
					{
						position="gundestruct_pos";
					};
					class smoke1: smoke1
					{
						position="gundestruct_pos";
					};
					class fire1: fire1
					{
						position="gundestruct_pos";
					};
					class sparks1: sparks1
					{
						position="gundestruct_pos";
					};
					class sound: sound
					{
						position="gundestruct_pos";
					};
				};
			};
		};
		class Damage
		{
			tex[]={};
			mat[]=
			{
				"a3\static_f_jets\aaa_system_01\data\AAA_system_01.rvmat",
				"a3\static_f_jets\aaa_system_01\data\AAA_system_01_damage.rvmat",
				"a3\static_f_jets\aaa_system_01\data\AAA_system_01_destruct.rvmat",
				"a3\static_f_jets\aaa_system_01\data\AAA_system_02.rvmat",
				"a3\static_f_jets\aaa_system_01\data\AAA_system_02_damage.rvmat",
				"a3\static_f_jets\aaa_system_01\data\AAA_system_02_destruct.rvmat"
			};
		};
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				minelev=-5;
				maxelev=70;
				minturn=-180;
				maxturn=180;
				initElev=15;
				initTurn=0;
				stabilizedInAxes = 3;
				maxHorizontalRotSpeed=2.7;
				maxVerticalRotSpeed=2.7;
				soundServo[]=
				{
					"A3\Sounds_F\vehicles\armor\noises\servo_best",
					1.4125376,
					1,
					40
				};
				hasGunner=1;
				gunnerName="$STR_A3_Phalanx_operator_displayName";
				primary=1;
				primaryGunner=1;
				startEngine=0;
				enableManualFire=1;
				turretinfotype="RscOptics_Offroad_01";
				optics=1;
				gunnerOpticsModel="\ak603\1.p3d";
				class OpticsIn
				{
					class Wide
					{
						opticsDisplayName="W";
						initAngleX=0;
						minAngleX=-30;
						maxAngleX=30;
						initAngleY=0;
						minAngleY=-100;
						maxAngleY=100;
						initFov=0.46599999;
						minFov=0.46599999;
						maxFov=0.46599999;
						visionMode[]=
						{
							"Normal",
							"NVG",
							"Ti"
						};
						thermalMode[]={0,1};
						gunnerOpticsModel="\ak603\1.p3d";
					};
					class Medium: Wide
					{
						opticsDisplayName="M";
						initFov=0.093000002;
						minFov=0.093000002;
						maxFov=0.093000002;
						gunnerOpticsModel="\ak603\1.p3d";
					};
					class Narrow: Wide
					{
						opticsDisplayName="N";
						gunnerOpticsModel="\ak603\1.p3d";
						initFov=0.028999999;
						minFov=0.028999999;
						maxFov=0.028999999;
					};
				};
				forceHideGunner=1;
				gunnerforceoptics=1;
				gunnerOutForceOptics=1;
				viewgunnerinExternal=0;
				outGunnerMayFire=1;
				inGunnerMayFire=1;
				castGunnerShadow=0;
				showAllTargets=2;
				body="MainTurret";
				gun="MainGun";
				animationSourceBody="MainTurret";
				animationSourceGun="MainGun";
				gunbeg="pos_barrel_end";
				gunend="pos_barrel";
				uavCameraGunnerPos="pos_gunner_view";
				uavCameraGunnerDir="pos_gunner_view_dir";
				memoryPointGunnerOptics="pos_gunner_view";
				particlespos="pos_fx";
				particlesdir="pos_fx_dir";
				selectionFireAnim="zasleh";
				gunnerlefthandanimname="";
				gunnerrighthandanimname="";
				weapons[]=
				{
					"Ak603_MainWeapon"
				};
				magazines[]=
				{
					"Ak603_Mag"
				};
				class Components: Components
				{
					class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft
					{
						class Components
						{
							class EmptyDisplay
							{
								componentType="EmptyDisplayComponent";
							};
							class MinimapDisplay
							{
								componentType="MinimapDisplayComponent";
								resource="RscCustomInfoMiniMap";
							};
							class UAVDisplay
							{
								componentType="UAVFeedDisplayComponent";
							};
							class SensorDisplay
							{
								componentType="SensorsDisplayComponent";
								range[]={16000,8000,4000,2000};
								resource="RscCustomInfoSensors";
							};
						};
					};
					class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight
					{
						defaultDisplay="SensorDisplay";
						class Components
						{
							class EmptyDisplay
							{
								componentType="EmptyDisplayComponent";
							};
							class MinimapDisplay
							{
								componentType="MinimapDisplayComponent";
								resource="RscCustomInfoMiniMap";
							};
							class UAVDisplay
							{
								componentType="UAVFeedDisplayComponent";
							};
							class SensorDisplay
							{
								componentType="SensorsDisplayComponent";
								range[]={16000,8000,4000,2000};
								resource="RscCustomInfoSensors";
							};
						};
					};
				};
			};
		};
		class AttributeValues
		{
			RadarUsageAI=1;
		};
	};
	class ak603_O: ak603_base_F
	{
		author="Sam";
		picture="\ak603\textures\preview_ak630.jpg";
		uiPicture="\ak603\textures\preview_ak630.jpg";
		icon="\A3\Static_F_Jets\AAA_system_01\Data\UI\AAA_system_01_icon_CA.paa";
		editorPreview = "\ak603\textures\preview_ak630.jpg";
		_generalMacro="ak603_O";
		scope=2;
		scopeCurator = 2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		displayName="AK603M2 Duet";
		accuracy=0.5;
		textureList[]=
		{
			"Indep",
			1
		};
	};
	
	class ak603_B: ak603_O
	{
		author="Sam";
		picture="\ak603\textures\preview_ak630.jpg";
		uiPicture="\ak603\textures\preview_ak630.jpg";
		icon="\A3\Static_F_Jets\AAA_system_01\Data\UI\AAA_system_01_icon_CA.paa";
		editorPreview = "\ak603\textures\preview_ak630.jpg";
		_generalMacro="ak603_B";
		scope=2;
		scopeCurator = 2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		displayName="AK603M2 Duet";
		accuracy=0.5;
		textureList[]=
		{
			"Indep",
			1
		};
	};
};


class CfgFunctions
{
	class AK603
	{
		class AK603_functions
		{
            file = "\ak603\functions";

			class handleConnect { postInit = 1; };
			class drawHud {};
			class onExit {};
		};
	};
};