#define GRID_W( num ) ( num * ( pixelGridNoUIScale * pixelW * 2 ))
#define GRID_H( num ) ( num * ( pixelGridNoUIScale * pixelH * 2 ))

params ["_target"];

private _iterationGreandes = _target getVariable ["grenadeObj", []];
private _attachedGrenades = attachedObjects _target;

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
_display displayAddEventHandler ["Unload", { ["UNLOAD"] call mavic_drop_fnc_dynamicBlurToggle; }];

["ONLOAD"] call mavic_drop_fnc_dynamicBlurToggle;

private _mainText = _display ctrlCreate ["ctrlStructuredText", -1];
_mainText ctrlSetPosition [safeZoneXAbs, safeZoneY + GRID_H(3), safeZoneWAbs, GRID_H(3)];
_mainText ctrlSetStructuredText parseText "<t font='PuristaLight' align='center'>Detach Grenades</t>";
_mainText ctrlSetFontHeight (GRID_H(1.3));
_mainText ctrlCommit 0.0;

private _radius = GRID_H(8);
private _sizeW = GRID_W(3);
private _sizeH = GRID_H(3);

private _count = count _iterationGreandes;
for "_i" from 0 to _count - 1 do {
    private _angle = deg(_i * (2 * pi / _count));
    private _grenade = (_iterationGreandes select _i) select 0;

    private _x = 0.5 + (_radius * cos(_angle)) - (_sizeW / 2);
    private _y = 0.5 + (_radius * sin(_angle)) - (_sizeH / 2);

    private _pictureButton = _display ctrlCreate ["ctrlButtonPictureKeepAspect", -1];
    _pictureButton ctrlSetText (getText(configFile >> "CfgMagazines" >> _grenade >> "picture"));
    _pictureButton ctrlSetBackgroundColor [0, 0, 0, 0];
    _pictureButton ctrlSetPosition [_x, _y, _sizeW, _sizeH];
    _pictureButton setVariable ["mavic_ui_allData", [_target, _attachedGrenades select _i, _grenade, _display]];
    _pictureButton ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];

        private _data = _control getVariable ["mavic_ui_allData", []];
        private _player = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

        _data params ["_target", "_grenade", "_grenadeMagazine", "_display"];

        _player addMagazineGlobal _grenadeMagazine;

        private _grenades = _target getVariable ["grenadeObj", []];

        _grenades deleteAt (_grenades findIf { (typeOf _grenade) in _x });
        
        deleteVehicle _grenade;

        _target setVariable ["grenadeObj", _grenades, true];

        _display closeDisplay 1;
    }];

    _pictureButton ctrlCommit 0;

    private _pictureText = _display ctrlCreate ["ctrlStructuredText", -1];
    _pictureText ctrlSetPosition [_x, _y + _sizeH + GRID_H(0.2), _sizeW, GRID_H(2)];
    _pictureText ctrlSetStructuredText parseText format ["<t font='PuristaMedium' align='center'>%1</t>", getText(configFile >> "CfgMagazines" >> _grenade >> "displayName")];
    _pictureText ctrlSetFontHeight (GRID_H(0.8));
    _pictureText ctrlCommit 0.0;
};