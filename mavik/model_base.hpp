	class mavik3: Default
	{
		skeletonName="mavik3_skeleton";
		sectionsInherit = "";
		sections[]=
		{
			"damage",
			"camo",
			"optic_glass",
			"hull",
			"trup",
			"engine",
			"motor",
			"wing",
			"rear",
			"propeller",
			"rudder"
		};

		class Animations
		{
			class damagehide
			{
				type="hide";
				source="damage";
				selection="damagehide";
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 1.0;
			};
			class rotorimpacthide
			{
				type="hide";
				source="rotorhfullydestroyed";
				selection="main rotor";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 1;
			};
			class tailrotorimpacthide
			{
				type="hide";
				source="tailrotorhfullydestroyed";
				selection="tail rotor";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 1;
			};
			class propeller1_rotation
			{
				type="rotation";
				source="rotorh";
				selection="propeller1";
				axis="propeller1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 6.2831855;//rad 360.0;
				angle1 = -6.2831855;//rad -360.0;
			};
			class propeller2_rotation
			{
				type="rotation";
				source="rotorv";
				selection="propeller2";
				axis="propeller2_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = -6.2831855;//rad -360.0;
				angle1 = 6.2831855;//rad 360.0;
			};

			class propeller3_rotation:propeller2_rotation
			{
				selection="propeller3";
				axis="propeller3_axis";//*probably*
			};

			class propeller4_rotation:propeller1_rotation
			{
				selection="propeller4";
				axis="propeller4_axis";//*probably*
			};

			class prop_static_UAV
			{
				type="hide";
				source="mainRotorRPMRTD";
				selection="propeller1_static";
				sourceAddress="clamp";
                minValue=0;
                maxValue=1;
                //unHideValue=0.1;
                hideValue=1;
			};
			class prop2_static_UAV:prop_static_UAV {selection="propeller2_static";};
			class prop3_static_UAV:prop_static_UAV {selection="propeller3_static";};
			class prop4_static_UAV:prop_static_UAV {selection="propeller4_static";};

			class prop_blur_UAV:prop_static_UAV
			{
				selection="propeller1_blur";
				hideValue=0;
				unHideValue=1;
			};
			class prop2_blur_UAV:prop_blur_UAV {selection="propeller2_blur";};
			class prop3_blur_UAV:prop_blur_UAV {selection="propeller3_blur";};
			class prop4_blur_UAV:prop_blur_UAV {selection="propeller4_blur";};


			class pilotTurret
			{
				type="rotation";
				source="pilotcamerarotx";
				selection="turret";
				axis="turret_axis";//*probably*
//				sourceAddress = clamp;// (default)
				// minValue = -1;
				// maxValue = 1;
				minValue = "(rad -360)";
				maxValue = "(rad 360)";
				angle0="(rad 360)";
				angle1="(rad -360)";
			};
			class pilotTurret2:pilotTurret
			{
				selection="turret2";
				//source="pilotTurret2";
				axis="turret2_axis";//*probably*
				minValue = "(rad -90)";
				maxValue = "(rad 90)";
				angle0="(rad 18)";
				angle1="(rad -18)";//18 degree
			};
			class pilotTurret3:pilotTurret2
			{
				selection="turret3";
				//source="pilotTurret3";
				axis="turret3_axis";//*probably*
				sourceAddress = mirror;
				minValue = 0;
				angle0=0;
				angle1="(rad 18)";
			};

			class pilotgun
			{
				type="rotation";
				source="pilotcameraroty";
				selection="flir";
				axis="flir_axis";//*probably*
				minValue = "(rad -360)";
				maxValue = "(rad 360)";
				angle0="(rad -360)";
				angle1="(rad 360)";
			};
		};//</Animations>
	};