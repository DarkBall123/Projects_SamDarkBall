class CfgWeapons 
{
	class MissileLauncher; 
	class KornetD_Weapon : MissileLauncher 
	{
		canlock = LockCadet;
		cursoraim = "";
		scope = 2;
		weaponLockSystem = 1;
		holdsterAnimValue = 1;
		displayName = "$STR_orion_KornetD";
		sounds[] = {"StandardSound"};
		class StandardSound 
		{
				begin1[] = {"A3\Sounds_F_EPC\Weapons\missile_epc_1", 1.77828, 1, 3500};
				soundBegin[] = {"begin1", 1};
		};
		magazines[] = {"Kornet_D_Magazine"};
		airateoffire = 4;	// delay between shots at given distance
		airateoffiredistance = 700;
		maxrange = 6000;
		maxrangeprobab = 0.87;
		midrange = 2700;
		midrangeprobab = 0.95;
		minrange = 400;
		minrangeprobab = 0.65;
		reloadtime = 1;
		textureType = "fullAuto";
	};
	class GBU12BombLauncher;
	class SAM_KAB50_Launcher : GBU12BombLauncher
	{
		scope = 2;
		holdsterAnimValue = 1;
		displayName = "$STR_orion_KAB50";
		displayNameMagazine = "$STR_orion_KAB50";
		shortNameMagazine = "$STR_orion_KAB50";
		initspeed = 10;
		magazineReloadTime = 0.1;
		reloadTime = 0.500000;
		aiRateOfFire = 4.0;
		aiRateOfFireDistance = 500;
		minRange = 100;
		minRangeProbab = 0.04;
		midRange = 1000;
		midRangeProbab = 0.85;
		maxRange = 4000;
		maxRangeProbab = 0.55;
		maxLeadSpeed = 2500;
		magazines[] = {"KAB50_Magazine"};
	};	
	class SAM_KAB20_Launcher : SAM_KAB50_Launcher
	{
		scope = 2;
		holdsterAnimValue = 1;
		displayName = "$STR_orion_KAB20";
		displayNameMagazine = "$STR_orion_KAB20";
		shortNameMagazine = "$STR_orion_KAB20";
		initspeed = 10;
		magazines[] = {"KAB20_Magazine"};
	};

	class Laserdesignator_mounted;
	class Orion_Laserdesignator_mounted : Laserdesignator_mounted
	{
		displayName = "$STR_orion_Laser";
	};
};