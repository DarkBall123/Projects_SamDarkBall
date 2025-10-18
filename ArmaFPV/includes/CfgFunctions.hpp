class CfgFunctions
{
        class DB
        {
                class FPV
                {
            file = "\ArmaFPV\functions";

                        class fpv_addDroneToInventory {};
                        class fpv_canDisassemble {};
                        class fpv_createDialog {};
                        class fpv_createDroneOnItemCheck {};
                        class fpv_destroyUI {};
                        class fpv_droneInit {};
                        class fpv_getControlledUAV {};
                        class fpv_getDroneClasses {};
                        class fpv_getOperator {};
                        class fpv_getSignal {};
                        class fpv_getTerminals {};
                        class fpv_handleBattery {};
                        class fpv_handleConnect { postInit = 1; };
                        class fpv_handleSettings {};
                        class fpv_handleSignal {};
                        class fpv_handleTime {};
                        class fpv_onDestroy {};
                        class fpv_onSignalLost {};
                        class fpv_selectGaugeTexture {};
                };
        };
};
