DB_JTAC_TABLET_TEXTURE = "\jtac_support\data\ui\81554433_tablet.paa";

DB_JTAC_IDC_HEADER = 8101;
DB_JTAC_IDC_STATE = 8102;
DB_JTAC_IDC_STATUS = 8103;
DB_JTAC_IDC_MODE_LASER = 8110;
DB_JTAC_IDC_MODE_MAP = 8111;
DB_JTAC_IDC_CATEGORY_LIST = 8120;
DB_JTAC_IDC_ATTACK_LIST = 8121;
DB_JTAC_IDC_MAP_STATUS = 8130;

JTAC_TabletGetLayout = {
    private _tabletH = safeZoneH * 0.94;
    private _tabletW = _tabletH * 2;
    private _maxW = safeZoneWAbs * 1.1;

    if (_tabletW > _maxW) then {
        _tabletW = _maxW;
        _tabletH = _tabletW / 2;
    };

    private _tabletX = safeZoneXAbs + ((safeZoneWAbs - _tabletW) / 2);
    private _tabletY = safeZoneY + ((safeZoneH - _tabletH) / 2);

    private _screenX = _tabletX + (_tabletW * 0.262);
    private _screenY = _tabletY + (_tabletH * 0.225);
    private _screenW = _tabletW * 0.415;
    private _screenH = _tabletH * 0.485;

    [[_tabletX, _tabletY, _tabletW, _tabletH], [_screenX, _screenY, _screenW, _screenH]]
};

JTAC_TabletDirectionText = {
    if (JtacIncomingAngle isEqualTo "RANDOM") exitWith { "RANDOM" };

    switch (JtacIncomingAngle) do {
        case 0: { "NORTH" };
        case 45: { "NORTHEAST" };
        case 90: { "EAST" };
        case 135: { "SOUTHEAST" };
        case 180: { "SOUTH" };
        case 225: { "SOUTHWEST" };
        case 270: { "WEST" };
        case 315: { "NORTHWEST" };
        default { format ["%1 DEG", round JtacIncomingAngle] };
    };
};

JTAC_TabletCreateText = {
    disableSerialization;
    params ["_display", "_idc", "_position", "_text", "_fontHeight", "_textColor", "_backgroundColor", ["_font", "PuristaMedium"]];

    private _ctrl = _display ctrlCreate ["RscText", _idc];
    _ctrl ctrlSetPosition _position;
    _ctrl ctrlSetText _text;
    _ctrl ctrlSetFont _font;
    _ctrl ctrlSetFontHeight _fontHeight;
    _ctrl ctrlSetTextColor _textColor;
    _ctrl ctrlSetBackgroundColor _backgroundColor;
    _ctrl ctrlCommit 0;
    _ctrl
};

JTAC_TabletCreateStructuredText = {
    disableSerialization;
    params ["_display", "_idc", "_position", "_text", "_backgroundColor"];

    private _ctrl = _display ctrlCreate ["RscStructuredText", _idc];
    _ctrl ctrlSetPosition _position;
    _ctrl ctrlSetBackgroundColor _backgroundColor;
    _ctrl ctrlSetStructuredText parseText _text;
    _ctrl ctrlCommit 0;
    _ctrl
};

JTAC_TabletCreateButton = {
    disableSerialization;
    params ["_display", "_idc", "_position", "_text", ["_tooltip", ""]];

    private _ctrl = _display ctrlCreate ["JTAC_TabletButton", _idc];
    _ctrl ctrlSetPosition _position;
    _ctrl ctrlSetText _text;
    _ctrl ctrlSetTooltip _tooltip;
    _ctrl ctrlCommit 0;
    _ctrl
};

