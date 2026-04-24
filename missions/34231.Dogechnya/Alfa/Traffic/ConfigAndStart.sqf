/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
 private ["_parameters"];

// Set traffic parameters.
_parameters = [
	["SIDE", civilian],
	["VEHICLES", ["c_uacivil_van01_01", "c_civil_ambulance_01", "c_cimic_medevac_van", "c_uadsns_kozak5_emergency_F", "c_uavolunteers_medevac_van", "C_Offroad_01_F", "C_Hatchback_01_sport_F", "C_Van_02_transport_F", "C_SUV_01_F"]],
	["VEHICLES_COUNT", 3],
	["MIN_SPAWN_DISTANCE", 400],
	["MAX_SPAWN_DISTANCE", 1200],
	["MIN_SKILL", 0.4],
	["MAX_SKILL", 0.6],
	["DEBUG", false]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
