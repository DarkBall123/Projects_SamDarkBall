class CfgPatches
{
	class lk_shahed
	{
		addonRootClass="A3_Drones_F";
		requiredAddons[]=
		{
			"A3_Drones_F"
		};
		requiredVersion=0.1;
		units[]=
		{
			"Lk_geran2",
			"Lk_shahed136",
			"Lk_shahed136_t",
			"Lk_geran2_BLU",
			"Lk_shahed136_BLU",
			"Lk_shahed136_t_BLU",
			"Lk_geran2_IND",
			"Lk_shahed136_IND",
			"Lk_shahed136_t_IND",
			"lk_shahed_launcher_truck_r",
			"lk_shahed_launcher_truck_csat",
			"lk_shahed_launcher_truck_csat_t",
			"lk_shahed_launcher_truck_r_blufor",
			"lk_shahed_launcher_truck_blufor",
			"lk_shahed_launcher_truck_blufor_t",
			"lk_shahed_launcher_truck_r_ind",
			"lk_shahed_launcher_truck_ind",
			"lk_shahed_launcher_truck_ind_t",
			"lk_O_R_soldier_uav_F",
			"LK_B_R_soldier_UAV_F",
			"LK_I_R_soldier_UAV_F"
		};
		weapons[]={};
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
class cfgammo
{
	class SatchelCharge_Remote_Ammo_Scripted;
	class lk_shahed_dummy: SatchelCharge_Remote_Ammo_Scripted
	{
		hit=15000;
		indirecthit=15000;
		indirectHitRange=12;
	};
	class bo_mk82;
	class lk_shahed_dummy_bomb: bo_mk82
	{
		hit=15000;
		indirecthit=15000;
		indirectHitRange=12;
	};
};
class CfgWeapons
{
	class Default;
	class InventoryItem_Base_F;
	class ItemCore: Default
	{
	};
	class CBA_MiscItem_ItemInfo: InventoryItem_Base_F
	{
	};
	class CBA_MiscItem: ItemCore
	{
		class ItemInfo: CBA_MiscItem_ItemInfo
		{
		};
	};
	class fakeWeapon;
	class GeranLaunchWeapon: fakeWeapon
	{
		class GunParticles
		{
			class FirstEffect
			{
				directionName="konec hlavne";
				effectName="MLRSFired";
				positionName="usti hlavne";
			};
		};
		class BaseSoundModeType
		{
			closure1[]=
			{
				"A3\Sounds_F\arsenal\explosives\shells\ShellLightA_closeExp_03",
				0.40000001,
				1,
				10
			};
			soundClosure[]=
			{
				"closure1",
				1
			};
		};
		class StandardSound
		{
			begin1[]=
			{
				"A3\Sounds_F\arsenal\explosives\shells\ShellLightA_closeExp_03",
				0.40000001,
				1,
				200
			};
			begin2[]=
			{
				"A3\Sounds_F\arsenal\explosives\shells\ShellLightA_closeExp_03",
				0.40000001,
				1,
				200
			};
			closure1[]=
			{
				"A3\Sounds_F\arsenal\explosives\shells\ShellLightA_closeExp_03",
				0.40000001,
				1,
				10
			};
			soundBegin[]=
			{
				"begin1",
				0.5,
				"begin2",
				0.5
			};
			soundClosure[]=
			{
				"closure1",
				1
			};
			soundSetShot[]=
			{
				"Launcher_Titan_Shot_SoundSet",
				"Launcher_Titan_Shot_SoundSet",
				"Launcher_Titan_Tail_SoundSet"
			};
		};
		magazineReloadTime=4;
		reloadTime=4;
	};
};
class CfgVehicles
{
	class O_R_JTAC_F;
	class B_T_Recon_JTAC_F;
	class I_soldier_UAV_F;
	class LK_O_R_soldier_UAV_F: O_R_JTAC_F
	{
		scope=1;
		scopeCurator=1;
		displayName="$STR_A3_B_Soldier_UAV_F0";
		linkedItems[]=
		{
			"V_TacVest_camo",
			"H_HelmetAggressor_cover_taiga_F",
			"O_UavTerminal",
			"DefaultManLinkedItems",
			"O_NVGoggles_grn_F"
		};
		respawnLinkedItems[]=
		{
			"V_TacVest_camo",
			"H_HelmetAggressor_cover_taiga_F",
			"O_UavTerminal",
			"DefaultManLinkedItems",
			"O_NVGoggles_grn_F"
		};
		uavHacker="true";
		cost=150000;
		role="SpecialOperative";
	};
	class LK_B_R_soldier_UAV_F: B_T_Recon_JTAC_F
	{
		scope=1;
		scopeCurator=1;
		displayName="$STR_A3_B_Soldier_UAV_F0";
		linkedItems[]=
		{
			"V_TacVest_camo",
			"H_HelmetAggressor_cover_taiga_F",
			"B_UavTerminal",
			"DefaultManLinkedItems",
			"O_NVGoggles_grn_F"
		};
		respawnLinkedItems[]=
		{
			"V_TacVest_camo",
			"H_HelmetAggressor_cover_taiga_F",
			"B_UavTerminal",
			"DefaultManLinkedItems",
			"O_NVGoggles_grn_F"
		};
		uavHacker="true";
		cost=150000;
		role="SpecialOperative";
	};
	class LK_I_R_soldier_UAV_F: I_soldier_UAV_F
	{
		scope=1;
		scopeCurator=1;
		displayName="$STR_A3_B_Soldier_UAV_F0";
		linkedItems[]=
		{
			"V_TacVest_camo",
			"H_HelmetAggressor_cover_taiga_F",
			"I_UavTerminal",
			"DefaultManLinkedItems",
			"O_NVGoggles_grn_F"
		};
		respawnLinkedItems[]=
		{
			"V_TacVest_camo",
			"H_HelmetAggressor_cover_taiga_F",
			"I_UavTerminal",
			"DefaultManLinkedItems",
			"O_NVGoggles_grn_F"
		};
		uavHacker="true";
		cost=150000;
		role="SpecialOperative";
	};
	class All
	{
	};
	class AllVehicles: All
	{
		class NewTurret
		{
		};
	};
	class Air: AllVehicles
	{
		class Components
		{
		};
	};
	class Plane: Air
	{
	};
	class UAV: Plane
	{
		class NewTurret;
		class ViewPilot;
		class ViewOptics;
		class AnimationSources;
		class Components;
		class Sounds
		{
			class EngineHighIn
			{
			};
			class EngineHighOut
			{
			};
			class EngineLowIn
			{
			};
			class EngineLowOut
			{
			};
			class ForsageIn
			{
			};
			class ForsageOut
			{
			};
			class WindNoiseIn
			{
			};
			class WindNoiseOut
			{
			};
		};
	};
	class shahed_base_F: UAV
	{
		features="Randomization: No						<br />Camo selections: 1 - the whole body						<br />Script door sources: None						<br />Script animations: None						<br />Executed scripts: None						<br />Firing from vehicles: No						<br />Slingload: Slingloadable						<br />Cargo proxy indexes: None";
		author="The Virtual Ordnance";
		_generalMacro="UAV_02_base_F";
		displayName="$STR_A3_CfgVehicles_UAV_02_base0";
		editorSubcategory="EdSubcat_Drones";
		icon="\A3\Drones_F\Air_F_Gamma\UAV_02\Data\UI\Map_UAV_02_CA.paa";
		picture="\A3\Drones_F\Air_F_Gamma\UAV_02\Data\UI\UAV_02_base_F.paa";
		unitInfoType="RscOptics_AV_airplane_pilot";
		attenuationEffectType="OpenHeliAttenuation";
		soundGetIn[]=
		{
			"",
			0.56234133,
			1
		};
		soundGetOut[]=
		{
			"",
			0.56234133,
			1,
			40
		};
		soundDammage[]=
		{
			"",
			0.56234133,
			1
		};
		soundLocked[]=
		{
			"\A3\Sounds_F\weapons\Rockets\opfor_lock_1",
			1,
			1
		};
		soundIncommingMissile[]=
		{
			"\A3\Sounds_F\vehicles\air\noises\alarm_locked_by_missile_5",
			0.39810717,
			1
		};
		soundEngineOnInt[]=
		{
			"A3\Sounds_F\air\UAV_02\UAV_02_start_ext",
			0.70794576,
			1
		};
		soundEngineOnExt[]=
		{
			"A3\Sounds_F\air\UAV_02\UAV_02_start_int",
			0.70794576,
			1,
			400
		};
		soundEngineOffInt[]=
		{
			"A3\Sounds_F\air\UAV_02\UAV_02_stop_int",
			0.70794576,
			1
		};
		soundEngineOffExt[]=
		{
			"A3\Sounds_F\air\UAV_02\UAV_02_stop_ext",
			0.70794576,
			1,
			400
		};
		soundGearUp[]=
		{
			"A3\Sounds_F\vehicles\air\noises\drone_gear_up",
			1,
			1,
			120
		};
		soundGearDown[]=
		{
			"A3\Sounds_F\vehicles\air\noises\drone_gear_down",
			1,
			1,
			120
		};
		soundFlapsUp[]=
		{
			"A3\Sounds_F_EPC\CAS_01\Flaps_Up",
			0.63095737,
			1,
			100
		};
		soundFlapsDown[]=
		{
			"A3\Sounds_F_EPC\CAS_01\Flaps_Down",
			0.63095737,
			1,
			100
		};
		soundBushCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",
			1,
			1,
			100
		};
		soundBushCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",
			1,
			1,
			100
		};
		soundBushCollision3[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",
			1,
			1,
			100
		};
		soundBushCrash[]=
		{
			"soundBushCollision1",
			0.33000001,
			"soundBushCollision2",
			0.33000001,
			"soundBushCollision3",
			0.33000001
		};
		soundWaterCollision1[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",
			1,
			1,
			100
		};
		soundWaterCollision2[]=
		{
			"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",
			1,
			1,
			100
		};
		soundWaterCrashes[]=
		{
			"soundWaterCollision1",
			0.5,
			"soundWaterCollision2",
			0.5
		};
		Crash0[]=
		{
			"A3\sounds_f\weapons\Explosion\expl_big_2.wss",
			1.7782794,
			1,
			3000
		};
		Crash1[]=
		{
			"A3\sounds_f\weapons\Explosion\expl_big_2.wss",
			1.7782794,
			1,
			3000
		};
		Crash2[]=
		{
			"A3\sounds_f\weapons\Explosion\expl_big_2.wss",
			1.7782794,
			1,
			3000
		};
		Crash3[]=
		{
			"A3\sounds_f\weapons\Explosion\expl_big_2.wss",
			1.7782794,
			1,
			3000
		};
		soundCrashes[]=
		{
			"Crash0",
			0.25,
			"Crash1",
			0.25,
			"Crash2",
			0.25,
			"Crash3",
			0.25
		};
		class Sounds: Sounds
		{
			class EngineHighIn: EngineHighIn
			{
				frequency="(rpm factor[0.5, 1.0])";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					1,
					1
				};
				volume="(1-camPos)*(rpm factor[0.2, 1.0])";
			};
			class EngineHighOut: EngineHighOut
			{
				frequency="(rpm factor[0.5, 1.0])";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					2.5118899,
					1,
					3000
				};
				volume="camPos*4*(rpm factor[0.5, 1.1])*(rpm factor[1.1, 0.5])";
			};
			class EngineLowIn: EngineLowIn
			{
				frequency="1.0 min (rpm + 0.5)";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					1,
					1
				};
				volume="(1-camPos)*(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			class EngineLowOut: EngineLowOut
			{
				frequency="1.0 min (rpm + 0.5)";
				sound[]=
				{
					"lk_shahed\Sound\engine.ogg",
					2.5118899,
					1,
					300
				};
				volume="camPos2(rpm factor[0.95, 0])*(rpm factor[0, 0.95])";
			};
			class ForsageIn: ForsageIn
			{
				frequency="1";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					0.63095701,
					1
				};
				volume="engineOn*(1-camPos)*(thrust factor[0.6, 1.0])";
			};
			class ForsageOut: ForsageOut
			{
				cone[]={3.1400001,3.9200001,2,0.5};
				frequency="1";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					2,
					1,
					3000
				};
				volume="engineOn*camPos*(thrust factor[0.5, 1.0])";
			};
			class WindNoiseIn: WindNoiseIn
			{
				frequency="(0.3+(1.005*(speed factor[1, 50])))";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					0.25118899,
					1
				};
				volume="(1-camPos)*(speed factor[1, 50])";
			};
			class WindNoiseOut: WindNoiseOut
			{
				frequency="(0.3+(1.005*(speed factor[1, 50])))";
				sound[]=
				{
					"A3\Sounds_f_kart\vehicles\soft\Kart_01\engine_rpm6.wss",
					1.77,
					1,
					500
				};
				volume="camPos*(speed factor[1,  50])";
			};
		};
		memoryPointTaskMarker="TaskMarker_1_pos";
		slingLoadCargoMemoryPoints[]=
		{
			"SlingLoadCargo1",
			"SlingLoadCargo2",
			"SlingLoadCargo3",
			"SlingLoadCargo4"
		};
		formationX=30;
		formationZ=30;
		class HitPoints
		{
			class HitHull
			{
				armor=3;
				explosionShielding=5;
				name="HitHull";
				passThrough=0.5;
				visual="Hit_Hull";
				radius=0.25;
				minimalHit=0.02;
				depends="Total";
				material=-1;
			};
			class HitEngine: HitHull
			{
				armor=1.5;
				explosionShielding=2;
				name="HitEngine";
				passThrough=0.5;
				visual="Hit_Engine";
				radius=0.25;
				minimalHit=0.1;
				depends="0";
			};
			class HitFuel: HitHull
			{
				armor=3;
				explosionShielding=4;
				name="HitFuel";
				passThrough=0.5;
				visual="Hit_Fuel";
				radius=0.30000001;
				minimalHit=0.1;
				depends="0";
			};
			class HitLAileron: HitHull
			{
				armor=1.5;
				explosionShielding=3;
				name="HitLAileron";
				passThrough=0.1;
				visual="Hit_AileronL";
				radius=0.2;
				minimalHit=0.1;
				depends="0";
			};
			class HitRAileron: HitLAileron
			{
				armor=1.5;
				explosionShielding=3;
				name="HitRAileron";
				passThrough=0.1;
				visual="Hit_AileronR";
				radius=0.2;
				minimalHit=0.1;
				depends="0";
			};
			class HitLCRudder: HitHull
			{
				armor=1.5;
				explosionShielding=3;
				name="HitLCRudder";
				passThrough=0.1;
				visual="Hit_RudderL";
				radius=0.15000001;
				minimalHit=0.1;
				depends="0";
			};
			class HitRRudder: HitLCRudder
			{
				armor=1.5;
				explosionShielding=3;
				name="HitRRudder";
				passThrough=0.1;
				visual="Hit_RudderR";
				radius=0.15000001;
				minimalHit=0.1;
				depends="0";
			};
			class HitLCElevator: HitHull
			{
				armor=1.5;
				explosionShielding=3;
				name="HitLCElevator";
				passThrough=0.1;
				visual="Hit_ElevatorL";
				radius=0.2;
				minimalHit=0.1;
				depends="0";
			};
			class HitRElevator: HitLCElevator
			{
				armor=1.5;
				explosionShielding=3;
				name="HitRElevator";
				passThrough=0.1;
				visual="Hit_ElevatorR";
				radius=0.2;
				minimalHit=0.1;
				depends="0";
			};
		};
		class Exhausts
		{
			class Exhaust_center
			{
				position="pos_Exhausts_start_center";
				direction="pos_Exhausts_end_center";
				effect="ExhaustsEffectHeliComHP";
			};
		};
		class Armory
		{
			description="$STR_A3_CfgVehicles_UAV_02_base_Armory0";
		};
		model="\lk_shahed\geran.p3d";
		driveOnComponent[]={};
		maximumLoad=250;
		class TransportItems
		{
		};
		uavCameraDriverPos="";
		uavCameraDriverDir="";
		LODTurnedIn=-1;
		LODTurnedOut=-1;
		memoryPointLDust="DustLeft";
		memoryPointRDust="DustRight";
		memoryPointDriverOptics="PiP0_pos";
		driverOpticsModel="A3\drones_f\Weapons_F_Gamma\Reticle\UGV_01_Optics_Driver_F.p3d";
		driverForceOptics=1;
		getInRadius=0;
		destrType="DestructWreck";
		class WingVortices
		{
		};
		class ViewPilot: ViewPilot
		{
			minFov=0.25;
			maxFov=1.25;
			initFov=0.75;
			initAngleX=0;
			minAngleX=-65;
			maxAngleX=85;
			initAngleY=0;
			minAngleY=-150;
			maxAngleY=150;
		};
		class Viewoptics: ViewOptics
		{
			initAngleX=0;
			minAngleX=0;
			maxAngleX=0;
			initAngleY=0;
			minAngleY=0;
			maxAngleY=0;
			minFov=0.25;
			maxFov=1.25;
			initFov=0.75;
			visionMode[]=
			{
				"Normal",
				"NVG"
			};
			thermalMode[]={0,1};
		};
		class AnimationSources: AnimationSources
		{
			class Bombs
			{
				source="user";
				animPeriod=1e-006;
				initPhase=0;
			};
			class AT_missiles
			{
				source="user";
				animPeriod=0.99000001;
				initPhase=1;
			};
			class Damper_1_source
			{
				source="damper";
				wheel="Wheel_1";
			};
			class Damper_2_source
			{
				source="damper";
				wheel="Wheel_2";
			};
			class Damper_3_source
			{
				source="damper";
				wheel="Wheel_3";
			};
			class Wheel_1_source
			{
				source="wheel";
				wheel="Wheel_1";
			};
			class Wheel_2_source
			{
				source="wheel";
				wheel="Wheel_2";
			};
			class Wheel_3_source
			{
				source="wheel";
				wheel="Wheel_3";
			};
		};
		class camShakeGForce
		{
			distance=0;
			frequency=2;
			minSpeed=1;
			power=0.1;
		};
		weapons[]={};
		magazines[]={};
		maxSpeed=400;
		landingAoa=0.1309;
		landingSpeed=140;
		stallSpeed=100;
		stallWarningTreshold=0.07;
		wheelSteeringSensitivity=1.3;
		airBrake=1;
		airBrakeFrictionCoef=2;
		flaps=1;
		flapsFrictionCoef=0.2;
		gearsUpFrictionCoef=0.34999999;
		airFrictionCoefs0[]={0,0,0};
		airFrictionCoefs1[]={0.1,0.69999999,0.0049999999};
		airFrictionCoefs2[]={0.001,0.0074999998,5.9999998e-005};
		angleOfIndicence=0;
		envelope[]={0,0.07,0.25999999,0.58999997,1.04,1.63,1.98,2.7,3.2,4.0500002,4.6799998,5.4899998,6.1900001,7.04,7.5300002,7.9000001,8.1999998,8.3999996,8.5,8.1999998,7};
		altNoForce=13000;
		altFullForce=2000;
		thrustCoef[]={1.36,1.25,1.14,1.04,0.94999999,0.86000001,0.77999997,0.69999999,0.61000001,0.30000001,0,0,0};
		aileronSensitivity=0.60000002;
		aileronCoef[]={0,0.12,0.46000001,0.64999998,0.75,0.81999999,0.88,0.92000002,0.94999999,0.97000003,0.99000001,1,1.01};
		elevatorSensitivity=0.69999999;
		elevatorCoef[]={0,0.2,0.69999999,0.47,0.38,0.31999999,0.28,0.25,0.22,0.19,0.17,0.15000001,0.13};
		rudderInfluence=0.93970001;
		rudderCoef[]={0,0.60000002,1.2,1.5,1.7,1.8,1.9,1.9,2,2,2,1.8,1.4};
		aileronControlsSensitivityCoef=3;
		elevatorControlsSensitivityCoef=3;
		rudderControlsSensitivityCoef=3;
		draconicForceXCoef=8;
		draconicForceYCoef=1.1;
		draconicForceZCoef=1;
		draconicTorqueXCoef[]={2,2.5,3.0999999,3.7,4.4000001,5.0999999,5.9000001,6.5,7,7.5,7.9000001,8.3000002,8.5};
		draconicTorqueYCoef[]={12,8,3,0.5,0,0,0,0,0,0,0,0,0};
		maxOmega=3000;
		engineMoi=0.1;
		dampingRateFullThrottle=0.029999999;
		dampingRateZeroThrottleClutchEngaged=0.029999999;
		dampingRateZeroThrottleClutchDisengaged=0.029999999;
		killFriendlyExpCoef=0.0099999998;
		driverCompartments="Compartment3";
		cargoCompartments[]=
		{
			"Compartment2"
		};
		class Damage
		{
			tex[]={};
			mat[]=
			{
				"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_damage.rvmat",
				"A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_destruct.rvmat"
			};
		};
		hiddenSelections[]=
		{
			""
		};
		hiddenSelectionsTextures[]=
		{
			""
		};
		radarTargetSize=0.1;
		visualTargetSize=0.1;
		irTargetSize=0.1;
		lockDetectionSystem=0;
		incomingMissileDetectionSystem=0;
		laserscanner=1;
		showAllTargets=4;
		reportRemoteTargets=1;
		reportOwnPosition=1;
		class TextureSources
		{
			class Indep
			{
				displayName="$STR_A3_TEXTURESOURCES_INDEP0";
				author="$STR_A3_Bohemia_Interactive";
				textures[]=
				{
					"\A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_INDP_CO.paa"
				};
				factions[]=
				{
					"IND_F"
				};
			};
			class Opfor
			{
				displayName="$STR_A3_TEXTURESOURCES_OPFOR0";
				author="$STR_A3_Bohemia_Interactive";
				textures[]=
				{
					"\A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_OPFOR_CO.paa"
				};
				factions[]=
				{
					"OPF_F"
				};
			};
			class Blufor
			{
				displayName="$STR_A3_TEXTURESOURCES_BLU0";
				author="$STR_A3_Bohemia_Interactive";
				textures[]=
				{
					"\A3\Drones_F\Air_F_Gamma\UAV_02\Data\UAV_02_CO.paa"
				};
				factions[]=
				{
					"BLU_F"
				};
			};
		};
	};

	class lk_shahed136: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136";
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		accuracy=1;
		displayName="Shahed 136";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\shahed_hull_co.paa"
		};
	};
	class lk_geran2: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136";
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_R_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		accuracy=1;
		displayName="Geran 2";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\geran_hull_co.paa"
		};
	};
	class lk_shahed136_T: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136";
		scope=2;
		scopeCurator=2;
		side=0;
		faction="OPF_T_F";
		crew="O_UAV_AI";
		typicalCargo[]=
		{
			"O_UAV_AI"
		};
		accuracy=1;
		displayName="Shahed 136";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\shahed_hull_camo_co.paa"
		};
	};

	class lk_shahed136_BLU: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136_BLU";
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		accuracy=1;
		displayName="Shahed 136";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\shahed_hull_co.paa"
		};
	};
	class lk_geran2_BLU: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_geran2_BLU";
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		accuracy=1;
		displayName="Geran 2";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\geran_hull_co.paa"
		};
	};
	class lk_shahed136_T_BLU: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136_T_BLU";
		scope=2;
		scopeCurator=2;
		side=1;
		faction="BLU_F";
		crew="B_UAV_AI";
		typicalCargo[]=
		{
			"B_UAV_AI"
		};
		accuracy=1;
		displayName="Shahed 136";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\shahed_hull_camo_co.paa"
		};
	};

	class lk_shahed136_IND: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136_IND";
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		accuracy=1;
		displayName="Shahed 136";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\shahed_hull_co.paa"
		};
	};
	class lk_geran2_IND: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_geran2_IND";
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		accuracy=1;
		displayName="Geran 2";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\geran_hull_co.paa"
		};
	};
	class lk_shahed136_T_IND: shahed_base_F
	{
		author="The Virtual Ordnance";
		class SimpleObject
		{
			eden=0;
			animate[]=
			{
				
				{
					"propeller",
					0
				},
				
				{
					"propellerstatic",
					0
				},
				
				{
					"propellerblurred",
					0
				},
				
				{
					"mainturret",
					0
				},
				
				{
					"maingun",
					0
				},
				
				{
					"flap_1_1",
					0
				},
				
				{
					"flap_2_1",
					0
				},
				
				{
					"aileron_1_1",
					0
				},
				
				{
					"aileron_2_1",
					0
				},
				
				{
					"rudder_1_1",
					0
				},
				
				{
					"rudder_2_1",
					0
				},
				
				{
					"frontgear_1",
					0
				},
				
				{
					"frontgear_1_support",
					0
				},
				
				{
					"frontgear_1_door_l",
					0
				},
				
				{
					"frontgear_1_door_r",
					0
				},
				
				{
					"backgear_1_door_l",
					0
				},
				
				{
					"backgear_1_door_r",
					0
				},
				
				{
					"frontgearsteering",
					0
				},
				
				{
					"frontgeardamper",
					0
				},
				
				{
					"maingear_2_1",
					0
				},
				
				{
					"maingear_2_1_support",
					0
				},
				
				{
					"maingear_2_2_support",
					0
				},
				
				{
					"maingear_2_2",
					0
				},
				
				{
					"maingear_2_1_suspension",
					0
				},
				
				{
					"maingear_2_2_suspension",
					0
				},
				
				{
					"wheel_1_1",
					0
				},
				
				{
					"wheel_2_1",
					0
				},
				
				{
					"wheel_2_2",
					0
				},
				
				{
					"damagehide",
					0
				},
				
				{
					"missilea",
					0
				},
				
				{
					"missileb",
					0
				},
				
				{
					"missilea1",
					1
				},
				
				{
					"missilea2",
					1
				},
				
				{
					"missilea3",
					1
				},
				
				{
					"missileb1",
					1
				},
				
				{
					"missileb2",
					1
				},
				
				{
					"missileb3",
					1
				},
				
				{
					"positionlights",
					0
				},
				
				{
					"hideweapons",
					0
				}
			};
			hide[]=
			{
				"zasleh",
				"l svetlo",
				"zadni svetlo",
				"clan",
				"podsvit pristroju",
				"poskozeni"
			};
			verticalOffset=1.5930001;
			verticalOffsetWorld=0.025;
			init="''";
		};
		icon="lk_shahed\data\icon_ca.paa";
		_generalMacro="lk_shahed136_T_IND";
		scope=2;
		scopeCurator=2;
		side=2;
		faction="IND_F";
		crew="I_UAV_AI";
		typicalCargo[]=
		{
			"I_UAV_AI"
		};
		accuracy=1;
		displayName="Shahed 136";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"lk_shahed\data\shahed_hull_camo_co.paa"
		};
	};
	
	class Land: AllVehicles
	{
	};
	class LandVehicle: Land
	{
	};
	class Car_F: LandVehicle
	{
	};
	class Truck_F: Car_F
	{
		class AnimationSources;
		class EventHandlers;
	};
	class Truck_02_base_F: Truck_F
	{
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3"
		};
		class AnimationSources: AnimationSources
		{
			class spz_hide;
		};
	};
	class Truck_02_MRL_base_F: Truck_02_base_F
	{
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		class Turrets
		{
			class MainTurret: NewTurret
			{
			};
		};
		hiddenSelectionsTextures[]=
		{
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_kab_INDP_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\A3\Soft_F_Gamma\Truck_02\Data\Truck_02_MRL_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_chassis_INDP_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_base: Truck_02_MRL_base_F
	{
		author="The Virtual Ordnance";
		displayName="UAV Mobile Launcher";
		_generalMacro="lk_uav_mobile_launcher";
		scopecurator=1;
		scope=1;
		side=0;
		artilleryScanner=0;
		crew="o_soldier_uav_f";
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				gunnerOpticsModel="\A3\weapons_f\reticle\optics_empty";
				turretInfoType="RscOptics_Offroad_01";
				weapons[]=
				{
					"GeranLaunchWeapon"
				};
				magazines[]=
				{
					"fakeMagazine",
					"fakeMagazine",
					"fakeMagazine",
					"fakeMagazine",
					"fakeMagazine"
				};
				elevationMode=0;
				cameraDir="look";
				discreteDistanceCameraPoint[]=
				{
					"eye"
				};
			};
		};
	};
	class lk_shahed_launcher_truck_r: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Geran-2 Mobile Launcher";
		_generalMacro="lk_uav_mobile_launcher";
		scopecurator=2;
		scope=2;
		side=0;
		faction="OPF_R_F";
		artilleryScanner=0;
		crew="lk_O_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\lk_shahed\Data\Truck_02_kab_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_int_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_MRL_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_chassis_RUkhk_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_csat: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Shahed-136 Mobile Launcher";
		_generalMacro="lk_uav_mobile_launcher";
		scopecurator=2;
		scope=2;
		side=0;
		faction="Opf_F";
		artilleryScanner=0;
		crew="o_soldier_uav_f";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_kab_OPFOR_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\A3\Soft_F_Gamma\Truck_02\Data\Truck_02_MRL_OPFOR_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_chassis_OPFOR_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_csat_t: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Shahed-136 Mobile Launcher";
		_generalMacro="lk_uav_mobile_launcher";
		scopecurator=2;
		scope=2;
		side=0;
		faction="OPF_T_F";
		artilleryScanner=0;
		crew="O_T_Soldier_UAV_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\lk_shahed\Data\Truck_02_kab_ghex_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\lk_shahed\Data\Truck_02_MRL_ghex_CO.paa",
			"\lk_shahed\Data\Truck_02_chassis_ghex_CO.paa"
		};
	};

	class lk_shahed_launcher_truck_r_blufor: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Geran-2 Mobile Launcher";
		_generalMacro="lk_shahed_launcher_truck_r_blufor";
		scopecurator=2;
		scope=2;
		side=1;
		faction="BLU_F";
		artilleryScanner=0;
		crew="lk_B_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\lk_shahed\Data\Truck_02_kab_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_int_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_MRL_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_chassis_RUkhk_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_blufor: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Shahed-136 Mobile Launcher";
		_generalMacro="lk_shahed_launcher_truck_blufor";
		scopecurator=2;
		scope=2;
		side=1;
		faction="BLU_F";
		artilleryScanner=0;
		crew="lk_B_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_kab_OPFOR_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\A3\Soft_F_Gamma\Truck_02\Data\Truck_02_MRL_OPFOR_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_chassis_OPFOR_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_blufor_t: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Shahed-136 Mobile Launcher";
		_generalMacro="lk_shahed_launcher_truck_blufor_t";
		scopecurator=2;
		scope=2;
		side=1;
		faction="BLU_F";
		artilleryScanner=0;
		crew="lk_B_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\lk_shahed\Data\Truck_02_kab_ghex_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\lk_shahed\Data\Truck_02_MRL_ghex_CO.paa",
			"\lk_shahed\Data\Truck_02_chassis_ghex_CO.paa"
		};
	};

	class lk_shahed_launcher_truck_r_ind: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Geran-2 Mobile Launcher";
		_generalMacro="lk_shahed_launcher_truck_r_ind";
		scopecurator=2;
		scope=2;
		side=2;
		faction="IND_F";
		artilleryScanner=0;
		crew="lk_I_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\lk_shahed\Data\Truck_02_kab_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_int_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_MRL_RUkhk_CO.paa",
			"\lk_shahed\Data\Truck_02_chassis_RUkhk_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_ind: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Shahed-136 Mobile Launcher";
		_generalMacro="lk_shahed_launcher_truck_ind";
		scopecurator=2;
		scope=2;
		side=2;
		faction="IND_F";
		artilleryScanner=0;
		crew="lk_I_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_kab_OPFOR_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\A3\Soft_F_Gamma\Truck_02\Data\Truck_02_MRL_OPFOR_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_chassis_OPFOR_CO.paa"
		};
	};
	class lk_shahed_launcher_truck_ind_t: lk_shahed_launcher_truck_base
	{
		author="The Virtual Ordnance";
		displayName="Shahed-136 Mobile Launcher";
		_generalMacro="lk_shahed_launcher_truck_ind_t";
		scopecurator=2;
		scope=2;
		side=2;
		faction="IND_F";
		artilleryScanner=0;
		crew="lk_I_R_soldier_uav_F";
		hiddenSelections[]=
		{
			"camo1",
			"camo2",
			"camo3",
			"camo4"
		};
		hiddenSelectionsTextures[]=
		{
			"\lk_shahed\Data\Truck_02_kab_ghex_CO.paa",
			"\A3\Soft_F_Beta\Truck_02\Data\Truck_02_int_CO.paa",
			"\lk_shahed\Data\Truck_02_MRL_ghex_CO.paa",
			"\lk_shahed\Data\Truck_02_chassis_ghex_CO.paa"
		};
	};
};
class CfgFunctions
{
	class shahed
	{
		class init
		{
			file="lk_shahed\functions\init";
			class init_launcher_shahed
			{
			};
			class init_launcher_shahed_t
			{
			};
			class init_launcher_geran
			{
			};
			class init_Shahed
			{
			};
		};
		class scripts
		{
			file="lk_shahed\functions\scripts";
			class setAngleOfAttack
			{
			};
			class createammo
			{
			};
		};
	};
};
class Extended_InitPost_EventHandlers
{
	class lk_shahed136
	{
		class lk_shahed136_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};
	class lk_shahed136_t
	{
		class lk_shahed136_t_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};
	class lk_geran2
	{
		class lk_geran2_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};

