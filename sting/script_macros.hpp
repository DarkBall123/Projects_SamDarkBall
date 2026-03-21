#ifndef ARMAFPV_SCRIPT_MACROS_HPP
#define ARMAFPV_SCRIPT_MACROS_HPP

#include "\x\cba\addons\main\script_macros_common.hpp"

#define GETMVAR(NAME,DEFAULT) (missionNamespace getVariable [#NAME, DEFAULT])
#define SETMVAR(NAME,VALUE) (missionNamespace setVariable [#NAME, VALUE])
#define GETUVAR(NAME,DEFAULT) (uiNamespace getVariable [#NAME, DEFAULT])
#define SETUVAR(NAME,VALUE) (uiNamespace setVariable [#NAME, VALUE])

#define FPV_FEET_PER_METER 3.28084
#define FPV_SPEED_SCALE 1
#define FPV_SPEED_MAX 60
#define FPV_ALT_MAX 120

#define FPV_SIGNAL_LOSS_THRESHOLD 0.05
#define FPV_SIGNAL_LOSS_DURATION 5
#define FPV_SIGNAL_UPDATE_INTERVAL 0.2
#define FPV_PPFX_UPDATE_INTERVAL 0.05
#define FPV_CONNECT_LOOP_INTERVAL 0.1
#define FPV_TIME_SYNC_INTERVAL 1
#define FPV_CLOSE_DISTANCE 75
#define FPV_CLOSE_TERRAIN_MIN 0.65

#define FPV_DRONE_TYPES ["O_Sting_F", "B_Sting_F", "I_Sting_F"]
#define FPV_DRONE_ITEMS []
#define FPV_TERMINAL_TYPES ["B_UavTerminal", "O_UavTerminal", "I_UavTerminal"]

#endif
