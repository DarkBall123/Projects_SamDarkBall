if (isNil "EPDJtacAquisitionGlobalModifier") then {
    EPDJtacAquisitionGlobalModifier = 1.0;
};

if (isNil "EPDJtacAquisitionFixedTime") then {
    EPDJtacAquisitionFixedTime = 0;
};

if(isserver) then {
    //If true, allows you to skip the cool down.
    EPDJtacDebug = true;
};

//The percent chance that a guided missile will fail and blow up in the air.
EPDJtacGuidedMissileExplosiveFailureChance = 1;

//The percent chance that a guided missile will lose tracking and just travel in a straight line.
EPDJtacGuidedMissileLostTrackingFailureChance = 1;

// [category, capacity, shortReloadTime, longReloadTime]
EPDJtacReloads = [
    ["BULLETS", 100, 60, 60],
    ["SHELLS", 100, 60, 60],
    ["STRAFINGRUN", 100, 60, 60],
    ["BOMBS", 100, 1, 1],
    ["ROCKETS", 100, 1, 1],
    ["GUIDEDMISSILE", 100, 1, 1],
    ["MINES", 100, 60, 60],
    ["SMOKE", 100, 60, 60],
    ["NIGHT", 100, 60, 60]
];

/*
    ["payloadCategory", "displayName", "acquireRate", "capacityUsed", "projectileFiringMethod", [firing method parameters...]]

    payloadCategory - One of "BULLETS", "SHELLS", "STRAFINGRUN", "BOMBS", "ROCKETS", "GUIDEDMISSILE", "MINES", "SMOKE", or "NIGHT" . Determines which Jtac menu the payload will show up in.

    displayName - Name of the payload that will be presented to the operator.

    acquireRate - Seconds required to aquire a target.

    capacityUsed - The amount of the remaining capacity the attack will use. When the capacity is reached a long reload is triggered.

    projectileFiringMethod - One of "SHOOT_PROJECTILES", "DROP_BOMBS", "FIRE_ROCKETS", "EVEN_SPREAD_PROJECTILES", "STRAFING_RUN_ROCKET", "STRAFING_RUN_PROJECTILE", "LAY_MINE_FIELD". Determines which method will be used to send the payload to the target.

        SHOOT_PROJECTILES - Traditional technique of sending a projectile at a target. Projectile will be spawned about 2.2km away and flung towards the target.
            parameters - [_projectileClassName, _verticalOffset, _numberToSend, _spreadRadial, _spreadNormal, _minTimeBetween, _maxRandomTime]
                _projectileClassName - Classname of the projectile to use.
                _numberToSend - How many projectiles to shoot.
                _verticalOffset - How many meters to aim up over the top of the target so it can hit the target.
                _spreadRadial - Radius of the horizontal inaccuracy. Projectiles can land anywhere in a circle of this radius around the target.
                _spreadNormal - Height of vertical inaccuracy. Think aiming too high or low. Turns the inaccuracy circle into an oval.
                _minTimeBetween - Minimum time between shots.
                _maxRandomTime  - A random value of up to this value is added to the _minTimeBetween variable to provide some variable time between shots.
                _height - Optional starting height for the projectile.
                _distance - Optional starting distance for the projectile.
                _speed - Optional starting speed for the projectile.

        DROP_BOMBS - Spawns the payload about 4.2km away. Sets the correct orientation and gives it a bit of velocity.
            parameters - [_projectileClassName, _numberToSend, _initialSpeed, _speedVariance, _spreadRadial, _minTimeBetween, _maxRandomTime, _useImpactSpread, _sourceDistance]
                _projectileClassName - Classname of the projectile to use.
                _numberToSend - How many bombs to drop.
                _initialSpeed - How fast the bomb is going.
                _speedVariance - The speed of the bomb will be adjusted by up to this much. This will cause the bomb to undershoot or overshoot.
                _spreadRadial - Radius of the horizontal inaccuracy. When _useImpactSpread is true, bombs will land anywhere in a circle of this radius around the target.
                _minTimeBetween - Minimum time between shots.
                _maxRandomTime  - A random value of up to this value is added to the _minTimeBetween variable to provide some variable time between shots.
                _useImpactSpread - Optional. Use true for bomb payloads that should spread around the target point instead of just varying their spawn point.
                _sourceDistance - Optional horizontal distance from the target.

        FIRE_ROCKETS - Spawns a missile. Sets the correct orientation and sets the correct model orientation.
            parameters - [_projectileClassName, _numberToSend, _horizontalDistance, _pitch, _pitchVariance, _yawVariance, _minTimeBetween, _maxRandomTime]
                _projectileClassName - Classname of the projectile to use.
                _numberToSend - How many rockets to fire.
                _horizontalDistance - How far away the missile spawns.
                _pitch - The pitch the model must be angled to to hit.
                _pitchVariance - How much the pitch can be varied, This will cause the missile to undershoot or overshoot.
                _yawVariance - How much the yaw can be varied, this will cause the missile to land to the left or right.
                _minTimeBetween - Minimum time between shots.
                _maxRandomTime  - A random value of up to this value is added to the _minTimeBetween variable to provide some variable time between shots.

        STRAFING_RUN_ROCKET - Spawns a run of rockets.
            parameters - [_projectileClassName, _numberToSend, _horizontalDistance, _pitch, _pitchVariance, _yawVariance, _minTimeBetween, _maxRandomTime]
                _projectileClassName - Classname of the projectile to use.
                _numberToSend - How many rockets to fire.
                _distanceToStrafe - How far the run should go.
                _horizontalDistance - How far away the missile spawns.
                _pitch - The pitch the model must be angled to to hit.
                _spread - How many meters in each direction the rockets can land from their desired location.
                _minTimeBetween - Minimum time between shots.
                _maxRandomTime  - A random value of up to this value is added to the _minTimeBetween variable to provide some variable time between shots.

        STRAFING_RUN_PROJECTILE - Spawns a run of projectiles.
            parameters - [_projectileClassName, _numberToSend, _horizontalDistance, _pitch, _pitchVariance, _yawVariance, _minTimeBetween, _maxRandomTime]
                _projectileClassName - Classname of the projectile to use.
                _numberToSend - How many rockets to fire.
                _verticalOffset - How many meters to aim up over the top of the target so it can hit the target.
                _distanceToStrafe - How far the run should go.
                _horizontalDistance - How far away the missile spawns.
                _spread - How many meters in each direction the rockets can land from their desired location.
                _minTimeBetween - Minimum time between shots.
                _maxRandomTime  - A random value of up to this value is added to the _minTimeBetween variable to provide some variable time between shots.

        EVEN_SPREAD_PROJECTILES - Spawns 12 of the items randomly above the target and flings them down. Creates an evenly space inner triangle and an evenly space outer nonagon.
            parameters - [[_projectileClassName, _projectileClassName,_projectileClassName,...], _spreadRadial, _downwardSpeed, _spawnHeight]
                _projectileClassName - Classname of the projectile to use. 1 or more of these can be passed in.
                _spreadRadial - Radius of the horizontal inaccuracy. Projectiles can land anywhere in a circle of this radius around the target.
                _downwardSpeed - Initial downward velocity before gravity kicks in.
                _spawnHeight - Height above the terran that the projectile will spawn.

        LAY_MINE_FIELD - Spawns a mine field.
            parameters - [[_mineClassName, _mineClassName,...], _numberToSend,  _spreadRadial]
                _projectileClassName - Classname of the projectile to use. 1 or more of these can be passed in.
                _numberToSend - How many mines to lay.
                _spreadRadial - How far the mines can spawn from the target.
*/

