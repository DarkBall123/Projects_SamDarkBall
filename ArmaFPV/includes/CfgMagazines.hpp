class CfgMagazines
{
        class Laserbatteries;
        class Item_Crocus_AT: Laserbatteries
        {
                scope = 2;
                author = "DarkBall & Sam";
                displayName = "Crocus AT";
                descriptionShort = "Crocus FPV drone with anti-tank charge";
                model = "\ArmaFPV\drone.p3d";
                icon = "\ArmaFPV\data\drononmap.paa";
                picture = "\ArmaFPV\data\drononmap.paa";
                mass = 80;
                count = 1;
                ammo = "";
        };
        class Item_Crocus_AP: Item_Crocus_AT
        {
                displayName = "Crocus AP";
                descriptionShort = "Crocus FPV drone with anti-personnel charge";
        };
};
