class CfgFunctions
{
    class DB
    {
        class CharCreator
        {
            file = "\db_charcreator\functions";

            // Entry / lifecycle
            class cc_open  {};
            class cc_close {};

            // Data model + enumeration
            class cc_buildAttributeModel {};
            class cc_enumConfig          {};

            // UI
            class cc_buildUI    {};
            class cc_cycle      {};
            class cc_apply      {};
            class cc_refreshRow {};

            // Camera / preview
            class cc_setupCamera   {};
            class cc_orbitPFH      {};
            class cc_preparePlayer {};
            class cc_restorePlayer {};
        };
    };
};