JTAC_TabletCreateBase = {
    disableSerialization;

    private _oldDisplay = uiNamespace getVariable ["DB_JTAC_TabletDisplay", displayNull];
    if !(isNull _oldDisplay) then {
        _oldDisplay closeDisplay 2;
    };

    private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
    uiNamespace setVariable ["DB_JTAC_TabletDisplay", _display];
    _display displayAddEventHandler ["Unload", {
        params ["_display"];
        if ((uiNamespace getVariable ["DB_JTAC_TabletDisplay", displayNull]) isEqualTo _display) then {
            uiNamespace setVariable ["DB_JTAC_TabletDisplay", displayNull];
        };
    }];

    private _layout = call JTAC_TabletGetLayout;
    _layout params ["_tabletPos", "_screen"];
    _display setVariable ["DB_JTAC_TabletLayout", _layout];

    private _shade = _display ctrlCreate ["RscText", -1];
    _shade ctrlSetPosition [safeZoneXAbs, safeZoneY, safeZoneWAbs, safeZoneH];
    _shade ctrlSetBackgroundColor [0, 0, 0, 0.45];
    _shade ctrlCommit 0;

    private _tabletPicture = _display ctrlCreate ["RscPictureKeepAspect", -1];
    _tabletPicture ctrlSetPosition _tabletPos;
    _tabletPicture ctrlSetText DB_JTAC_TABLET_TEXTURE;
    _tabletPicture ctrlCommit 0;

    private _screenBg = _display ctrlCreate ["RscText", -1];
    _screenBg ctrlSetPosition _screen;
    _screenBg ctrlSetBackgroundColor [0.015, 0.04, 0.025, 0.88];
    _screenBg ctrlCommit 0;

    _screen params ["_sx", "_sy", "_sw", "_sh"];

    [_display, DB_JTAC_IDC_HEADER, [_sx + _sw * 0.025, _sy + _sh * 0.025, _sw * 0.58, _sh * 0.075], "VIRTUAL JTAC", _sh * 0.055, [0.74, 1, 0.72, 1], [0, 0, 0, 0], "PuristaBold"] call JTAC_TabletCreateText;
    [_display, DB_JTAC_IDC_STATE, [_sx + _sw * 0.025, _sy + _sh * 0.105, _sw * 0.95, _sh * 0.055], "", _sh * 0.034, [0.62, 0.78, 0.64, 1], [0, 0, 0, 0], "EtelkaMonospacePro"] call JTAC_TabletCreateText;

    private _close = [_display, -1, [_sx + _sw * 0.91, _sy + _sh * 0.025, _sw * 0.065, _sh * 0.07], "X", "Close tablet"] call JTAC_TabletCreateButton;
    _close ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
    }];

    [_display] call JTAC_TabletRefreshHeader;
    _display
};

JTAC_TabletRefreshHeader = {
    disableSerialization;
    params ["_display"];

    private _state = _display displayCtrl DB_JTAC_IDC_STATE;
    if !(isNull _state) then {
        private _availabilityText = "BUSY";
        if (JtacAvailable) then {
            _availabilityText = "READY";
        };
        _state ctrlSetText format ["MODE %1 | DIR %2 | %3", JtacTargetingMethod, call JTAC_TabletDirectionText, _availabilityText];
    };

    {
        _x params ["_idc", "_mode"];
        private _ctrl = _display displayCtrl _idc;
        if !(isNull _ctrl) then {
            private _selected = JtacTargetingMethod == _mode;
            private _bg = [0.06, 0.09, 0.07, 0.96];
            private _fg = [0.6, 0.78, 0.62, 1];

            if (_selected) then {
                _bg = [0.05, 0.45, 0.17, 1];
                _fg = [0.9, 1, 0.88, 1];
            };

            _ctrl ctrlSetBackgroundColor _bg;
            _ctrl ctrlSetTextColor _fg;
            _ctrl ctrlSetActiveColor _fg;
            _ctrl ctrlSetDisabledColor _fg;
            _ctrl ctrlCommit 0;
        };
    } forEach [
        [DB_JTAC_IDC_MODE_LASER, "LASER"],
        [DB_JTAC_IDC_MODE_MAP, "MAP"]
    ];
};

JTAC_TabletGetCategories = {
    private _categories = [];

    for "_i" from 1 to (count JtacMainMenu - 1) do {
        private _entry = JtacMainMenu select _i;
        private _name = _entry select 0;

        if !(_name in ["Fire Direction", "Targeting Method", "Reload Status"]) then {
            private _subLink = _entry select 2;
            if (_subLink find "#USER:" == 0) then {
                private _subVar = _subLink select [6];
                if (count (missionNamespace getVariable [_subVar, []]) > 1) then {
                    _categories pushBack [_name, _subVar];
                };
            };
        };
    };

    _categories
};

