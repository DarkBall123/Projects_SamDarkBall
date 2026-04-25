diag_log format ["[DB_MAINMENU] watcher init requested: hasInterface=%1", hasInterface];

if (missionNamespace getVariable ["DB_mainMenuWatcherStarted", false]) exitWith
{
    diag_log "[DB_MAINMENU] watcher already started";
};

missionNamespace setVariable ["DB_mainMenuWatcherStarted", true];

[] spawn
{
    disableSerialization;

    waitUntil
    {
        uiSleep 0.25;
        hasInterface
    };

    diag_log "[DB_MAINMENU] display watcher started";

    private _fnc_isMainMenuDisplay =
    {
        params ["_display"];

        private _result = false;

        if (!isNull _display) then
        {
            private _currentCtrl = _display displayCtrl 1009;
            private _nextCtrl = _display displayCtrl 1010;

            if (!isNull _currentCtrl && { !isNull _nextCtrl }) then
            {
                private _marked = _display getVariable ["DB_mainMenuDisplay", false];
                private _displayClass = _display getVariable ["BIS_fnc_initDisplay_configClass", ""];
                private _currentClass = ctrlClassName _currentCtrl;
                private _nextClass = ctrlClassName _nextCtrl;

                _result = _marked
                    || { _displayClass == "RscDisplayMain" }
                    || { _currentClass == "BackgroundHover" && { _nextClass == "BackgroundSlideNext" } };
            };
        };

        _result
    };

    private _lastDisplay = displayNull;

    while { true } do
    {
        private _display = displayNull;

        waitUntil
        {
            uiSleep 0.25;

            _display = displayNull;

            {
                if (isNull _display && { [_x] call _fnc_isMainMenuDisplay }) then
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
            isNull _display || { !([_display] call _fnc_isMainMenuDisplay) }
        };
    };
};
