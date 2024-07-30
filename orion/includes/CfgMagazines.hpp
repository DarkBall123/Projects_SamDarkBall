class CfgMagazines
{
	class PylonMissile_1Rnd_Mk82_F;
	class 4Rnd_120mm_cannon_missiles;
	class Kornet_D_Magazine : 4Rnd_120mm_cannon_missiles 
	{
		author = "SAM";
		scope = 2;
		displayName = "$STR_orion_KornetD";
		displayNameShort = "";
		count = 1;
		model = "\orion\kornet\kornet_Rack.p3d";
		hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
		ammo = "Kornet_D_Ammo";
		initspeed = 120;
		maxLeadSpeed = 27.7778;	// max estimated speed km/h
		nameSound = "missiles";
		pylonWeapon = "KornetD_Weapon";
	};
	
	class KAB50_Magazine : PylonMissile_1Rnd_Mk82_F 
	{
		author = "SAM";
		scope = 2;
		displayName = "$STR_orion_KAB50";
		model = "\orion\kab50\kab_Rack.p3d";
		ammo = "SAM_KAB50_Ammo";
		hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
		initSpeed = 0;
		maxLeadSpeed = 300;	// max estimated speed km/h
		mass = 100;
		count = 1;
		nameSound = "cannon";
		pylonWeapon = "SAM_KAB50_Launcher";
	};	
	class KAB20_Magazine : PylonMissile_1Rnd_Mk82_F 
	{
		author = "SAM";
		scope = 2;
		displayName = "$STR_orion_KAB20";
		model = "\orion\kab20\KAB20_RACK.p3d";
		ammo = "SAM_KAB20_Ammo";
		hardpoints[] = {"DB_O_BOMB_PYLON", "DB_O_MISSILE_PYLON", "DB_UNI_SCALPEL"};
		initSpeed = 0;
		maxLeadSpeed = 300;	// max estimated speed km/h
		mass = 100;
		count = 3;
		nameSound = "cannon";
		pylonWeapon = "SAM_KAB20_Launcher";
	};
};