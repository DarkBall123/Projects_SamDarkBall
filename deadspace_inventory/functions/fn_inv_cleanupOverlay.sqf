disableSerialization;

{
    ctrlDelete _x;
} forEach (uiNamespace getVariable ["DB_dsi_headerCtrls", []]);

{
    {
        ctrlDelete _x;
    } forEach _x;
} forEach (uiNamespace getVariable ["DB_dsi_tabCtrls", []]);

{
    {
        ctrlDelete _x;
    } forEach _x;
} forEach (uiNamespace getVariable ["DB_dsi_entryCtrls", []]);

uiNamespace setVariable ["DB_dsi_headerCtrls", []];
uiNamespace setVariable ["DB_dsi_tabCtrls", []];
uiNamespace setVariable ["DB_dsi_entryCtrls", []];
uiNamespace setVariable ["DB_dsi_selectedOption", []];
