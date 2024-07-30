class cfgammo
{
	class M_Titan_AT;
	class m_orlan_dummy: M_Titan_AT
	{
		modelspecial="\orlan\orlan.p3d";
		model="\orlan\orlan.p3d";
		soundFly[]=
		{
			"",
			0.13095701,
			1
		};
		effectsMissile="EmptyEffect";
		effectsMissileInit="";
		effectsSmoke="";
		muzzleEffect="";
		hit=5500;
		indirectHit=5500;
		indirectHitRange=20;
		manualControl=0;
		timeToLive=1800;
		flightProfiles[]=
		{
			"TopDown"
		};
		submunitionAmmo="";
		submunitionInitSpeed=1250;
		orlan_speedArray[]={75,43,7,1000,1};
	};
};