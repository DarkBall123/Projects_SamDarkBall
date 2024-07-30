class CfgVehicleClasses
{
    class sania_podavitel
    {
        displayName="Podavitel";
    };

	class volnorez_podavitel : sania_podavitel
    {
        displayName="Podavitel";
    };
};
class CfgFactionClasses
{
        class sania_model
        {
               displayName = "sania";                        // Name based on the editor faction class.
               priority = 1;
               side = 2;                                              // Group association.
        };
};
class CfgVehicles
{
	class ThingX;	// External class reference
	class Sania_Base : ThingX
	{
		cost = 0;
		armor = 100;
		destrType = "DestructDefault";
		placement = vertical;
		mapSize = 3;

		class UserActions
		{
			class SwitchJammer
			{
				displayName="<t color='#ffca18'>Switch Mode</t>";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition="alive this";
				statement="[this] call DB_fnc_jammerSwitchMode";
			};
		};
	};

	class Sania : Sania_Base
    {
		picture = "\sania\pictures\preview_sania.jpg";
		editorPreview = "\sania\pictures\preview_sania.jpg";
		scope = 2;
		model = "sania\sania.p3d";
		displayName = "sania";

		class UserActions
		{
			class DisassembleJammer
			{
				displayName="Put in inventory";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition="this call DB_fnc_jammerCanDisassembly";
				statement="this call DB_fnc_addJammerToInventory";
			};

			class SwitchJammer
			{
				displayName="<t color='#ffca18'>Switch Mode</t>";
				priority=0.5;
				radius=7;
				position="";
				showWindow=0;
				onlyForPlayer=1;
				icon="";
				condition="alive this";
				statement= "this call DB_fnc_jammerSwitchMode";
			};
		};
    };
	class Sania_with_tripod : Sania_Base
    {
		picture = "\sania\pictures\preview_sania_tripod.jpg";
		editorPreview = "\sania\pictures\preview_sania_tripod.jpg";
		scope = 2;
		model = "sania\tripod.p3d";
		displayName = "Sania with tripod";
		vehicleClass = "sania_podavitel";
		faction = "sania";
    };

	class Volnorez_1 : Sania
    {
		picture = "\sania\pictures\preview_volnorez.jpg";
		editorPreview = "\sania\pictures\preview_volnorez.jpg";
		scope = 2;
		model = "sania\volnorez.p3d";
		displayName = "Volnorez Jammer";
		vehicleClass = "volnorez_podavitel";
		faction = "sania";
    };

	class B_Bergen_dgtl_F;
	class Sania_Bag: B_Bergen_dgtl_F
	{
	    displayName="Sania Jammer Bag";
		scope = 2;
	    class assembleInfo
	    {
	        assembleTo="Sania";
	        base="";
	        displayName="Sania Jammer";
	        dissasembleTo[]={};
	        primary=1;
	    };
	};

	class Volnorez_Bag: B_Bergen_dgtl_F
	{
	    displayName="Volnorez Jammer Bag";
		scope = 2;
	    class assembleInfo
	    {
	        assembleTo="Volnorez_1";
	        base="";
	        displayName="Volnorez Jammer";
	        dissasembleTo[]={};
	        primary=1;
	    };
	};

	class Box_EAF_Equip_F;
	class Sania_Crate: Box_EAF_Equip_F
	{
		displayName="Sania Crate";
		scope=2;
		scopeCurator=2;
		transportMaxWeapons=3;
		transportMaxItems=1;
		transportMaxMagazines=3;
		transportMaxBackpacks=3;
		class TransportBackpacks
		{
		   class _xx_Sania_Bag
		   {
		       backpack="Sania_Bag";
		       count=1;
		   };
		};
		class TransportMagazines
		{		
		};
		class TransportItems
		{
		};
		class TransportWeapons
		{		
		};
	};

	class Volnorez_Crate: Box_EAF_Equip_F
	{
		displayName="Volnorez Crate";
		scope=2;
		scopeCurator=2;
		transportMaxWeapons=3;
		transportMaxItems=1;
		transportMaxMagazines=3;
		transportMaxBackpacks=3;
		class TransportBackpacks
		{
		   class _xx_Volnorez_Bag
		   {
		       backpack="Volnorez_Bag";
		       count=1;
		   };
		};
		class TransportMagazines
		{		
		};
		class TransportItems
		{
		};
		class TransportWeapons
		{		
		};
	};
};