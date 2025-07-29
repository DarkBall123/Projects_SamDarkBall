class CfgFunctions
{
	class DB_vnd
	{
		tag = "DB_vnd";
		class FPV
		{
			file = "\vnd_main\functions";
			// UI
            class fpv_createDialog {};
            class fpv_destroyUI  {};
            class fpv_uiAnimate  {};

            // Logic
            class fpv_handleConnect { postInit = 1; };
            class fpv_droneInit   {};
            class fpv_onDestroy   {};

            // Fiber (network + render)
            class fpv_updateFiberPath  {};
            class fpv_syncPath         {};
            class fpv_receivePath      {};
			class fpv_fiberTick 	   {};
            class fpv_renderAllFibers  { postInit = 1; };
            class fpv_drawFiberPath    {};
            class fpv_applyGravity {};
		};
	};
};