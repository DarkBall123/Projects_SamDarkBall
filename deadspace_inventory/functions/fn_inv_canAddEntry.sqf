params ["_unit", "_entry"];

if (isNull _unit || {_entry isEqualTo []}) exitWith { false };

_entry params ["_entryType", "_className", "_count"];

if (_entryType isEqualTo "backpack") exitWith {
    backpack _unit isEqualTo ""
};

_unit canAdd [_className, _count]
