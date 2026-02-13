#ifndef VND_MAIN_SCRIPT_MACROS_HPP
#define VND_MAIN_SCRIPT_MACROS_HPP

#include "\x\cba\addons\main\script_macros_common.hpp"

#define GETMVAR(NAME,DEFAULT) (missionNamespace getVariable [#NAME, DEFAULT])
#define SETMVAR(NAME,VALUE) (missionNamespace setVariable [#NAME, VALUE])
#define SETMVAR_PUBLIC(NAME,VALUE) (missionNamespace setVariable [#NAME, VALUE, true])
#define GETUVAR(NAME,DEFAULT) (uiNamespace getVariable [#NAME, DEFAULT])
#define SETUVAR(NAME,VALUE) (uiNamespace setVariable [#NAME, VALUE])

#define VND_FIBER_TICK_INTERVAL      0.033
#define VND_FIBER_GRAVITY_INTERVAL   0.066
#define VND_FIBER_SYNC_INTERVAL      0.20
#define VND_FIBER_SNAPSHOT_INTERVAL  2.0
#define VND_FIBER_ANCHOR_DIST        1.5
#define VND_FIBER_MAX_SPOOL          200
#define VND_FIBER_DRAW_DISTANCE      450
#define VND_FIBER_SEG_NEAR           1.0
#define VND_FIBER_SEG_MID            2.0
#define VND_FIBER_SEG_FAR            4.0
#define VND_FIBER_SEG_NEAR_DIST      60
#define VND_FIBER_SEG_MID_DIST       180

#define VND_CONNECT_LOOP_INTERVAL    0.10

#endif
