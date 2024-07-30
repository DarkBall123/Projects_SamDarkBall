private _avaibleList = [["OrlanFS_Ammo"], ["Krasnopol"]];

if (isClass (configFile >> "CfgPatches" >> "lk_lancet")) then {
    (_avaibleList # 0) append ["m_lancet_dummy", "Random"];
    (_avaibleList # 1) append ["Lancet", "Random"];
};

missionNamespace setVariable ["orlanFS_allAvaibles", (_avaibleList # 0) - ["Random"]];
missionNamespace setVariable ["orlanFS_allAvaiblesDrones", ["orlan_F_OPF", "orlan_F_BLU", "orlan_F_IND", "zala421_uav_b", "zala421_uav_o", "zala421_uav_i"]];

["orlanFS_ammoFly", "LIST", ["List of available projectiles", "Select the projectiles"], "Krasnopol Fire Support", [_avaibleList # 0, _avaibleList # 1, 0]] call CBA_fnc_addSetting;
["orlanFS_randomFlyValues", "LIST", ["Projectile ETA selection list", "Select"], "Krasnopol Fire Support", [["Long", "Medium", "Fast"], ["Long", "Medium", "Fast"], 1]] call CBA_fnc_addSetting;
["orlanFS_delayTime", "SLIDER", ["Delay Time", "Select"], "Krasnopol Fire Support", [10, 180, 180, 0]] call CBA_fnc_addSetting;