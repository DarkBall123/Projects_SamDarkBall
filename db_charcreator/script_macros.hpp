#ifndef DB_CHARCREATOR_SCRIPT_MACROS_HPP
#define DB_CHARCREATOR_SCRIPT_MACROS_HPP

#include "\x\cba\addons\main\script_macros_common.hpp"

#define GETMVAR(NAME,DEFAULT) (missionNamespace getVariable [#NAME, DEFAULT])
#define SETMVAR(NAME,VALUE)   (missionNamespace setVariable [#NAME, VALUE])
#define GETUVAR(NAME,DEFAULT) (uiNamespace getVariable [#NAME, DEFAULT])
#define SETUVAR(NAME,VALUE)   (uiNamespace setVariable [#NAME, VALUE])

// Scale-independent grid units (one unit ~ a comfortable text row).
#define GRID_W(num) ( (num) * (pixelGridNoUIScale * pixelW * 2) )
#define GRID_H(num) ( (num) * (pixelGridNoUIScale * pixelH * 2) )

// ItemInfo type ids used to detect wearable classes inside CfgWeapons.
#define CC_TYPE_UNIFORM  801
#define CC_TYPE_HEADGEAR 605

// Control idc scheme. Each attribute row reserves a block of 10.
#define CC_IDC_BG          9300
#define CC_IDC_HEADER      9301
#define CC_IDC_HINT        9302
#define CC_IDC_FINISH      9304
#define CC_IDC_SECT_APPEAR 9305
#define CC_IDC_SECT_CLOTH  9306
#define CC_IDC_ROW(i)      ( 9310 + (i) * 10 )
#define CC_IDC_ROW_LABEL(i) ( CC_IDC_ROW(i) + 0 )
#define CC_IDC_ROW_VALUE(i) ( CC_IDC_ROW(i) + 1 )
#define CC_IDC_ROW_PREV(i)  ( CC_IDC_ROW(i) + 2 )
#define CC_IDC_ROW_NEXT(i)  ( CC_IDC_ROW(i) + 3 )

#endif
