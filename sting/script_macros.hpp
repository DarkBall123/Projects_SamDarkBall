#ifndef STING_SCRIPT_MACROS_HPP
#define STING_SCRIPT_MACROS_HPP

#include "\x\cba\addons\main\script_macros_common.hpp"

#define GETMVAR(NAME,DEFAULT) (missionNamespace getVariable [#NAME, DEFAULT])
#define SETMVAR(NAME,VALUE) (missionNamespace setVariable [#NAME, VALUE])
#define GETUVAR(NAME,DEFAULT) (uiNamespace getVariable [#NAME, DEFAULT])
#define SETUVAR(NAME,VALUE) (uiNamespace setVariable [#NAME, VALUE])

#define STING_FEET_PER_METER 3.28084
#define STING_SPEED_SCALE 1
#define STING_SPEED_MAX 60
#define STING_ALT_MAX 120

#define STING_SIGNAL_LOSS_THRESHOLD 0.05
#define STING_SIGNAL_LOSS_DURATION 5
#define STING_SIGNAL_UPDATE_INTERVAL 0.2
#define STING_PPFX_UPDATE_INTERVAL 0.05
#define STING_CONNECT_LOOP_INTERVAL 0.1
#define STING_TIME_SYNC_INTERVAL 1
#define STING_CLOSE_DISTANCE 75
#define STING_CLOSE_TERRAIN_MIN 0.65

#define STING_DRONE_TYPES ["O_Sting_F", "B_Sting_F", "I_Sting_F", "O_Sting_TI_F", "B_Sting_TI_F", "I_Sting_TI_F"]
#define STING_DRONE_ITEMS ["Item_Sting", "Item_Sting_TI"]
#define STING_TERMINAL_TYPES ["B_UavTerminal", "O_UavTerminal", "I_UavTerminal"]

#endif
