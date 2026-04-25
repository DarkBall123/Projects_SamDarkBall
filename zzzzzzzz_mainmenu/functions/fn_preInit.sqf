if (!hasInterface) exitWith {};

diag_log "[DB_MAINMENU] preInit started";

[] spawn
{
    disableSerialization;

    diag_log "[DB_MAINMENU] display watcher started";

    private _lastDisplay = displayNull;

    while { true } do
    {
        private _display = displayNull;

        waitUntil
        {
            uiSleep 0.25;

            _display = displayNull;

            {
                if (isNull _display && { !isNull (_x displayCtrl 1009) }) then
                {
                    _display = _x;
                };
            } forEach allDisplays;

            !isNull _display
        };

        if !(_display isEqualTo _lastDisplay) then
        {
            _lastDisplay = _display;
            diag_log format ["[DB_MAINMENU] watcher found main menu display: %1", _display];
            [_display] execVM "\zzzzzzzz_mainmenu\IntroMission.Stratis\initIntro.sqf";
        };

        waitUntil
        {
            uiSleep 0.5;
            isNull _display || { isNull (_display displayCtrl 1009) }
        };
    };
};