JTAC_TabletSetStatusLines = {
    disableSerialization;
    params ["_display", "_lines"];

    private _status = _display displayCtrl DB_JTAC_IDC_STATUS;
    if (isNull _status) exitWith {};

    if (count _lines == 0) then {
        _lines = ["No status data"];
    };

    _status ctrlSetStructuredText parseText format [
        "<t font='EtelkaMonospacePro' size='0.78' color='#D6F5C9'>%1</t>",
        _lines joinString "<br/>"
    ];
};

JTAC_TabletBuildHome = {
    disableSerialization;
    params ["_display"];

    private _screen = (_display getVariable "DB_JTAC_TabletLayout") select 1;
    _screen params ["_sx", "_sy", "_sw", "_sh"];

    [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.18, _sw * 0.43, _sh * 0.055], "SUPPORT PACKAGES", _sh * 0.035, [0.86, 1, 0.74, 1], [0, 0, 0, 0], "PuristaBold"] call JTAC_TabletCreateText;

    private _catList = _display ctrlCreate ["RscListbox", DB_JTAC_IDC_CATEGORY_LIST];
    _catList ctrlSetPosition [_sx + _sw * 0.025, _sy + _sh * 0.24, _sw * 0.43, _sh * 0.49];
    _catList ctrlSetFont "PuristaMedium";
    _catList ctrlSetFontHeight (_sh * 0.037);
    _catList ctrlSetBackgroundColor [0.015, 0.03, 0.022, 0.96];
    _catList ctrlCommit 0;

    {
        _x params ["_name", "_subVar"];
        private _idx = _catList lbAdd _name;
        _catList lbSetData [_idx, _subVar];
        _catList lbSetColor [_idx, [0.82, 0.95, 0.78, 1]];
    } forEach (call JTAC_TabletGetCategories);

    if ((lbSize _catList) > 0) then {
        _catList lbSetCurSel 0;
    };

    _catList ctrlAddEventHandler ["LBDblClick", {
        params ["_ctrl", "_index"];
        private _subVar = _ctrl lbData _index;
        if (_subVar != "") then {
            (ctrlParent _ctrl) closeDisplay 2;
            [_subVar] call JTAC_OpenSubMenu;
        };
    }];

    [_display, -1, [_sx + _sw * 0.50, _sy + _sh * 0.18, _sw * 0.24, _sh * 0.055], "TARGETING", _sh * 0.035, [0.86, 1, 0.74, 1], [0, 0, 0, 0], "PuristaBold"] call JTAC_TabletCreateText;

    private _btnLaser = [_display, DB_JTAC_IDC_MODE_LASER, [_sx + _sw * 0.50, _sy + _sh * 0.25, _sw * 0.22, _sh * 0.09], "LASER", "Use laser designator target acquisition"] call JTAC_TabletCreateButton;
    private _btnMap = [_display, DB_JTAC_IDC_MODE_MAP, [_sx + _sw * 0.745, _sy + _sh * 0.25, _sw * 0.22, _sh * 0.09], "MAP", "Pick ingress and target points on tablet map"] call JTAC_TabletCreateButton;

    _btnLaser ctrlAddEventHandler ["ButtonClick", {
        JtacTargetingMethod = "LASER";
        [ctrlParent (_this select 0)] call JTAC_TabletRefreshHeader;
    }];
    _btnMap ctrlAddEventHandler ["ButtonClick", {
        JtacTargetingMethod = "MAP";
        [ctrlParent (_this select 0)] call JTAC_TabletRefreshHeader;
    }];

    private _direction = [_display, -1, [_sx + _sw * 0.50, _sy + _sh * 0.37, _sw * 0.465, _sh * 0.09], format ["DIRECTION: %1", call JTAC_TabletDirectionText], "Select fire ingress direction"] call JTAC_TabletCreateButton;
    _direction ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
        [] call JTAC_OpenDirectionMenu;
    }];

    [_display, DB_JTAC_IDC_STATUS, [_sx + _sw * 0.50, _sy + _sh * 0.49, _sw * 0.465, _sh * 0.24], "<t font='EtelkaMonospacePro' size='0.78' color='#D6F5C9'>Press STATUS to query reload state.</t>", [0.015, 0.03, 0.022, 0.96]] call JTAC_TabletCreateStructuredText;

    private _open = [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "OPEN", "Open selected support package"] call JTAC_TabletCreateButton;
    _open ctrlAddEventHandler ["ButtonClick", {
        private _display = ctrlParent (_this select 0);
        private _list = _display displayCtrl DB_JTAC_IDC_CATEGORY_LIST;
        private _index = lbCurSel _list;
        if (_index < 0) exitWith { hint "Select a support package first"; };

        private _subVar = _list lbData _index;
        _display closeDisplay 2;
        [_subVar] call JTAC_OpenSubMenu;
    }];

    private _status = [_display, -1, [_sx + _sw * 0.36, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "STATUS", "Query reload status from server"] call JTAC_TabletCreateButton;
    _status ctrlAddEventHandler ["ButtonClick", {
        private _display = ctrlParent (_this select 0);
        [_display, ["Requesting reload state..."]] call JTAC_TabletSetStatusLines;
        player remoteExec ["GET_RELOAD_STATUS_ARRAY", 2, false];
    }];

    private _close = [_display, -1, [_sx + _sw * 0.685, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "CLOSE", "Close tablet"] call JTAC_TabletCreateButton;
    _close ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
    }];

    [_display] call JTAC_TabletRefreshHeader;
};