	class lk_shahed136_BLU
	{
		class lk_shahed136_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};
	class lk_shahed136_t_BLU
	{
		class lk_shahed136_t_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};
	class lk_geran2_BLU
	{
		class lk_geran2_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};

	class lk_shahed136_IND
	{
		class lk_shahed136_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};
	class lk_shahed136_t_IND
	{
		class lk_shahed136_t_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};
	class lk_geran2_IND
	{
		class lk_geran2_initpost_eh
		{
			clientInit="_this call shahed_fnc_init_Shahed";
		};
	};

	class lk_shahed_launcher_truck_r
	{
		class lk_shahed_launcher_truck_r_initpost_eh
		{
			clientInit="[_this, ""lk_geran2""] call shahed_fnc_init_launcher_geran";
		};
	};
	class lk_shahed_launcher_truck_csat
	{
		class lk_shahed_launcher_truck_csat_initpost_eh
		{
			clientInit="[_this, ""lk_shahed136""] call shahed_fnc_init_launcher_shahed";
		};
	};
	class lk_shahed_launcher_truck_csat_t
	{
		class lk_shahed_launcher_truck_csat_t_initpost_eh
		{
			clientInit="[_this, ""lk_shahed136_t""] call shahed_fnc_init_launcher_shahed_t";
		};
	};

