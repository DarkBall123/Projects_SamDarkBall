disableSerialization;

diag_log "[DB_MAINMENU] initIntro started";

private _display = displayNull;
private _fnc_findMenuDisplay =
{
    private _result = displayNull;

    {
        if (isNull _result) then
        {
            if (!isNull (_x displayCtrl 1009)) then
            {
                _result = _x;
            };
        };
    } forEach allDisplays;

    if (isNull _result) then
    {
        _result = findDisplay 0;
    };

    _result
};

if (!isNil "_this" && { _this isEqualType [] } && { count _this > 0 }) then
{
    private _passedArg = _this # 0;

    if (_passedArg isEqualType displayNull) then
    {
        _display = _passedArg;
    };

    if (_passedArg isEqualType controlNull) then
    {
        _display = ctrlParent _passedArg;
    };
};

if (isNull _display) then
{
    diag_log "[DB_MAINMENU] initIntro waiting for main menu display";
    waitUntil
    {
        uiSleep 0.1;
        _display = call _fnc_findMenuDisplay;
        !isNull _display
    };
};

if (isNull (_display displayCtrl 1009)) then
{
    private _menuDisplay = call _fnc_findMenuDisplay;
    if (!isNull (_menuDisplay displayCtrl 1009)) then
    {
        _display = _menuDisplay;
    };
};

diag_log format ["[DB_MAINMENU] initIntro display ready: %1", _display];

setViewDistance 10;
setObjectViewDistance 10;

if (!isNull player) then
{
    player allowDamage false;
    player setPos [worldSize / 2, worldSize / 2, 0];
};

private _oldSlideHandle = missionNamespace getVariable ["DB_mainMenuSlideHandle", scriptNull];
if (!isNull _oldSlideHandle) then
{
    terminate _oldSlideHandle;
};

private _oldMusicHandle = missionNamespace getVariable ["DB_mainMenuMusicHandle", scriptNull];
if (!isNull _oldMusicHandle) then
{
    terminate _oldMusicHandle;
};

private _musicHandle = [_display] spawn
{
    disableSerialization;
    params ["_display"];

    private _track = "DB_MainMenu_Fonk";
    private _trackDuration = 159;

    diag_log "[DB_MAINMENU] music loop started";

    while { !isNull _display } do
    {
        0 fadeMusic 1;
        playMusic [_track, 0];
        diag_log format ["[DB_MAINMENU] playMusic requested: %1", _track];

        private _restartAt = diag_tickTime + _trackDuration;
        waitUntil
        {
            uiSleep 1;
            isNull _display || { diag_tickTime >= _restartAt }
        };
    };

    playMusic "";
    diag_log "[DB_MAINMENU] music loop stopped";
};

missionNamespace setVariable ["DB_mainMenuMusicHandle", _musicHandle];

private _slideHandle = [_display] spawn
{
    disableSerialization;
    params ["_display"];

    private _pictures =
    [
        "\zzzzzzzz_mainmenu\pictures\Screen_1.paa",
        "\zzzzzzzz_mainmenu\pictures\Screen_2.paa",
        "\zzzzzzzz_mainmenu\pictures\Screen_3.paa",
        "\zzzzzzzz_mainmenu\pictures\Screen_4.paa",
        "\zzzzzzzz_mainmenu\pictures\Screen_5.paa",
        "\zzzzzzzz_mainmenu\pictures\Screen_6.paa"
    ];

    private _currentCtrl = _display displayCtrl 1009;
    private _nextCtrl = _display displayCtrl 1010;

    diag_log "[DB_MAINMENU] slideshow loop started";

    private _controlsTimeout = diag_tickTime + 5;
    waitUntil
    {
        uiSleep 0.1;
        _currentCtrl = _display displayCtrl 1009;
        _nextCtrl = _display displayCtrl 1010;
        isNull _display || { (!isNull _currentCtrl && { !isNull _nextCtrl }) || { diag_tickTime >= _controlsTimeout } }
    };

    if (isNull _currentCtrl || { isNull _nextCtrl }) exitWith
    {
        diag_log "[DB_MAINMENU] Slideshow controls 1009/1010 are missing";
    };

    diag_log "[DB_MAINMENU] slideshow controls ready";

    private _frame = [safeZoneXAbs, safeZoneY, safeZoneWAbs, safeZoneH];
    private _offLeft = [safeZoneXAbs - safeZoneWAbs, safeZoneY, safeZoneWAbs, safeZoneH];
    private _offRight = [safeZoneXAbs + safeZoneWAbs, safeZoneY, safeZoneWAbs, safeZoneH];
    private _holdTime = 5;
    private _transitionTime = 1.5;
    private _nextPicture = 1;

    _currentCtrl ctrlShow true;
    _nextCtrl ctrlShow true;
    _currentCtrl ctrlSetFade 0;
    _nextCtrl ctrlSetFade 0;
    _currentCtrl ctrlSetText (_pictures # 0);
    _currentCtrl ctrlSetPosition _frame;
    _nextCtrl ctrlSetPosition _offRight;
    _currentCtrl ctrlCommit 0;
    _nextCtrl ctrlCommit 0;

    while { !isNull _display } do
    {
        uiSleep _holdTime;
        if (isNull _display) exitWith {};

        _nextCtrl ctrlSetText (_pictures # _nextPicture);
        _nextCtrl ctrlSetPosition _offRight;
        _nextCtrl ctrlCommit 0;

        uiSleep 0.05;
        if (isNull _display) exitWith {};

        _currentCtrl ctrlSetPosition _offLeft;
        _nextCtrl ctrlSetPosition _frame;
        _currentCtrl ctrlCommit _transitionTime;
        _nextCtrl ctrlCommit _transitionTime;

        uiSleep _transitionTime;
        if (isNull _display) exitWith {};

        _currentCtrl ctrlSetText "";
        _currentCtrl ctrlSetPosition _offRight;
        _currentCtrl ctrlCommit 0;

        private _oldCtrl = _currentCtrl;
        _currentCtrl = _nextCtrl;
        _nextCtrl = _oldCtrl;
        _nextPicture = (_nextPicture + 1) mod (count _pictures);
    };
};

missionNamespace setVariable ["DB_mainMenuSlideHandle", _slideHandle];