JTAC_OpenMainUI = {
    disableSerialization;

    if (!JtacAvailable) exitWith {
        hint "JTAC currently unavailable (reload in progress)";
    };

    private _display = call JTAC_TabletCreateBase;
    [_display] call JTAC_TabletBuildHome;
};

JTAC_OpenSubMenu = {
    disableSerialization;
    params ["_subMenuVar"];

    private _subMenu = missionNamespace getVariable [_subMenuVar, []];
    if (count _subMenu < 2) exitWith {};

    private _display = call JTAC_TabletCreateBase;
    private _screen = (_display getVariable "DB_JTAC_TabletLayout") select 1;
    _screen params ["_sx", "_sy", "_sw", "_sh"];

    private _title = _subMenu select 0 select 0;
    [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.18, _sw * 0.72, _sh * 0.06], _title, _sh * 0.04, [0.86, 1, 0.74, 1], [0, 0, 0, 0], "PuristaBold"] call JTAC_TabletCreateText;

    private _list = _display ctrlCreate ["RscListbox", DB_JTAC_IDC_ATTACK_LIST];
    _list ctrlSetPosition [_sx + _sw * 0.025, _sy + _sh * 0.26, _sw * 0.95, _sh * 0.48];
    _list ctrlSetFont "PuristaMedium";
    _list ctrlSetFontHeight (_sh * 0.037);
    _list ctrlSetBackgroundColor [0.015, 0.03, 0.022, 0.96];
    _list ctrlCommit 0;

    for "_i" from 1 to (count _subMenu - 1) do {
        private _item = _subMenu select _i;
        private _name = _item select 0;
        private _exprArray = _item select 4;
        private _expression = _exprArray select 0 select 1;

        private _idx = _list lbAdd _name;
        _list lbSetData [_idx, _expression];
        _list lbSetColor [_idx, [0.82, 0.95, 0.78, 1]];
    };

    if ((lbSize _list) > 0) then {
        _list lbSetCurSel 0;
    };

    _list ctrlAddEventHandler ["LBDblClick", {
        params ["_ctrl", "_index"];
        [_ctrl, _index] call JTAC_TabletExecuteAttackSelection;
    }];

    private _back = [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "< BACK", "Return to main tablet screen"] call JTAC_TabletCreateButton;
    _back ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
        [] call JTAC_OpenMainUI;
    }];

    private _fire = [_display, -1, [_sx + _sw * 0.36, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "REQUEST", "Request selected fire mission"] call JTAC_TabletCreateButton;
    _fire ctrlAddEventHandler ["ButtonClick", {
        private _display = ctrlParent (_this select 0);
        private _list = _display displayCtrl DB_JTAC_IDC_ATTACK_LIST;
        [_list, lbCurSel _list] call JTAC_TabletExecuteAttackSelection;
    }];

    private _close = [_display, -1, [_sx + _sw * 0.685, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "CLOSE", "Close tablet"] call JTAC_TabletCreateButton;
    _close ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
    }];
};

JTAC_TabletExecuteAttackSelection = {
    disableSerialization;
    params ["_ctrl", "_index"];

    if (_index < 0) exitWith {
        hint "Select a fire mission first";
    };

    private _expression = _ctrl lbData _index;
    if (_expression != "") then {
        (ctrlParent _ctrl) closeDisplay 2;
        call compile _expression;
    };
};

