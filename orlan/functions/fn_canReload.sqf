params ["_unit"];

private _allObjects = player nearEntities 10;

(!(someammo _unit) && (_unit animationsourcephase 'luch_anim' == 1) && (_unit animationsourcephase 'reload_uav' == 1)) &&
{isnull (_unit getvariable ["proxy", objnull])} && 
{
    private _reloadableBox = _allObjects findIf {(typeOf _x == "orlan_reloadBox") && { !(_x getVariable ["used", false]) }};
    _reloadableBox != -1
}
