#include "\db_raycastui\script_component.hpp"

params [
    ["_mapId", "demo_01", [""]]
];

private _path = "\db_raycastui\data\maps\demo_01.sqf";

call compileFinal preprocessFileLineNumbers _path
