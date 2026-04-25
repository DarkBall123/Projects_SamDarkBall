disableSerialization;

waitUntil { !isNull findDisplay 0 };

private _display = findDisplay 0;

setViewDistance 10;
setObjectViewDistance 10;

player allowDamage false;
player setPos [worldSize / 2, worldSize / 2, 0];

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

private _oldMusicEH = missionNamespace getVariable ["DB_mainMenuMusicEH", -1];
if (_oldMusicEH >= 0) then
{
    removeMusicEventHandler ["MusicStop", _oldMusicEH];
    missionNamespace setVariable ["DB_mainMenuMusicEH", -1];
};

private _musicHandle = [_display] spawn
{
    disableSerialization;
    params ["_display"];

    private _track = "DB_MainMenu_Fonk";
    private _musicEH = addMusicEventHandler
    [
        "MusicStop",
        {
            params ["_musicClassName"];

            if (_musicClassName == "DB_MainMenu_Fonk" && { !isNull findDisplay 0 }) then
            {
                playMusic "DB_MainMenu_Fonk";
            };
        }
    ];

    missionNamespace setVariable ["DB_mainMenuMusicEH", _musicEH];
    playMusic _track;

    waitUntil
    {
        uiSleep 1;
        isNull _display
    };

    removeMusicEventHandler ["MusicStop", _musicEH];
    missionNamespace setVariable ["DB_mainMenuMusicEH", -1];
    playMusic "";
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

    if (isNull _currentCtrl || { isNull _nextCtrl }) exitWith
    {
        diag_log "[DB_MAINMENU] Slideshow controls 1009/1010 are missing";
    };

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