JTAC_OpenDirectionMenu = {
    disableSerialization;

    private _display = call JTAC_TabletCreateBase;
    private _screen = (_display getVariable "DB_JTAC_TabletLayout") select 1;
    _screen params ["_sx", "_sy", "_sw", "_sh"];

    [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.18, _sw * 0.78, _sh * 0.06], "FIRE DIRECTION", _sh * 0.04, [0.86, 1, 0.74, 1], [0, 0, 0, 0], "PuristaBold"] call JTAC_TabletCreateText;

    private _directions = [
        ["RANDOM", "RANDOM"],
        ["N", 0],
        ["NE", 45],
        ["E", 90],
        ["SE", 135],
        ["S", 180],
        ["SW", 225],
        ["W", 270],
        ["NW", 315]
    ];

    private _startX = _sx + _sw * 0.08;
    private _startY = _sy + _sh * 0.29;
    private _btnW = _sw * 0.25;
    private _btnH = _sh * 0.105;
    private _gapX = _sw * 0.04;
    private _gapY = _sh * 0.035;

    {
        _x params ["_label", "_value"];
        private _col = _forEachIndex % 3;
        private _row = floor (_forEachIndex / 3);
        private _button = [_display, -1, [_startX + ((_btnW + _gapX) * _col), _startY + ((_btnH + _gapY) * _row), _btnW, _btnH], _label, "Set fire ingress direction"] call JTAC_TabletCreateButton;
        _button setVariable ["DB_JTAC_DirectionValue", _value];
        _button ctrlAddEventHandler ["ButtonClick", {
            private _button = _this select 0;
            JtacIncomingAngle = _button getVariable ["DB_JTAC_DirectionValue", "RANDOM"];
            private _display = ctrlParent _button;
            [_display] call JTAC_TabletRefreshHeader;
            hintSilent format ["Fire direction: %1", call JTAC_TabletDirectionText];
        }];
    } forEach _directions;

    private _back = [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "< BACK", "Return to main tablet screen"] call JTAC_TabletCreateButton;
    _back ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
        [] call JTAC_OpenMainUI;
    }];

    private _close = [_display, -1, [_sx + _sw * 0.685, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "CLOSE", "Close tablet"] call JTAC_TabletCreateButton;
    _close ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
    }];
};

JTAC_TabletSetMapStatus = {
    disableSerialization;
    params ["_display", "_text"];

    private _ctrl = _display displayCtrl DB_JTAC_IDC_MAP_STATUS;
    if !(isNull _ctrl) then {
        _ctrl ctrlSetText _text;
    };
};

