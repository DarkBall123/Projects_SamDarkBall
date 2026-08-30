params [["_caller", objNull, [objNull]]];

if (isServer) then
{
    [_caller] call DZ_fnc_requestTransport;
}
else
{
    [_caller] remoteExecCall ["DZ_fnc_requestTransport", 2];
};
