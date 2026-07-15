#include "BIS_AddonInfo.hpp"

class CfgPatches {
    class Lifeline_Revive {
        name = "Lifeline Revive Pair";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.18;
        requiredAddons[] = {
            "cba_xeh",
            "ace_medical",
            "ace_medical_ai",
            "ace_medical_blood",
            "ace_medical_treatment"
        };
        author = "Bendy / DarkBall";
        version = "2.1.0";
    };
};

class Extended_PostInit_EventHandlers {
    class Lifeline_Revive {
        init = "call compile preprocessFileLineNumbers '\Lifeline_Revive\XEH_postInit.sqf'";
    };
};
