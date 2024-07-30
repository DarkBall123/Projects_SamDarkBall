			class wing_hide
			{
				type="hide";
				source="damage_wing";
				selection="wing";
				//unHideValue=0.99;
				hideValue=1;
			};

			class optic_hide
			{
				type="hide";
				source="glass_hit";
				selection="optic_glass";
				//unHideValue=0;
				hideValue=1;
			};

			class turret_turn
			{
				type="rotation";
				source="mainTurret";
				selection="Optics_turret";
				axis="Optics_turret_axis";
				sourceAddress="clamp";
				minValue=-1;
				maxValue=1;
				angle0="(rad 180)";
				angle1="-(rad 180)";
			};

			class lens_turn
			{
				type="rotation";
				source="mainGun";
				selection="orlan_head";
				axis="orlan_head_axis";
				sourceAddress="clamp";
				minValue= -1;
				maxValue= 0;
				angle0=0;
				angle1="(rad 120)";
			};

			class prop_fan_UAV
			{
				type="rotation";
				source="rotor";
				selection="propeller_rod";
				axis="propeller_axis";
				memory=1;
				sourceAddress="loop";
				minValue=0;
				maxValue=1;
				angle0= 0;
				angle1= -10;
			};

			class prop_static_UAV
			{
				type="hide";
				source="rpm";
				selection="propellerstaticUAV";
				sourceAddress="clamp";
                minValue=0;
                maxValue=100;
                //unHideValue=0.1;
                hideValue=1;
			};
			class prop_blur_UAV:prop_static_UAV
			{
				selection="propellerblurredUAV";
				hideValue=0;
				unHideValue=1;
			};

			class prop_fan_missile
			{
				type="rotation";
				source="thrusttime";
				selection="propeller";
				axis="propeller_axis";
				memory=1;
				sourceAddress="loop";
				minValue=0;
				maxValue=1;
				angle0= 0;
				angle1= "(rad -1800)";
			};

			class prop_static_missile
			{
				type="hide";
				source="thrusttime";
				selection="propellerstatic";
				sourceAddress="clamp";
                minValue=0;
                maxValue=3;
                //unHideValue=0.1;
                hideValue=1;
			};
			class prop_blur_missile:prop_static_missile
			{
				selection="propellerblurred";
				hideValue=0;
				unHideValue=1;
			};

			// class wing_V
			// {
			// 	type="rotation";
			// 	source="rudder";
			// 	selection="rudder";
			// 	axis="rudder_axis";
			// 	sourceAddress="clamp";
			// 	minValue=-1;
			// 	maxValue=1;
			// 	angle0="-(rad 25)";
			// 	angle1="(rad 25)";
			// };

			// class wingR
			// {
			// 	type="rotation";
			// 	source="aileronB";
			// 	selection="aileron_1_2";
			// 	axis="aileron_1_2_axis";
			// 	sourceAddress="clamp";
			// 	minValue=-1;
			// 	maxValue=1;
			// 	angle0="-(rad 25)";
			// 	angle1="(rad 25)";
			// };
			// class wingL:wingR
			// {
			// 	source="aileronT";
			// 	selection="aileron_1_1";
			// 	axis="aileron_1_1_axis";
			// };