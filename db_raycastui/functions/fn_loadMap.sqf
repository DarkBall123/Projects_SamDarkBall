#include "\db_raycastui\script_component.hpp"

params [
    ["_mapId", "demo_01", [""]]
];

private _path = switch (toLower _mapId) do
{
    case "demo_02":
    {
        "\db_raycastui\data\maps\demo_02.sqf"
    };
    default
    {
        "\db_raycastui\data\maps\demo_01.sqf"
    };
};

call compileFinal preprocessFileLineNumbers _path
