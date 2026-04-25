disableSerialization;

private _oldMusicEH = missionNamespace getVariable ["DB_mainMenuMusicEH", -1];
if (_oldMusicEH >= 0) then
{
    removeMusicEventHandler ["MusicStop", _oldMusicEH];
};

private _display = displayNull;

waitUntil
{
    uiSleep 0.1;
    _display = findDisplay 0;
    !isNull _display
        && { !isNull (_display displayCtrl 1009) }
        && { !isNull (_display displayCtrl 1010) }
};

private _currentCtrl = _display displayCtrl 1009;
private _nextCtrl = _display displayCtrl 1010;

private _musicEH = addMusicEventHandler
[
    "MusicStop",
    {
        params ["_musicClassName"];

        if (_musicClassName == "DB_MainMenu_Fonk") then
        {
            playMusic "DB_MainMenu_Fonk";
        };
    }
];

missionNamespace setVariable ["DB_mainMenuMusicEH", _musicEH];
playMusic "DB_MainMenu_Fonk";

private _pictures =
[
    "\zzzzzzzz_mainmenu\pictures\Screen_1.paa",
    "\zzzzzzzz_mainmenu\pictures\Screen_2.paa",
    "\zzzzzzzz_mainmenu\pictures\Screen_3.paa",
    "\zzzzzzzz_mainmenu\pictures\Screen_4.paa",
    "\zzzzzzzz_mainmenu\pictures\Screen_5.paa",
    "\zzzzzzzz_mainmenu\pictures\Screen_6.paa"
];

private _frame = [safeZoneXAbs, safeZoneY, safeZoneWAbs, safeZoneH];
private _offLeft = [safeZoneXAbs - safeZoneWAbs, safeZoneY, safeZoneWAbs, safeZoneH];
private _offRight = [safeZoneXAbs + safeZoneWAbs, safeZoneY, safeZoneWAbs, safeZoneH];
private _nextIndex = 1;

_currentCtrl ctrlSetText (_pictures # 0);
_currentCtrl ctrlSetPosition _frame;
_nextCtrl ctrlSetPosition _offRight;
_currentCtrl ctrlCommit 0;
_nextCtrl ctrlCommit 0;

while { !isNull _display } do
{
    uiSleep 5;

    _nextCtrl ctrlSetText (_pictures # _nextIndex);
    _nextCtrl ctrlSetPosition _offRight;
    _nextCtrl ctrlCommit 0;

    uiSleep 0.05;

    _currentCtrl ctrlSetPosition _offLeft;
    _nextCtrl ctrlSetPosition _frame;
    _currentCtrl ctrlCommit 1.5;
    _nextCtrl ctrlCommit 1.5;

    uiSleep 1.5;

    _currentCtrl ctrlSetText "";
    _currentCtrl ctrlSetPosition _offRight;
    _currentCtrl ctrlCommit 0;

    private _oldCtrl = _currentCtrl;
    _currentCtrl = _nextCtrl;
    _nextCtrl = _oldCtrl;
    _nextIndex = (_nextIndex + 1) mod (count _pictures);
};

removeMusicEventHandler ["MusicStop", _musicEH];
missionNamespace setVariable ["DB_mainMenuMusicEH", -1];
playMusic "";
