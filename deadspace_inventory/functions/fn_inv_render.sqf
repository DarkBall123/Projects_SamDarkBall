disableSerialization;

if !(uiNamespace getVariable ["DB_dsi_isOpen", false]) exitWith {};

private _display = findDisplay 46;
if (isNull _display) exitWith {};

private _context = uiNamespace getVariable ["DB_dsi_context", []];
if (_context isEqualTo []) exitWith {
    call DB_dsi_fnc_inv_close;
};

_context params ["_source", "_anchor", "_sourceIcon", "_sourceLabel", "_panels"];

if (isNull _source || {isNull _anchor}) exitWith {
    call DB_dsi_fnc_inv_close;
};

private _maxDistance = 4.5;
private _distanceToSource = player distance _source;
if (_distanceToSource > _maxDistance) exitWith {
    call DB_dsi_fnc_inv_close;
};

private _panelIndex = uiNamespace getVariable ["DB_dsi_panelIndex", 0];
if (_panelIndex >= count _panels) then {
    _panelIndex = 0;
    uiNamespace setVariable ["DB_dsi_panelIndex", 0];
};

private _panel = _panels param [_panelIndex, []];
if (_panel isEqualTo []) exitWith {
    call DB_dsi_fnc_inv_close;
};

private _safeLeft = safeZoneX;
private _safeTop = safeZoneY;
private _safeWidth = safeZoneW;
private _safeHeight = safeZoneH;
private _screenCenter = [
    _safeLeft + (_safeWidth * 0.5),
    _safeTop + (_safeHeight * 0.5)
];

private _anchorPos = if (_anchor isKindOf "CAManBase") then {
    _anchor modelToWorldVisual [0.06, 0.04, 1.20]
} else {
    _anchor modelToWorldVisual (boundingCenter _anchor)
};

private _anchorScreen = worldToScreen _anchorPos;
if (_anchorScreen isEqualTo []) exitWith {
    call DB_dsi_fnc_inv_cleanupOverlay;
    uiNamespace setVariable ["DB_dsi_selectedOption", []];
};

