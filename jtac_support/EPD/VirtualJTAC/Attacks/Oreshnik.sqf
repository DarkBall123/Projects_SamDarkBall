FIRE_ORESHNIK = {
    if (!isServer) exitWith {};

    private _target = _this select 0;
    private _incomingAngle = _this select 1;
    private _targetATL = _target;

    if (_target isEqualType []) then {
        _targetATL = ASLToATL _target;
    };

    private _azimuth = (_incomingAngle + 180) % 360;

    private _settings = createHashMapFromArray [
        ["clusterCount", missionNamespace getVariable ["DB_JTAC_OreshnikClusterCount", 6]],
        ["elementsPerCluster", [
            missionNamespace getVariable ["DB_JTAC_OreshnikElementsMin", 4],
            missionNamespace getVariable ["DB_JTAC_OreshnikElementsMax", 6]
        ]],
        ["patternLength", missionNamespace getVariable ["DB_JTAC_OreshnikPatternLength", 320]],
        ["patternWidth", missionNamespace getVariable ["DB_JTAC_OreshnikPatternWidth", 80]],
        ["longitudinalScatter", missionNamespace getVariable ["DB_JTAC_OreshnikLongitudinalScatter", 8]],
        ["lateralScatter", missionNamespace getVariable ["DB_JTAC_OreshnikLateralScatter", 5]],
        ["entryAngle", missionNamespace getVariable ["DB_JTAC_OreshnikEntryAngle", 82]],
        ["startAltitude", missionNamespace getVariable ["DB_JTAC_OreshnikStartAltitude", 15000]],
        ["duration", missionNamespace getVariable ["DB_JTAC_OreshnikFlightDuration", 4.2]],
        ["durationJitter", missionNamespace getVariable ["DB_JTAC_OreshnikDurationJitter", 0.08]],
        ["clusterDelay", missionNamespace getVariable ["DB_JTAC_OreshnikWaveDelay", 1.1]],
        ["elementDelay", missionNamespace getVariable ["DB_JTAC_OreshnikElementDelay", 0.015]],
        ["timingJitter", missionNamespace getVariable ["DB_JTAC_OreshnikTimingJitter", 0.04]],
        ["streakScale", missionNamespace getVariable ["DB_JTAC_OreshnikStreakScale", 1.35]],
        ["streakVariation", missionNamespace getVariable ["DB_JTAC_OreshnikStreakVariation", 0.12]],
        ["trailLength", missionNamespace getVariable ["DB_JTAC_OreshnikTrailLength", 260]],
        ["trailDensity", missionNamespace getVariable ["DB_JTAC_OreshnikTrailDensity", 1]],
        ["lightScale", missionNamespace getVariable ["DB_JTAC_OreshnikLightScale", 1]],
        ["tracer", missionNamespace getVariable ["DB_JTAC_OreshnikTracerEnabled", true]],
        ["trail", missionNamespace getVariable ["DB_JTAC_OreshnikTrailEnabled", true]],
        ["impactFlashScale", missionNamespace getVariable ["DB_JTAC_OreshnikImpactFlashScale", 1]],
        ["impactDustScale", missionNamespace getVariable ["DB_JTAC_OreshnikImpactDustScale", 1]],
        ["impactDustDuration", missionNamespace getVariable ["DB_JTAC_OreshnikImpactDustDuration", 3]],
        ["impactSparkCount", missionNamespace getVariable ["DB_JTAC_OreshnikImpactSparkCount", 20]],
        ["cameraShakeScale", missionNamespace getVariable ["DB_JTAC_OreshnikCameraShakeScale", 1]],
        ["cameraShakeRadius", missionNamespace getVariable ["DB_JTAC_OreshnikCameraShakeRadius", 650]],
        ["damage", missionNamespace getVariable ["DB_JTAC_OreshnikDamageEnabled", true]],
        ["damageRadius", missionNamespace getVariable ["DB_JTAC_OreshnikDamageRadius", 14]],
        ["maxDamage", missionNamespace getVariable ["DB_JTAC_OreshnikMaxDamage", 0.7]],
        ["sound", missionNamespace getVariable ["DB_JTAC_OreshnikSoundEnabled", true]],
        ["soundScale", missionNamespace getVariable ["DB_JTAC_OreshnikSoundScale", 1]],
        ["simulateSoundDelay", missionNamespace getVariable ["DB_JTAC_OreshnikSimulateSoundDelay", true]],
        ["soundDelayMax", missionNamespace getVariable ["DB_JTAC_OreshnikSoundDelayMax", 8]],
        ["mode", "kinetic"],
        ["azimuth", _azimuth],
        ["flybySoundProgress", missionNamespace getVariable ["DB_JTAC_OreshnikFlybyProgress", 0.7]],
        ["flybySoundVolume", missionNamespace getVariable ["DB_JTAC_OreshnikFlybyVolume", 1.25]],
        ["flybySoundDistance", missionNamespace getVariable ["DB_JTAC_OreshnikFlybyDistance", 4500]],
        ["flybySound", "jtac_support\oreshnik\sounds\rok.ogg"],
        ["skyVisualAltitude", missionNamespace getVariable ["DB_JTAC_OreshnikVisibleAltitude", 2200]],
        ["minSkyDuration", missionNamespace getVariable ["DB_JTAC_OreshnikVisibleDuration", 0.85]],
        ["skyFlareClass", "DB_JTAC_Oreshnik_Flare_White"],
        ["skyTracerClass", "DB_JTAC_Oreshnik_Tracer_White"]
    ];

    [_targetATL, _settings] call DB_fnc_oreshnikStrike;
};
