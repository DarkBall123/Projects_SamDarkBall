params [
    ["_operator", objNull]
];

private _currentOperator = if (isNull _operator) then { call DB_fnc_fpv_getOperator } else { _operator };

if (isNull _currentOperator) exitWith { objNull };

getConnectedUAV _currentOperator;
