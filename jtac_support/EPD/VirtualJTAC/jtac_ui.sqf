// ================================================
//  JTAC CUSTOM UI — ПРОСТЫЕ КНОПКИ LASER / MAP
// ================================================

JTAC_UpdateModeButtons = {
    disableSerialization;
    params ["_display"];

    {
        _x params ["_idc", "_mode"];

        private _ctrl = _display displayCtrl _idc;
        if !(isNull _ctrl) then {
            private _isSelected = (JtacTargetingMethod == _mode);
            private _backgroundColor = [0.2, 0.2, 0.2, 0.9];
            private _textColor = [0.7, 0.7, 0.7, 1];

            if (_isSelected) then {
                _backgroundColor = [0.95, 0.45, 0, 1];
                _textColor = [1, 1, 1, 1];
            };

            _ctrl ctrlSetBackgroundColor _backgroundColor;
            _ctrl ctrlSetTextColor _textColor;
            _ctrl ctrlSetActiveColor _textColor;
            _ctrl ctrlCommit 0;
        };
    } forEach [
        [1100, "LASER"],
        [1101, "MAP"]
    ];
};

JTAC_OpenMainUI = {
    disableSerialization;

    if (!JtacAvailable) exitWith { hint "JTAC currently unavailable (reload in progress)"; };

    private _disp = findDisplay 46 createDisplay "RscDisplayEmpty";

    // Фон
    private _bg = _disp ctrlCreate ["RscText", 1000];
    _bg ctrlSetPosition [safeZoneX + 0.23 * safeZoneW, safeZoneY + 0.16 * safeZoneH, 0.54 * safeZoneW, 0.72 * safeZoneH];
    _bg ctrlSetBackgroundColor [0, 0, 0, 0.92];
    _bg ctrlCommit 0;

    // Заголовок
    private _title = _disp ctrlCreate ["RscText", 1001];
    _title ctrlSetPosition [safeZoneX + 0.26 * safeZoneW, safeZoneY + 0.19 * safeZoneH, 0.48 * safeZoneW, 0.06 * safeZoneH];
    _title ctrlSetText "VIRTUAL JTAC — SUPPORT REQUEST";
    _title ctrlSetTextColor [1, 0.85, 0, 1];
    _title ctrlSetFont "PuristaBold";
    _title ctrlSetFontHeight (safeZoneH * 0.038);
    _title ctrlCommit 0;

    // ====================== КНОПКА LASER (ЛЕВЫЙ ВЕРХНИЙ УГОЛ) ======================
    private _btnLaser = _disp ctrlCreate ["RscButton", 1100];
    _btnLaser ctrlSetPosition [safeZoneX + 0.26 * safeZoneW, safeZoneY + 0.27 * safeZoneH, 0.20 * safeZoneW, 0.06 * safeZoneH];
    _btnLaser ctrlSetText "LASER";
    _btnLaser ctrlSetFont "PuristaBold";
    _btnLaser ctrlSetFontHeight (safeZoneH * 0.033);
    _btnLaser ctrlCommit 0;

    // ====================== КНОПКА MAP (ПРАВЫЙ ВЕРХНИЙ УГОЛ) ======================
    private _btnMap = _disp ctrlCreate ["RscButton", 1101];
    _btnMap ctrlSetPosition [safeZoneX + 0.54 * safeZoneW, safeZoneY + 0.27 * safeZoneH, 0.20 * safeZoneW, 0.06 * safeZoneH];
    _btnMap ctrlSetText "MAP";
    _btnMap ctrlSetFont "PuristaBold";
    _btnMap ctrlSetFontHeight (safeZoneH * 0.033);
    _btnMap ctrlCommit 0;

    // Нажатие на LASER
    _btnLaser ctrlAddEventHandler ["ButtonClick", {
        JtacTargetingMethod = "LASER";
        hintSilent "Targeting: LASER";
        [ctrlParent (_this select 0)] call JTAC_UpdateModeButtons;
    }];

    // Нажатие на MAP
    _btnMap ctrlAddEventHandler ["ButtonClick", {
        JtacTargetingMethod = "MAP";
        hintSilent "Targeting: MAP";
        [ctrlParent (_this select 0)] call JTAC_UpdateModeButtons;
    }];

    _btnLaser ctrlAddEventHandler ["MouseExit", {
        [ctrlParent (_this select 0)] call JTAC_UpdateModeButtons;
    }];

    _btnMap ctrlAddEventHandler ["MouseExit", {
        [ctrlParent (_this select 0)] call JTAC_UpdateModeButtons;
    }];

    // Кнопка закрытия
    private _close = _disp ctrlCreate ["RscButton", 1002];
    _close ctrlSetPosition [safeZoneX + 0.73 * safeZoneW, safeZoneY + 0.19 * safeZoneH, 0.04 * safeZoneW, 0.04 * safeZoneH];
    _close ctrlSetText "✕";
    _close ctrlSetTextColor [1, 0.3, 0.3, 1];
    _close ctrlAddEventHandler ["ButtonClick", { (ctrlParent (_this select 0)) closeDisplay 2; }];
    _close ctrlCommit 0;

    // ====================== КАТЕГОРИИ ======================
    private _categories = [];
    for "_i" from 1 to (count JtacMainMenu - 1) do {
        private _entry = JtacMainMenu select _i;
        private _name = _entry select 0;
        if (_name in ["Fire Direction","Targeting Method","Reload Status"]) then { continue; };

        private _subLink = _entry select 2;
        if (_subLink find "#USER:" == 0) then {
            private _subVar = _subLink select [6];
            if (count (missionNamespace getVariable [_subVar, []]) > 1) then {
                _categories pushBack [_name, _subVar];
            };
        };
    };

    private _y = 0.36;
    private _btnH = 0.048;

    {
        _x params ["_catName", "_subVar"];

        private _btn = _disp ctrlCreate ["RscButton", 2000 + _forEachIndex];
        _btn ctrlSetPosition [safeZoneX + 0.26 * safeZoneW, safeZoneY + _y * safeZoneH, 0.48 * safeZoneW, _btnH * safeZoneH];
        _btn ctrlSetText _catName;
        _btn ctrlSetFont "PuristaMedium";
        _btn ctrlSetFontHeight (safeZoneH * 0.032);
        _btn ctrlSetBackgroundColor [0.15, 0.15, 0.15, 0.95];

        _btn ctrlAddEventHandler ["ButtonClick", format ["
            private _d = ctrlParent (_this select 0);
            _d closeDisplay 2;
            ['%1'] call JTAC_OpenSubMenu;
        ", _subVar]];

        _btn ctrlCommit 0;

        _y = _y + _btnH + 0.008;
    } forEach _categories;

    // Устанавливаем начальный цвет в зависимости от текущего режима
    [_disp] call JTAC_UpdateModeButtons;
};

// ================================================
//  ВТОРОЕ ОКНО — список поддержек
// ================================================

JTAC_OpenSubMenu = {
    disableSerialization;
    params ["_subMenuVar"];

    private _subMenu = missionNamespace getVariable [_subMenuVar, []];
    if (count _subMenu < 2) exitWith {};

    private _disp = findDisplay 46 createDisplay "RscDisplayEmpty";

    private _bg = _disp ctrlCreate ["RscText", 3000];
    _bg ctrlSetPosition [safeZoneX + 0.25 * safeZoneW, safeZoneY + 0.25 * safeZoneH, 0.5 * safeZoneW, 0.55 * safeZoneH];
    _bg ctrlSetBackgroundColor [0,0,0,0.92];
    _bg ctrlCommit 0;

    private _title = _disp ctrlCreate ["RscText", 3001];
    _title ctrlSetPosition [safeZoneX + 0.28 * safeZoneW, safeZoneY + 0.27 * safeZoneH, 0.44 * safeZoneW, 0.05 * safeZoneH];
    _title ctrlSetText (_subMenu select 0 select 0);
    _title ctrlSetTextColor [1, 0.85, 0, 1];
    _title ctrlSetFont "PuristaBold";
    _title ctrlSetFontHeight (safeZoneH * 0.035);
    _title ctrlCommit 0;

    private _back = _disp ctrlCreate ["RscButton", 3002];
    _back ctrlSetPosition [safeZoneX + 0.28 * safeZoneW, safeZoneY + 0.74 * safeZoneH, 0.2 * safeZoneW, 0.05 * safeZoneH];
    _back ctrlSetText "← BACK";
    _back ctrlAddEventHandler ["ButtonClick", { (ctrlParent (_this select 0)) closeDisplay 2; [] call JTAC_OpenMainUI; }];
    _back ctrlCommit 0;

    private _list = _disp ctrlCreate ["RscListbox", 3003];
    _list ctrlSetPosition [safeZoneX + 0.28 * safeZoneW, safeZoneY + 0.34 * safeZoneH, 0.44 * safeZoneW, 0.38 * safeZoneH];
    _list ctrlSetBackgroundColor [0.05, 0.05, 0.05, 0.95];
    _list ctrlCommit 0;

    for "_i" from 1 to (count _subMenu - 1) do {
        private _item = _subMenu select _i;
        private _name = _item select 0;
        private _exprArray = _item select 4;
        private _expression = _exprArray select 0 select 1;

        private _idx = _list lbAdd _name;
        _list lbSetData [_idx, _expression];
    };

    _list ctrlAddEventHandler ["LBDblClick", {
        params ["_ctrl", "_index"];
        private _expression = _ctrl lbData _index;
        if (_expression != "") then {
            (ctrlParent _ctrl) closeDisplay 2;
            call compile _expression;
        };
    }];
};