EPDJtacAvailableAttacks  = [
    ["BULLETS", "20mm Cannon", 10, 2, "SHOOT_PROJECTILES", ["B_20mm", 40, 10, 15, 5, .05, .05]],
    ["BULLETS", "20mm HE Burst", 10, 2, "SHOOT_PROJECTILES", ["G_20mm_HE", 30, 15, 20, 10, .05, .05]],
    ["BULLETS", "30mm HE Strike", 12, 3, "SHOOT_PROJECTILES", ["B_30mm_HE", 25, 10, 15, 8, .08, .1]],
    ["BULLETS", "40mm HEDP (Auto)", 16, 4, "SHOOT_PROJECTILES", ["G_40mm_HEDP", 20, 20, 25, 15, .15, .2]],
    ["BULLETS", "40mm HE (Auto)", 16, 4, "SHOOT_PROJECTILES", ["G_40mm_HE", 20, 20, 30, 15, .15, .2]],

    ["SHELLS", "82mm Battery Strike", 18, 3, "SHOOT_PROJECTILES", ["Sh_82mm_AMOS", 6, 23.9, 60, 30, 0.5, 0.5]],
    ["SHELLS", "120mm Battery Strike", 20, 3, "SHOOT_PROJECTILES", ["Sh_120mm_HE", 6, 37.4, 100, 50, 0.8, 1]],
    ["SHELLS", "Krasnopol", 22, 7, "SHOOT_PROJECTILES", ["Sh_155mm_AMOS", 1, 23.9, 5, 2, 0, 0]],
    ["SHELLS", "Excalibur", 22, 7, "SHOOT_PROJECTILES", ["Sh_155mm_AMOS", 1, 23.9, 5, 2, 0, 0]],
    ["SHELLS", "155mm cassette", 24, 7, "SHOOT_PROJECTILES", ["Cluster_155mm_AMOS", 1, 23.9, 8, 8, 2, 1]],

    ["STRAFINGRUN", "20mm - 50 meters", 12, 1, "STRAFING_RUN_PROJECTILE", ["B_20mm", 50, 10, 50, 5, .01, .01]],
    ["STRAFINGRUN", "20mm - 100 meters", 15, 2, "STRAFING_RUN_PROJECTILE", ["B_20mm", 100, 10, 100, 8, .005, .005]],
    ["STRAFINGRUN", "Dagger - 50 meters", 30, 2, "STRAFING_RUN_ROCKET", ["M_AT", 6, 50, 2500, -15, 10, .1, .2]],
    ["STRAFINGRUN", "Dagger - 100 meters", 35, 3, "STRAFING_RUN_ROCKET", ["M_AT", 12, 100, 2500, -15, 15, .1, .2]],
    ["STRAFINGRUN", "Shrieker HE - 50 meters", 30, 2, "STRAFING_RUN_ROCKET", ["Rocket_04_HE_F", 8, 50, 2500, -15, 12, .1, .2]],
    ["STRAFINGRUN", "Shrieker HE - 100 meters", 35, 3, "STRAFING_RUN_ROCKET", ["Rocket_04_HE_F", 16, 100, 2500, -15, 20, .1, .2]],

    ["BOMBS", "UMPK FAB 250", 30, 1, "DROP_BOMBS", ["umpk250", 1, 211.7, 0, 10, 0, 0, true]],
    ["BOMBS", "4x UMPK FAB 250", 30, 1, "DROP_BOMBS", ["umpk250", 4, 211.7, 0.5, 40, 0.5, 1, true]],
    ["BOMBS", "UMPK FAB 500", 30, 1, "DROP_BOMBS", ["umpk500", 1, 211.7, 0, 10, 0, 0, true]],
    ["BOMBS", "UMPK FAB 1500", 30, 1, "DROP_BOMBS", ["umpk1500", 1, 211.7, 0, 10, 0, 0, true, 4500]],
    ["BOMBS", "RBK500 cassette", 30, 1, "DROP_BOMBS", ["BombCluster_03_Ammo_F", 2, 212, 0.5, 60, 0.5, 1, true]],
    ["BOMBS", "500lb GBU12", 30, 1, "DROP_BOMBS", ["Bomb_03_F", 1, 223.5, 0, 5, 0, 0, true]],
    ["BOMBS", "4x 500lb GBU12", 30, 1, "DROP_BOMBS", ["Bomb_03_F", 4, 223.5, 0.5, 40, 0.5, 1, true]],
    ["BOMBS", "1000lb GBU32", 30, 1, "DROP_BOMBS", ["GBU32", 1, 223.5, 0, 5, 0, 0, true, 4500]],
    ["BOMBS", "1500lb GBU54", 30, 1, "DROP_BOMBS", ["GBU54", 1, 223.5, 0, 5, 0, 0, true]],
    ["BOMBS", "580lb cassette", 30, 1, "DROP_BOMBS", ["BombCluster_03_Ammo_F", 1, 212, 0.5, 50, 0, 0, true]],

    ["ROCKETS", "TORNADO-S", 30, 1, "DROP_BOMBS", ["TORNADOS", 12, 240.55, 0.5, 45, 0.8, 1.2, true]],
    ["BOMBS", "TORNADO-S cassette ", 30, 1, "DROP_BOMBS", ["BombCluster_03_Ammo_F", 12, 212, 0.5, 80, 1, 2, true]],
    ["ROCKETS", "TORNADO-G", 30, 1, "DROP_BOMBS", ["TORNADOG", 40, 240.55, 1.5, 200, 0.1, 0.2, true]],
    ["ROCKETS", "ISKANDER", 60, 1, "DROP_BOMBS", ["ISKANDERK", 1, 240.55, 0.2, 7, 0, 0, true]],
    ["ROCKETS", " X101", 60, 1, "FIRE_ROCKETS", ["X101", 1, 3911.5, -17.04, 0.05, 0.05, 0, 0]],
    ["ROCKETS", " X101 cassette ", 60, 1, "FIRE_ROCKETS", ["ammo_Missile_Cruise_01_Cluster", 1, 3911.5, -17.04, 0.05, 0.05, 0, 0]],
    ["ROCKETS", "KINJAL", 60, 1, "FIRE_ROCKETS", ["KINJAL", 1, 4135.5, -17.04, 0.01, 0.01, 0, 0]],
    ["ROCKETS", "HIMARS", 30, 1, "DROP_BOMBS", ["TORNADOS", 6, 240.55, 0.5, 30, 1, 2, true]],
    ["ROCKETS", "ATACMS", 60, 1, "DROP_BOMBS", ["ISKANDERK", 1, 240.55, 0.2, 7, 0, 0, true]],
    ["ROCKETS", "TOMAHAWK", 60, 1, "FIRE_ROCKETS", ["X101", 1, 3911.5, -17.04, 0.05, 0.05, 0, 0]],
    ["ROCKETS", "ORESHNIK", 60, 1, "FIRE_ORESHNIK", []],


    ["GUIDEDMISSILE", "Spike LR Laser", 1, 1, "FIRE_GUIDED_MISSILE", ["M_Titan_AT_long", "laser"]],
    ["GUIDEDMISSILE", "Spike LR", 1, 1, "FIRE_GUIDED_MISSILE", ["M_Titan_AT_long", "vehicle"]],
    ["GUIDEDMISSILE", "Kornet AT", 1, 1, "FIRE_GUIDED_MISSILE", ["M_Vorona_HEAT", "laser"]], //NEW
    ["GUIDEDMISSILE", "Kornet AP", 1, 1, "FIRE_GUIDED_MISSILE", ["M_Vorona_HE", "laser"]], //NEW


    ["MINES", "APERS Mine", 30, 2, "LAY_MINE_FIELD", [["APERSMine"], 20, 20]],
    ["MINES", "APERS Bounding Mine", 30, 2, "LAY_MINE_FIELD", [["APERSBoundingMine"], 20, 20]],
    ["MINES", "APERS Mix", 40, 3, "LAY_MINE_FIELD", [["APERSMine", "APERSBoundingMine"], 20, 20]],
    ["MINES", "Anti-Tank Mine", 30, 2, "LAY_MINE_FIELD", [["ATMine"], 20, 20]],
    ["MINES", "SLAM Directional Mine", 30, 2, "LAY_MINE_FIELD", [["SLAMDirectionalMine"], 20, 20]],
    ["MINES", "Anti-Vehicle Mix", 30, 3, "LAY_MINE_FIELD", [["ATMine", "SLAMDirectionalMine"], 20, 20]],
    ["MINES", "Clear Mine Field", 30, 2, "EVEN_SPREAD_PROJECTILES", [["BombDemine_01_Ammo_F"], 20, -10, 200]],

    ["SMOKE", "White Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_Smoke",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Blue Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_SmokeBlue",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Green Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_SmokeGreen",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Orange Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_SmokeOrange",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Purple Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_SmokePurple",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Red Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_SmokeRed",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Yellow Smoke", 6, 1, "SHOOT_PROJECTILES", ["G_40mm_SmokeYellow",2, 0, 5, 5, 1, 1.6, 75, 6, 25]],
    ["SMOKE", "Small cloud", 10, 2, "EVEN_SPREAD_PROJECTILES", [["G_40mm_Smoke", "G_40mm_SmokeRed", "G_40mm_SmokeBlue", "G_40mm_SmokeGreen", "G_40mm_SmokeOrange", "G_40mm_SmokePurple", "G_40mm_SmokeRed", "G_40mm_SmokeYellow" ], 15, -0.1, 100]],
    ["SMOKE", "Medium cloud", 12, 3, "EVEN_SPREAD_PROJECTILES", [["Smoke_82mm_AMOS_White"], 15, -80, 1000]],
    ["SMOKE", "Large cloud", 14, 4, "EVEN_SPREAD_PROJECTILES", [["Smoke_120mm_AMOS_White"], 35, -80, 1000]],

    ["NIGHT", "Flare Cloud", 10, 1, "EVEN_SPREAD_PROJECTILES", [["F_40mm_White", "F_40mm_Green", "F_40mm_Red", "F_40mm_Yellow"], 35, -0.1, 120]],
    ["NIGHT", "Chem Lights", 10, 1, "EVEN_SPREAD_PROJECTILES", [["Chemlight_blue", "Chemlight_red", "Chemlight_yellow", "Chemlight_green"], 10, -0.1, 120]],
    ["NIGHT", "Strobes", 10, 1, "EVEN_SPREAD_PROJECTILES", [["I_IRStrobe"], 15, -0.1, 120]],
    ["NIGHT", "Night Signal", 10, 1, "EVEN_SPREAD_PROJECTILES", [["Chemlight_blue", "G_40mm_Smoke"], 8, -0.1, 120]]
];
