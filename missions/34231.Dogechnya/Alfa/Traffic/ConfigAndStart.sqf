/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
private ["_parameters"];

private _fallbackVehicles =
[
    "c_uacivil_van01_01",
    "c_civil_ambulance_01",
    "c_cimic_medevac_van",
    "c_uadsns_kozak5_emergency_F",
    "c_uavolunteers_medevac_van",
    "C_Offroad_01_F",
    "C_Hatchback_01_sport_F",
    "C_Van_02_transport_F",
    "C_SUV_01_F"
];

private _civilianCarClasses =
    (
        "getNumber (_x >> 'scope') == 2 && { getNumber (_x >> 'side') == 3 }"
        configClasses (configFile >> "CfgVehicles")
    )
    apply { configName _x };

_civilianCarClasses = _civilianCarClasses select
{
    private _className = _x;
    private _cfg = configFile >> "CfgVehicles" >> _className;

    (_className isKindOf "Car") &&
    { !(_className isKindOf "Air") } &&
    { !(_className isKindOf "Ship") } &&
    { !(_className isKindOf "Tank") } &&
    { !(_className isKindOf "StaticWeapon") } &&
    { (getNumber (_cfg >> "isUav")) <= 0 } &&
    { (getNumber (_cfg >> "hasDriver")) > 0 } &&
    { (getText (_cfg >> "displayName")) != "" }
};

_civilianCarClasses = _civilianCarClasses arrayIntersect _civilianCarClasses;

if (_civilianCarClasses isEqualTo []) then
{
    _civilianCarClasses = _fallbackVehicles;
};

diag_log format ["[TRAFFIC] Civilian car pool size: %1", count _civilianCarClasses];

// Set traffic parameters.
_parameters = [
    ["SIDE", civilian],
    ["VEHICLES", _civilianCarClasses],
    ["VEHICLES_COUNT", 3],
    ["MIN_SPAWN_DISTANCE", 400],
    ["MAX_SPAWN_DISTANCE", 1200],
    ["MIN_SKILL", 0.4],
    ["MAX_SKILL", 0.6],
    ["DEBUG", false]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