JTAC_TabletGetMapPositions = {
    disableSerialization;

    jtacIngressSet = false;
    jtacIngressPosition = [-1, -1, -1];
    jtacTargetSet = false;
    jtacTarget = [-1, -1, -1];

    deleteMarkerLocal "jtacIngressMarker";
    deleteMarkerLocal "jtacTargetMarker";

    private _display = call JTAC_TabletCreateBase;
    _display setVariable ["DB_JTAC_MapDone", false];

    private _screen = (_display getVariable "DB_JTAC_TabletLayout") select 1;
    _screen params ["_sx", "_sy", "_sw", "_sh"];

    [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.17, _sw * 0.64, _sh * 0.055], "MAP TARGETING", _sh * 0.035, [0.86, 1, 0.74, 1], [0, 0, 0, 0], "PuristaBold"] call JTAC_TabletCreateText;
    [_display, DB_JTAC_IDC_MAP_STATUS, [_sx + _sw * 0.50, _sy + _sh * 0.17, _sw * 0.47, _sh * 0.055], "SELECT INGRESS", _sh * 0.032, [0.74, 1, 0.72, 1], [0, 0, 0, 0], "EtelkaMonospacePro"] call JTAC_TabletCreateText;

    private _map = _display ctrlCreate ["RscMapControl", -1];
    _map ctrlMapSetPosition [_sx + _sw * 0.025, _sy + _sh * 0.245, _sw * 0.95, _sh * 0.50];
    _map ctrlMapAnimAdd [0, 0.08, player];
    ctrlMapAnimCommit _map;
    _map ctrlMapCursor ["", "Track"];
    _map ctrlAddEventHandler ["MouseButtonDown", {
        params ["_map", "_button", "_xPos", "_yPos"];

        if (_button != 0) exitWith { false };

        private _display = ctrlParent _map;
        private _pos2D = _map ctrlMapScreenToWorld [_xPos, _yPos];
        private _pos = [_pos2D select 0, _pos2D select 1, 0];

        if (!jtacIngressSet) exitWith {
            jtacIngressPosition = _pos;
            jtacIngressSet = true;
            deleteMarkerLocal "jtacIngressMarker";
            createMarkerLocal ["jtacIngressMarker", _pos];
            "jtacIngressMarker" setMarkerTextLocal "Ingress";
            "jtacIngressMarker" setMarkerTypeLocal "selector_selectable";
            [_display, "SELECT TARGET"] call JTAC_TabletSetMapStatus;
            true
        };

        if (!jtacTargetSet) exitWith {
            jtacTarget = _pos;
            jtacTargetSet = true;
            deleteMarkerLocal "jtacTargetMarker";
            createMarkerLocal ["jtacTargetMarker", _pos];
            "jtacTargetMarker" setMarkerTextLocal "Target";
            "jtacTargetMarker" setMarkerTypeLocal "mil_destroy";
            [_display, "TARGET SENT"] call JTAC_TabletSetMapStatus;
            _display setVariable ["DB_JTAC_MapDone", true];
            true
        };

        true
    }];

    private _reset = [_display, -1, [_sx + _sw * 0.025, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "RESET", "Clear map points"] call JTAC_TabletCreateButton;
    _reset ctrlAddEventHandler ["ButtonClick", {
        private _display = ctrlParent (_this select 0);
        jtacIngressSet = false;
        jtacIngressPosition = [-1, -1, -1];
        jtacTargetSet = false;
        jtacTarget = [-1, -1, -1];
        deleteMarkerLocal "jtacIngressMarker";
        deleteMarkerLocal "jtacTargetMarker";
        [_display, "SELECT INGRESS"] call JTAC_TabletSetMapStatus;
    }];

    private _cancel = [_display, -1, [_sx + _sw * 0.685, _sy + _sh * 0.78, _sw * 0.28, _sh * 0.09], "CANCEL", "Cancel map targeting"] call JTAC_TabletCreateButton;
    _cancel ctrlAddEventHandler ["ButtonClick", {
        (ctrlParent (_this select 0)) closeDisplay 2;
    }];

    waitUntil {
        sleep 0.1;
        (isNull _display) || { _display getVariable ["DB_JTAC_MapDone", false] }
    };

    private _targetAcquired = jtacIngressSet && jtacTargetSet;
    private _result = [false];

    if (_targetAcquired) then {
        private _posDiff = jtacIngressPosition vectorDiff jtacTarget;
        private _dX = _posDiff select 0;
        private _dY = _posDiff select 1;
        private _ingressDirection = _dX atan2 _dY;
        _ingressDirection = (_ingressDirection + 360) % 360;
        JtacIncomingAngle = _ingressDirection;

        _result = [true, [jtacTarget select 0, jtacTarget select 1, getTerrainHeightASL jtacTarget]];

        0 = [] spawn {
            sleep 30;
            deleteMarkerLocal "jtacIngressMarker";
            deleteMarkerLocal "jtacTargetMarker";
        };
    } else {
        deleteMarkerLocal "jtacIngressMarker";
        deleteMarkerLocal "jtacTargetMarker";
    };

    if !(isNull _display) then {
        _display closeDisplay 1;
    };

    _result
};

JTAC_GET_MAP_POSITIONS = {
    call JTAC_TabletGetMapPositions
};

if ((isNil "DB_fnc_jtacDisplayReloadStatusSitrep") && { !(isNil "CLIENT_DISPLAY_RELOAD_STATUS") }) then {
    DB_fnc_jtacDisplayReloadStatusSitrep = CLIENT_DISPLAY_RELOAD_STATUS;
};
CLIENT_DISPLAY_RELOAD_STATUS = {
    disableSerialization;

    private _display = uiNamespace getVariable ["DB_JTAC_TabletDisplay", displayNull];
    if (isNull _display) exitWith {
        _this spawn BIS_fnc_EXP_camp_SITREP;
    };

    private _lines = [];
    {
        private _line = _x select 0;
        if (_line != "") then {
            _lines pushBack _line;
        };
    } forEach _this;

    [_display, _lines] call JTAC_TabletSetStatusLines;
};
