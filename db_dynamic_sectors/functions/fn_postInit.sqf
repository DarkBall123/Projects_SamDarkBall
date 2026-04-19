if (isServer) then
{
    call DB_DS_fnc_serverLoop;
};

if (hasInterface) then
{
    call DB_DS_fnc_clientInit;
};
