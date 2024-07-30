#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

params ["_actionInfo"];

private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
private _allItems = [_player, true, true, true, true, true, true] call CBA_fnc_uniqueUnitItems;

_allItems = _allItems select { _x in ["Mavic_Vog25", "Mavic_F1", "Mavic_tbg", "mavick_M67_Impact_Grenade", "mavick_V40_Impact_Grenade", "Mavic_M433"] };

if (_allItems isEqualTo []) exitWith { systemChat "There are no suitable grenades in inventory, please use grenades from the Mavic 3 drop mod." };

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
_display displayAddEventHandler ["Unload", { ["UNLOAD"] call mavic_drop_fnc_dynamicBlurToggle; }];

["ONLOAD"] call mavic_drop_fnc_dynamicBlurToggle;

private _mainText = _display ctrlCreate ["ctrlStructuredText", -1];
_mainText ctrlSetPosition [safeZoneXAbs, safeZoneY + GRID_H(3), safeZoneWAbs, GRID_H(3)];
_mainText ctrlSetStructuredText parseText "<t font='PuristaLight' align='center'>Attach Grenades</t>";
_mainText ctrlSetFontHeight (GRID_H(1.3));
_mainText ctrlCommit 0.0;

private _radius = GRID_H(8);
private _sizeW = GRID_W(3);
private _sizeH = GRID_H(3);

private _count = count _allItems;
for "_i" from 0 to _count - 1 do {
    private _angle = deg(_i * (2 * pi / _count));
    private _grenade = _allItems select _i;

    private _x = 0.5 + (_radius * cos(_angle)) - (_sizeW / 2);
    private _y = 0.5 + (_radius * sin(_angle)) - (_sizeH / 2);

    private _pictureButton = _display ctrlCreate ["ctrlButtonPictureKeepAspect", -1];
    _pictureButton ctrlSetText (getText(configFile >> "CfgMagazines" >> _grenade >> "picture"));
    _pictureButton ctrlSetBackgroundColor [0, 0, 0, 0];
    _pictureButton ctrlSetPosition [_x, _y, _sizeW, _sizeH];
    _pictureButton setVariable ["mavic_ui_allData", [_actionInfo, _grenade, _display]];
    _pictureButton ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];

        private _data = _control getVariable ["mavic_ui_allData", []];
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

        _data params ["_actionInfo", "_grenade", "_display"];
        _actionInfo params ["_target", "_caller", "_actionId", "_arguments"];

        private _grenadeAmmo = getText(configFile >> "CfgMagazines" >> _grenade >> "ammo");
        private _currentGrenadeMass = getNumber(configFile >> "CfgAmmo" >> _grenadeAmmo >> "mavic_weight");

        private _grenades = _target getVariable ["grenadeObj", []];
        private _totalMass = 0;

        {
            _x params ["", "_grenadeAmmo"];

            private _grenadeMass = getNumber(configFile >> "CfgAmmo" >> _grenadeAmmo >> "mavic_weight");
            _totalMass = _totalMass + _grenadeMass;
        } forEach _grenades + [["", _grenadeAmmo]];

        if (_totalMass > 750) exitWith { systemChat "The grenade's weight exceeds the maximum load capacity." }; // 750 hardcoded

        _target removeAction _actionId;
        _player removeMagazineGlobal _grenade;
        // _target setVariable ["grenadeType", _backupGrenade];

        [_target, _grenade] call mavic_drop_fnc_initDrone;

        _display closeDisplay 1;
    }];

    _pictureButton ctrlCommit 0;

    private _pictureText = _display ctrlCreate ["ctrlStructuredText", -1];
    _pictureText ctrlSetPosition [_x, _y + _sizeH + GRID_H(0.2), _sizeW, GRID_H(2)];
    _pictureText ctrlSetStructuredText parseText format ["<t font='PuristaMedium' align='center'>%1</t>", getText(configFile >> "CfgMagazines" >> _grenade >> "displayName")];
    _pictureText ctrlSetFontHeight (GRID_H(0.8));
    _pictureText ctrlCommit 0.0;
};