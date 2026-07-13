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
        ["clusterCount", 6],
        ["elementsPerCluster", [6, 6]],
        ["impactRadius", 110],
        ["entryAngle", 82],
        ["startAltitude", 15000],
        ["duration", 4.2],
        ["clusterDelay", 0.18],
        ["damage", true],
        ["sound", true],
        ["mode", "kinetic"],
        ["azimuth", _azimuth],
        ["flybySoundProgress", 0.7],
        ["flybySoundVolume", 1.25],
        ["flybySoundDistance", 4500],
        ["flybySound", "jtac_support\oreshnik\sounds\rok.ogg"],
        ["skyVisualAltitude", 1800],
        ["minSkyDuration", 1.55],
        ["skyFlareClass", "DB_JTAC_Oreshnik_Flare_White"],
        ["skyTracerClass", "DB_JTAC_Oreshnik_Tracer_Yellow"]
    ];

    [_targetATL, _settings] call DB_fnc_oreshnikStrike;
};
