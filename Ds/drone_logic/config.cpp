class CfgPatches {
    class MyDroneMod_Main {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"A3_Characters_F"}; // Убедитесь, что основные аддоны игры загружены
    };
};

class CfgFunctions {
    class MY_MOD {
        class DroneLogic {
            class init {
                file = "drone_logic\init_drones.sqf";
                postInit = 1;
            };
        };
    };
};
