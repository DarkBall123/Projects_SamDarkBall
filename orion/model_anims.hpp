	class orion:Default
	{
		skeletonName="orion_skeleton";
		sections[]=
		{
			"camo_1",
			"zbytek",
			"hit_elevatorl",
			"hit_elevatorr",
			"hit_rudderl",
			"hit_rudderr",
			"hit_aileronl",
			"hit_aileronr",
			"hit_engine",
			"hit_fuel",
			"hit_hull"
		};

		class Animations
		{
			class propeller
			{
				type="rotation";
				source="rotor";
				selection="propeller";
				axis="propeller_axis";//*probably*
				sourceAddress = loop;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = 2.0943952;//rad 120.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class propellerstatic
			{
				type="hide";
				source="rpm";
				selection="propellerstatic";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class propellerblurred
			{
				type="hide";
				source="rpm";
				selection="propellerblurred";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 0.0;
				unHideValue = 0.5;
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class mainturret
			{
				type="rotation";
				source="mainturret";
				selection="mainturret";
				axis="mainturret_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -6.2831855;//rad -360.0
				maxValue = 6.2831855;//rad 360.0
				angle0 = 6.2831855;//rad 360.0;
				angle1 = -6.2831855;//rad -360.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingun
			{
				type="rotation";
				source="maingun";
				selection="maingun";
				axis="maingun_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -6.2831855;//rad -360.0
				maxValue = 6.2831855;//rad 360.0
				angle0 = 6.2831855;//rad 360.0;
				angle1 = -6.2831855;//rad -360.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class flap_1_1
			{
				type="rotation";
				source="flap";
				selection="flap_1_1";
				axis="flap_1_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = -0.49916422;//rad -28.600004;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class flap_2_1
			{
				type="rotation";
				source="flap";
				selection="flap_2_1";
				axis="flap_2_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = 0.24958211;//rad 14.300002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class aileron_1_1
			{
				type="rotation";
				source="aileronleftdamaged";
				selection="aileron_1_1";
				axis="aileron_1_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -1.4;//rad -80.21409
				maxValue = 1.4;//rad 80.21409
				angle0 = -0.43633235;//rad -25.000002;
				angle1 = 0.43633235;//rad 25.000002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class aileron_2_1
			{
				type="rotation";
				source="aileronrightdamaged";
				selection="aileron_2_1";
				axis="aileron_2_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -1.4;//rad -80.21409
				maxValue = 1.4;//rad 80.21409
				angle0 = -0.43633235;//rad -25.000002;
				angle1 = 0.43633235;//rad 25.000002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class rudder_1_1
			{
				type="rotation";
				source="rudderleftcenterdamaged";
				selection="rudder_1_1";
				axis="rudder_1_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -1.0;//rad -57.29578
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.2617994;//rad 15.0;
				angle1 = -0.2617994;//rad -15.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class rudder_2_1
			{
				type="rotation";
				source="rudderrightdamaged";
				selection="rudder_2_1";
				axis="rudder_2_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -1.0;//rad -57.29578
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.2617994;//rad 15.0;
				angle1 = -0.2617994;//rad -15.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class frontgear_1
			{
				type="rotation";
				source="gear";
				selection="wheel_1_1_strut";
				axis="wheel_1_1_strut_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 0.5;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = 1.7976892;//rad 103.00001;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class frontgear_1_support
			{
				type="rotation";
				source="gear";
				selection="wheel_1_1_support";
				axis="wheel_1_1_support_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 0.5;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = "rad -120";
			};
			class frontgear_1_door_l
			{
				type="rotation";
				source="gear";
				selection="door_f_1_1";
				axis="door_f_1_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.8;//rad 45.836624
				maxValue = 1.0;//rad 57.29578
				angle0 = "rad -90";
				angle1 = 0;
				initPhase = 0;
//				memory = true;//(default assumed)
			};
			class frontgear_1_door_r
			{
				type="rotation";
				source="gear";
				selection="door_f_1_2";
				axis="door_f_1_2_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.8;//rad 45.836624
				maxValue = 1.0;//rad 57.29578
				angle0 = "rad 90";
				angle1 = 0;
				initPhase = 0;
//				memory = true;//(default assumed)
			};
			class backgear_1_door_l
			{
				type="rotation";
				source="gear";
				selection="door_b_1_1";
				axis="door_b_1_1_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.7;//rad 40.107044
				maxValue = 1.0;//rad 57.29578
				angle0 = 2.0943952;//rad -120.0;
				angle1 = 0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class backgear_1_door_r
			{
				type="rotation";
				source="gear";
				selection="door_b_1_2";
				axis="door_b_1_2_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.7;//rad 40.107044
				maxValue = 1.0;//rad 57.29578
				angle0 = -2.0943952;//rad 120.0;
				angle1 = 0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class frontgearsteering
			{
				type="rotation";
				source="rudder";
				selection="wheel_1_1_steering";
				axis="wheel_1_1_steering_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = -8.0;//rad -458.36624
				maxValue = 8.0;//rad 458.36624
				angle0 = 1.0471976;//rad 60.0;
				angle1 = -1.0471976;//rad -60.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class frontgeardamper
			{
				type="rotation";
				source="damper_1_source";
				selection="wheel_1_damper";
				axis="wheel_1_damper_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = -0.17453294;//rad -10.000001;
				angle1 = 0.17453294;//rad 10.000001;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingear_2_1
			{
				type="rotation";
				source="gear";
				selection="wheel_2_1_strut";
				axis="wheel_2_1_strut_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 0.5;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = "rad 102";
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingear_2_1_support
			{
				type="rotation";
				source="gear";
				selection="wheel_2_1_support";
				axis="wheel_2_1_support_axis";//*probably*
				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = 2.0943952;//rad 120.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingear_2_2_support
			{
				type="rotation";
				source="gear";
				selection="wheel_2_2_support";
				axis="wheel_2_2_support_axis";//*probably*
				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = -2.0943952;//rad -120.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingear_2_2
			{
				type="rotation";
				source="gear";
				selection="wheel_2_2_strut";
				axis="wheel_2_2_strut_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 0.5;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = "rad -102";
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingear_2_1_suspension
			{
				type="rotationZ";
				source="damper_2_source";
				selection="wheel_2_1_strut";
				axis="wheel_2_1_strut_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = -0.03490659;//rad -2.0000002;
				angle1 = 0.03490659;//rad 2.0000002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class maingear_2_2_suspension
			{
				type="rotationZ";
				source="damper_3_source";
				selection="wheel_2_2_strut";
				axis="wheel_2_2_strut_axis";//*probably*
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.03490659;//rad 2.0000002;
				angle1 = -0.03490659;//rad -2.0000002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class wheel_1_1
			{
				type="rotationX";
				source="wheel";
				selection="wheel_1";
				axis="wheel_1_axis";//*probably*
				sourceAddress = loop;
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = -3.1415927;//rad -180.0;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class wheel_2_1
			{
				type="rotationX";
				source="wheel";
				selection="wheel_2";
				axis="wheel_2_axis";//*probably*
				sourceAddress = loop;
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = -2.792527;//rad -160.00002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class wheel_2_2
			{
				type="rotationX";
				source="wheel";
				selection="wheel_3";
				axis="wheel_3_axis";//*probably*
				sourceAddress = loop;
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				angle0 = 0.0;//rad 0.0;
				angle1 = -2.792527;//rad -160.00002;
				animPeriod = 0.0;
				initPhase = 0.0;
//				memory = true;//(default assumed)
			};
			class damagehide
			{
				type="hide";
				source="damage";
				selection="damagehide";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 1.0;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missilea
			{
				type="hide";
				source="bombs";
				selection="missilea";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missileb
			{
				type="hide";
				source="bombs";
				selection="missileb";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missilea1
			{
				type="hide";
				source="at_missiles";
				selection="missilea1";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missilea2
			{
				type="hide";
				source="at_missiles";
				selection="missilea2";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missilea3
			{
				type="hide";
				source="at_missiles";
				selection="missilea3";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missileb1
			{
				type="hide";
				source="at_missiles";
				selection="missileb1";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missileb2
			{
				type="hide";
				source="at_missiles";
				selection="missileb2";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class missileb3
			{
				type="hide";
				source="at_missiles";
				selection="missileb3";
				sourceAddress = mirror;
				minValue = -1.0;//rad -57.29578
				maxValue = 0.0;//rad 0.0
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class positionlights
			{
				type="hide";
				source="collisionlights";
				selection="positionlights_hide";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 0.0;
				unHideValue = 0.5;
				animPeriod = 0.0;
				initPhase = 0.0;
			};
			class hideweapons
			{
				type="hide";
				source="hideweapons";
				selection="hideweapons";
//				sourceAddress = clamp;// (default)
				minValue = 0.0;//rad 0.0
				maxValue = 1.0;//rad 57.29578
				hideValue = 0.5;
//				unHideValue = -1.0;//(default)
				animPeriod = 0.0;
				initPhase = 0.0;
			};
		};//</Animations>
	};//</Modelclass>
	class kornet_Rack:Default
	{
		skeletonName="Kornet_Skeleton";
		sections[]=
		{
			"tubacap"
		};

		class Animations
		{
			 class Kornet_Hatch
			{
				type="rotation";
				source="maxholdstervalue";
				selection="tubacap";
				axis="hatch_axis";
				memory=1;
				minValue=0;
				maxValue=1;
				minPhase=0;
				maxPhase=1;
				angle0=0;
				angle1=-2.845329;
			};
		};//</Animations>
	};//</Modelclass>