if (
    (_anchorScreen # 0) < _safeLeft ||
    {(_anchorScreen # 0) > (_safeLeft + _safeWidth)} ||
    {(_anchorScreen # 1) < _safeTop} ||
    {(_anchorScreen # 1) > (_safeTop + _safeHeight)}
) exitWith {
    call DB_dsi_fnc_inv_close;
};

private _pageIndex = uiNamespace getVariable ["DB_dsi_pageIndex", 0];
private _entries = _panel # 3;
private _pageSize = 6;
private _pageCount = ((ceil ((count _entries) / _pageSize)) max 1);
private _maxPage = _pageCount - 1;
if (_pageIndex > _maxPage) then {
    _pageIndex = _maxPage;
    uiNamespace setVariable ["DB_dsi_pageIndex", _pageIndex];
};

private _layoutScale = linearConversion [0.8, _maxDistance, _distanceToSource, 1.02, 0.60, true];
private _headerH = 0.036 * _safeHeight * _layoutScale;
private _footerH = 0.060 * _safeHeight * _layoutScale;
private _cellW = 0.072 * _safeWidth * _layoutScale;
private _cellH = 0.094 * _safeHeight * _layoutScale;
private _gapX = 0.006 * _safeWidth * _layoutScale;
private _gapY = 0.009 * _safeHeight * _layoutScale;
private _tabW = 0.034 * _safeWidth * _layoutScale;
private _tabH = 0.046 * _safeHeight * _layoutScale;
private _columns = 2;
private _rows = 3;
private _gridW = (_columns * _cellW) + ((_columns - 1) * _gapX);
private _gridH = (_rows * _cellH) + ((_rows - 1) * _gapY);
private _layoutW = _tabW + _gapX + _gridW;
private _layoutH = _headerH + (0.012 * _safeHeight * _layoutScale) + _gridH + (0.010 * _safeHeight * _layoutScale) + _footerH;
private _backdropPaddingX = 0.007 * _safeWidth * _layoutScale;
private _backdropPaddingY = 0.008 * _safeHeight * _layoutScale;
private _sideOffset = 0.024 * _safeWidth;
private _openRight = (_anchorScreen # 0) < (_screenCenter # 0);
private _originX = if (_openRight) then {
    (_anchorScreen # 0) + _sideOffset
} else {
    (_anchorScreen # 0) - _layoutW - _sideOffset
};
private _originY = (_anchorScreen # 1) - (_layoutH * 0.26);

_originX = (_originX max _safeLeft) min ((_safeLeft + _safeWidth) - _layoutW);
_originY = (_originY max _safeTop) min ((_safeTop + _safeHeight) - _layoutH);

private _gridX = _originX + _tabW + _gapX;
private _gridY = _originY + _headerH + (0.012 * _safeHeight * _layoutScale);
private _footerY = _gridY + _gridH + (0.010 * _safeHeight * _layoutScale);
private _cursorIcon = "\a3\ui_f\data\IGUI\Cfg\Cursors\selected_ca.paa";
private _pulse = 0.76 + (0.12 * abs (sin (diag_tickTime * 6)));
private _isTexturePath = {
    params ["_value"];

    if (_value isEqualTo "") exitWith { false };

    private _normalized = toLowerANSI _value;

    (_normalized find "#(") isEqualTo 0 ||
    {(_normalized find "\") >= 0} ||
    {(_normalized find "/") >= 0} ||
    {(_normalized find ".paa") >= 0} ||
    {(_normalized find ".pac") >= 0} ||
    {(_normalized find ".jpg") >= 0} ||
    {(_normalized find ".jpeg") >= 0}
};

private _headerCtrls = uiNamespace getVariable ["DB_dsi_headerCtrls", []];
if ((count _headerCtrls) != 10) then {
    {
        ctrlDelete _x;
    } forEach _headerCtrls;

    _headerCtrls = [];
    uiNamespace setVariable ["DB_dsi_headerCtrls", _headerCtrls];
};

if (_headerCtrls isEqualTo []) then {
    _headerCtrls = [
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscText", -1]
    ];

    private _inputCtrl = _headerCtrls # 9;
    _inputCtrl ctrlAddEventHandler ["MouseButtonDown", { _this call DB_dsi_fnc_inv_handleMouseButtonDown }];
    _inputCtrl ctrlAddEventHandler ["MouseZChanged", { _this call DB_dsi_fnc_inv_handleMouseZChanged }];

    uiNamespace setVariable ["DB_dsi_headerCtrls", _headerCtrls];
};

_headerCtrls params [
    "_panelBgCtrl",
    "_accentCtrl",
    "_iconBgCtrl",
    "_iconCtrl",
    "_titleCtrl",
    "_metaCtrl",
    "_footerCtrl",
    "_cursorCtrl",
    "_selectionCtrl",
    "_inputCtrl"
];

_panelBgCtrl ctrlShow true;
_panelBgCtrl ctrlSetPosition [
    _originX - _backdropPaddingX,
    _originY - _backdropPaddingY,
    _layoutW + (_backdropPaddingX * 2),
    _layoutH + (_backdropPaddingY * 2)
];
_panelBgCtrl ctrlSetBackgroundColor [0, 0, 0, 0.30];
_panelBgCtrl ctrlCommit 0;

_accentCtrl ctrlShow true;
_accentCtrl ctrlSetPosition [_gridX, _originY, _gridW, 0.0024 * _safeHeight];
_accentCtrl ctrlSetBackgroundColor [0.88, 0.22, 0.22, 0.88];
_accentCtrl ctrlCommit 0;

_iconBgCtrl ctrlShow true;
_iconBgCtrl ctrlSetPosition [_originX, _originY, _tabW, _headerH];
_iconBgCtrl ctrlSetBackgroundColor [0.02, 0.02, 0.02, 0.86];
_iconBgCtrl ctrlCommit 0;

_iconCtrl ctrlShow true;
_iconCtrl ctrlSetPosition [_originX + (_tabW * 0.06), _originY + (_headerH * 0.05), _tabW * 0.88, _headerH * 0.90];
_iconCtrl ctrlSetStructuredText parseText format [
    "<t align='center'><img image='%1' size='1.22'/></t>",
    _sourceIcon
];
_iconCtrl ctrlCommit 0;

_titleCtrl ctrlShow true;
_titleCtrl ctrlSetPosition [_gridX, _originY + (0.002 * _safeHeight * _layoutScale), _gridW * 0.76, _headerH * 0.82];
_titleCtrl ctrlSetStructuredText parseText format [
    "<t font='PuristaSemibold' size='0.76' color='#F1F1F1'>%1</t>",
    toUpper _sourceLabel
];
_titleCtrl ctrlCommit 0;

_metaCtrl ctrlShow true;
_metaCtrl ctrlSetPosition [_gridX + (_gridW * 0.76), _originY + (0.002 * _safeHeight * _layoutScale), _gridW * 0.24, _headerH * 0.82];
_metaCtrl ctrlSetStructuredText parseText format [
    "<t align='right' font='PuristaLight' size='0.62' color='#CFCFCF'>%1</t>",
    if (_pageCount > 1) then {
        format ["PAGE %1/%2", _pageIndex + 1, _pageCount]
    } else {
        (_panel # 2)
    }
];
_metaCtrl ctrlCommit 0;

_footerCtrl ctrlShow true;
_footerCtrl ctrlSetPosition [_gridX, _footerY, _gridW, _footerH];
_footerCtrl ctrlCommit 0;

_cursorCtrl ctrlShow true;
private _cursorSize = 0.016 * _safeHeight;
_cursorCtrl ctrlSetPosition [
    (_screenCenter # 0) - (_cursorSize * 0.5),
    (_screenCenter # 1) - (_cursorSize * 0.5),
    _cursorSize,
    _cursorSize
];
_cursorCtrl ctrlSetStructuredText parseText format [
    "<t align='center'><img image='%1' color='#D44747' size='0.92'/></t>",
    _cursorIcon
];
_cursorCtrl ctrlCommit 0;

_selectionCtrl ctrlShow false;

_inputCtrl ctrlShow true;
_inputCtrl ctrlSetPosition [_safeLeft, _safeTop, _safeWidth, _safeHeight];
_inputCtrl ctrlSetBackgroundColor [0, 0, 0, 0];
_inputCtrl ctrlCommit 0;

private _tabCtrls = uiNamespace getVariable ["DB_dsi_tabCtrls", []];
if ((_tabCtrls findIf { (count _x) != 2 }) >= 0) then {
    {
        {
            ctrlDelete _x;
        } forEach _x;
    } forEach _tabCtrls;

    _tabCtrls = [];
};

for "_i" from count _tabCtrls to (count _panels - 1) do {
    _tabCtrls pushBack [
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscStructuredText", -1]
    ];
};
uiNamespace setVariable ["DB_dsi_tabCtrls", _tabCtrls];

private _entryCtrls = uiNamespace getVariable ["DB_dsi_entryCtrls", []];
if ((_entryCtrls findIf { (count _x) != 3 }) >= 0) then {
    {
        {
            ctrlDelete _x;
        } forEach _x;
    } forEach _entryCtrls;

    _entryCtrls = [];
};

for "_i" from count _entryCtrls to (_pageSize - 1) do {
    _entryCtrls pushBack [
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1]
    ];
};
uiNamespace setVariable ["DB_dsi_entryCtrls", _entryCtrls];

private _optionRecords = [];

{
    _x params ["_bgCtrl", "_textCtrl"];

    if (_forEachIndex < count _panels) then {
        private _tabX = _originX;
        private _tabY = _gridY + (_forEachIndex * (_tabH + _gapY));
        private _tabData = _panels # _forEachIndex;
        private _tabIcon = _tabData # 1;
        private _isActive = _forEachIndex isEqualTo _panelIndex;
        private _tabBg = if (_isActive) then {
            [0.56, 0.11, 0.11, 0.72]
        } else {
            [0.03, 0.03, 0.03, 0.74]
        };

        _bgCtrl ctrlShow true;
        _bgCtrl ctrlSetPosition [_tabX, _tabY, _tabW, _tabH];
        _bgCtrl ctrlSetBackgroundColor _tabBg;
        _bgCtrl ctrlCommit 0;

        _textCtrl ctrlShow true;
        _textCtrl ctrlSetPosition [_tabX, _tabY, _tabW, _tabH];
        if ([_tabIcon] call _isTexturePath) then {
            _textCtrl ctrlSetStructuredText parseText format [
                "<t align='center'><img image='%1' size='1.18'/></t>",
                _tabIcon
            ];
        } else {
            _textCtrl ctrlSetStructuredText parseText format [
                "<t align='center' font='PuristaSemibold' size='0.90' color='%2'>%1</t>",
                toUpper _tabIcon,
                if (_isActive) then { "#FFFFFF" } else { "#D8D8D8" }
            ];
        };
        _textCtrl ctrlCommit 0;

        _optionRecords pushBack [
            ["panel", _forEachIndex, _tabData # 2],
            [_tabX + (_tabW * 0.5), _tabY + (_tabH * 0.5)],
            [_tabX, _tabY, _tabW, _tabH]
        ];
    } else {
        _bgCtrl ctrlShow false;
        _textCtrl ctrlShow false;
    };
} forEach _tabCtrls;

private _visibleEntries = _entries select [_pageIndex * _pageSize, _pageSize];

{
    _x params ["_bgCtrl", "_iconCtrl", "_badgeCtrl"];

    if (_forEachIndex < count _visibleEntries) then {
        private _entry = _visibleEntries # _forEachIndex;
        _entry params ["_entryType", "", "_count", "_entryIcon", "_entryLabel"];

        private _col = _forEachIndex mod _columns;
        private _row = floor (_forEachIndex / _columns);
        private _xPos = _gridX + (_col * (_cellW + _gapX));
        private _yPos = _gridY + (_row * (_cellH + _gapY));
        private _bgColor = if (_entryType isEqualTo "action") then {
            [0.04, 0.04, 0.04, 0.82]
        } else {
            [0.02, 0.02, 0.02, 0.74]
        };

        _bgCtrl ctrlShow true;
        _bgCtrl ctrlSetPosition [_xPos, _yPos, _cellW, _cellH];
        _bgCtrl ctrlSetBackgroundColor _bgColor;
        _bgCtrl ctrlCommit 0;

        _iconCtrl ctrlShow true;
        _iconCtrl ctrlSetPosition [
            _xPos + (_cellW * 0.10),
            _yPos + (_cellH * 0.08),
            _cellW * 0.80,
            _cellH * 0.68
        ];
        _iconCtrl ctrlSetStructuredText parseText format [
            "<t align='center'><img image='%1' size='%2'/></t>",
            _entryIcon,
            if (_entryType isEqualTo "action") then { 1.46 } else { 1.32 }
        ];
        _iconCtrl ctrlCommit 0;

        _badgeCtrl ctrlShow true;
        _badgeCtrl ctrlSetPosition [
            _xPos + (_cellW * 0.08),
            _yPos + (_cellH * 0.72),
            _cellW * 0.84,
            _cellH * 0.18
        ];
        _badgeCtrl ctrlSetStructuredText parseText format [
            "<t align='right' font='PuristaSemibold' size='0.58' color='#F0F0F0'>%1</t>",
            if (_entryType isEqualTo "action") then {
                if (_count > 0) then { str _count } else { "" }
            } else {
                format ["x%1", _count]
            }
        ];
        _badgeCtrl ctrlCommit 0;

        _optionRecords pushBack [
            ["entry", _entry, _entryLabel],
            [_xPos + (_cellW * 0.5), _yPos + (_cellH * 0.5)],
            [_xPos, _yPos, _cellW, _cellH]
        ];
    } else {
        _bgCtrl ctrlShow false;
        _iconCtrl ctrlShow false;
        _badgeCtrl ctrlShow false;
    };
} forEach _entryCtrls;

private _selectedIndex = -1;
private _selectedDistance = 1e9;
private _selectionRadius = ((_cellW min _cellH) * 0.58) max (0.020 * _safeWidth);

{
    _x params ["", "_optionPos"];
    private _distance = _screenCenter distance2D _optionPos;
    if ((_distance < _selectionRadius) && {_distance < _selectedDistance}) then {
        _selectedDistance = _distance;
        _selectedIndex = _forEachIndex;
    };
} forEach _optionRecords;

if (_selectedIndex >= 0) then {
    private _selected = _optionRecords # _selectedIndex;
    private _selectedData = _selected # 0;
    private _selectedRect = _selected # 2;
    _selectedData params ["_kind", "_payload", "_selectedLabel"];

    uiNamespace setVariable ["DB_dsi_selectedOption", _selectedData];

    _selectionCtrl ctrlShow true;
    _selectionCtrl ctrlSetPosition [
        (_selectedRect # 0) - ((_selectedRect # 2) * 0.06),
        (_selectedRect # 1) - ((_selectedRect # 3) * 0.06),
        (_selectedRect # 2) * 1.12,
        (_selectedRect # 3) * 1.12
    ];
    _selectionCtrl ctrlSetStructuredText parseText format [
        "<t align='center'><img image='%1' color='#E04D4D' size='%2'/></t>",
        _cursorIcon,
        _pulse
    ];
    _selectionCtrl ctrlCommit 0;

    private _actionHint = "LMB / SPACE TAKE";
    if (_kind isEqualTo "panel") then {
        _actionHint = "LMB / SPACE SWITCH";
    } else {
        private _entryType = _payload # 0;
        if (_entryType isEqualTo "action") then {
            _actionHint = "LMB / SPACE ENTER";
        };
    };

    _footerCtrl ctrlSetStructuredText parseText format [
        "<t font='PuristaSemibold' size='0.62' color='#F0F0F0'>%1</t><br/><t font='PuristaLight' size='0.50' color='#C7C7C7'>%2  |  TAB PANELS  |  WHEEL PAGES</t>",
        toUpper _selectedLabel,
        _actionHint
    ];
    _footerCtrl ctrlCommit 0;

    if (_kind isEqualTo "panel") then {
        private _selectedTab = (_tabCtrls # _payload) # 0;
        _selectedTab ctrlSetBackgroundColor [0.80, 0.18, 0.18, 0.82];
        _selectedTab ctrlCommit 0;
    } else {
        private _tabCount = count _panels;
        private _entryIndex = _selectedIndex - _tabCount;
        if (_entryIndex >= 0 && {_entryIndex < count _entryCtrls}) then {
            private _selectedEntry = (_entryCtrls # _entryIndex) # 0;
            _selectedEntry ctrlSetBackgroundColor [0.36, 0.07, 0.07, 0.86];
            _selectedEntry ctrlCommit 0;
        };
    };
} else {
    uiNamespace setVariable ["DB_dsi_selectedOption", []];
    _selectionCtrl ctrlShow false;
    _footerCtrl ctrlSetStructuredText parseText "<t font='PuristaSemibold' size='0.58' color='#E0E0E0'>ALIGN RETICLE TO SLOT</t><br/><t font='PuristaLight' size='0.50' color='#BFBFBF'>LMB / SPACE SELECT  |  TAB PANELS  |  WHEEL PAGES</t>";
    _footerCtrl ctrlCommit 0;
};