	class lk_shahed_launcher_truck_r_blufor
	{
		class lk_shahed_launcher_truck_r_initpost_eh
		{
			clientInit="[_this, ""lk_geran2_BLU""] call shahed_fnc_init_launcher_geran";
		};
	};
	class lk_shahed_launcher_truck_blufor
	{
		class lk_shahed_launcher_truck_csat_initpost_eh
		{
			clientInit="[_this, ""lk_shahed136_BLU""] call shahed_fnc_init_launcher_shahed";
		};
	};
	class lk_shahed_launcher_truck_blufor_t
	{
		class lk_shahed_launcher_truck_csat_t_initpost_eh
		{
			clientInit="[_this, ""lk_shahed136_t_BLU""] call shahed_fnc_init_launcher_shahed_t";
		};
	};

	class lk_shahed_launcher_truck_r_ind
	{
		class lk_shahed_launcher_truck_r_initpost_eh
		{
			clientInit="[_this, ""lk_geran2_IND""] call shahed_fnc_init_launcher_geran";
		};
	};
	class lk_shahed_launcher_truck_ind
	{
		class lk_shahed_launcher_truck_csat_initpost_eh
		{
			clientInit="[_this, ""lk_shahed136_IND""] call shahed_fnc_init_launcher_shahed";
		};
	};
	class lk_shahed_launcher_truck_ind_t
	{
		class lk_shahed_launcher_truck_csat_t_initpost_eh
		{
			clientInit="[_this, ""lk_shahed136_t_IND""] call shahed_fnc_init_launcher_shahed_t";
		};
	};
};