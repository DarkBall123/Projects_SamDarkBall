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

if (player distance _source > 8) exitWith {
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

private _anchorPos = if (_anchor isKindOf "CAManBase") then {
    _anchor modelToWorldVisual [0, 0.1, 1.15]
} else {
    _anchor modelToWorldVisual (boundingCenter _anchor)
};

private _anchorScreen = worldToScreen _anchorPos;
if (_anchorScreen isEqualTo []) exitWith {
    call DB_dsi_fnc_inv_cleanupOverlay;
    uiNamespace setVariable ["DB_dsi_selectedOption", []];
};

private _pageIndex = uiNamespace getVariable ["DB_dsi_pageIndex", 0];
private _entries = _panel # 3;
private _pageSize = call DB_dsi_fnc_inv_getPageSize;
private _pageCount = ((ceil ((count _entries) / _pageSize)) max 1);
private _maxPage = _pageCount - 1;
if (_pageIndex > _maxPage) then {
    _pageIndex = _maxPage;
    uiNamespace setVariable ["DB_dsi_pageIndex", _pageIndex];
};

private _safeLeft = safeZoneXAbs;
private _safeTop = safeZoneY;
private _safeWidth = safeZoneWAbs;
private _safeHeight = safeZoneH;

private _cellW = 0.056 * _safeWidth;
private _cellH = 0.082 * _safeHeight;
private _gapX = 0.010 * _safeWidth;
private _gapY = 0.012 * _safeHeight;
private _tabW = 0.032 * _safeWidth;
private _tabH = 0.048 * _safeHeight;
private _columns = 2;
private _rows = 3;
private _gridW = (_columns * _cellW) + ((_columns - 1) * _gapX);
private _gridH = (_rows * _cellH) + ((_rows - 1) * _gapY);
private _tabsW = ((count _panels) * _tabW) + ((((count _panels) - 1) max 0) * _gapX);
private _layoutW = _gridW max _tabsW;
private _layoutH = (2 * _tabH) + _gridH + (0.054 * _safeHeight);

private _openRight = (_anchorScreen # 0) < (_safeLeft + (_safeWidth * 0.58));
private _originX = if (_openRight) then {
    (_anchorScreen # 0) + (0.025 * _safeWidth)
} else {
    (_anchorScreen # 0) - _layoutW - (0.025 * _safeWidth)
};
private _originY = (_anchorScreen # 1) - (_layoutH * 0.45);

_originX = (_originX max _safeLeft) min (_safeLeft + _safeWidth - _layoutW);
_originY = (_originY max _safeTop) min (_safeTop + _safeHeight - _layoutH);

private _tabRowY = _originY + _tabH + (0.010 * _safeHeight);
private _entryYBase = _tabRowY + _tabH + (0.010 * _safeHeight);
private _footerY = _entryYBase + _gridH + (0.012 * _safeHeight);

private _headerCtrls = uiNamespace getVariable ["DB_dsi_headerCtrls", []];
if (_headerCtrls isEqualTo []) then {
    _headerCtrls = [
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1],
        _display ctrlCreate ["RscStructuredText", -1]
    ];
    uiNamespace setVariable ["DB_dsi_headerCtrls", _headerCtrls];
};

_headerCtrls params ["_barCtrl", "_iconBgCtrl", "_iconCtrl", "_titleCtrl", "_footerCtrl"];

_barCtrl ctrlShow true;
_barCtrl ctrlSetPosition [_originX, _originY - (0.014 * _safeHeight), _layoutW, 0.004 * _safeHeight];
_barCtrl ctrlSetBackgroundColor [1, 1, 1, 0.8];
_barCtrl ctrlCommit 0;

_iconBgCtrl ctrlShow true;
_iconBgCtrl ctrlSetPosition [_originX, _originY + (0.006 * _safeHeight), _tabW, _tabH];
_iconBgCtrl ctrlSetBackgroundColor [0, 0, 0, 0.52];
_iconBgCtrl ctrlCommit 0;

_iconCtrl ctrlShow true;
_iconCtrl ctrlSetPosition [_originX, _originY + (0.006 * _safeHeight), _tabW, _tabH];
_iconCtrl ctrlSetStructuredText parseText format [
    "<t align='center'><img image='%1' size='1.2'/></t>",
    _sourceIcon
];
_iconCtrl ctrlCommit 0;

_titleCtrl ctrlShow true;
_titleCtrl ctrlSetPosition [_originX + _tabW + _gapX, _originY + (0.006 * _safeHeight), _layoutW - _tabW - _gapX, _tabH];
_titleCtrl ctrlSetStructuredText parseText format [
    "<t font='PuristaMedium' size='0.92' color='#F4F4F4'>%1</t>",
    toUpper _sourceLabel
];
_titleCtrl ctrlCommit 0;

_footerCtrl ctrlShow true;
_footerCtrl ctrlSetPosition [_originX, _footerY, _layoutW, 0.022 * _safeHeight];
_footerCtrl ctrlCommit 0;

private _tabCtrls = uiNamespace getVariable ["DB_dsi_tabCtrls", []];
for "_i" from count _tabCtrls to (count _panels - 1) do {
    _tabCtrls pushBack [
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscStructuredText", -1]
    ];
};
uiNamespace setVariable ["DB_dsi_tabCtrls", _tabCtrls];

private _entryCtrls = uiNamespace getVariable ["DB_dsi_entryCtrls", []];
for "_i" from count _entryCtrls to (_pageSize - 1) do {
    _entryCtrls pushBack [
        _display ctrlCreate ["RscText", -1],
        _display ctrlCreate ["RscStructuredText", -1]
    ];
};
uiNamespace setVariable ["DB_dsi_entryCtrls", _entryCtrls];

private _optionRecords = [];
private _centerPos = [0.5, 0.5];

{
    _x params ["_bgCtrl", "_textCtrl"];

    if (_forEachIndex < count _panels) then {
        private _tabX = _originX + (_forEachIndex * (_tabW + _gapX));
        private _tabY = _tabRowY;
        private _tabData = _panels # _forEachIndex;
        private _tabIcon = _tabData # 1;
        private _isActive = _forEachIndex isEqualTo _panelIndex;

        _bgCtrl ctrlShow true;
        _bgCtrl ctrlSetPosition [_tabX, _tabY, _tabW, _tabH];
        if (_isActive) then {
            _bgCtrl ctrlSetBackgroundColor [1, 1, 1, 0.22];
        } else {
            _bgCtrl ctrlSetBackgroundColor [0, 0, 0, 0.42];
        };
        _bgCtrl ctrlCommit 0;

        _textCtrl ctrlShow true;
        _textCtrl ctrlSetPosition [_tabX, _tabY, _tabW, _tabH];
        _textCtrl ctrlSetStructuredText parseText format [
            "<t align='center'><img image='%1' size='1.0'/></t>",
            _tabIcon
        ];
        _textCtrl ctrlCommit 0;

        _optionRecords pushBack [["panel", _forEachIndex, _tabData # 2], [_tabX + (_tabW * 0.5), _tabY + (_tabH * 0.5)]];
    } else {
        _bgCtrl ctrlShow false;
        _textCtrl ctrlShow false;
    };
} forEach _tabCtrls;

private _visibleEntries = _entries select [_pageIndex * _pageSize, _pageSize];

{
    _x params ["_bgCtrl", "_textCtrl"];

    if (_forEachIndex < count _visibleEntries) then {
        private _entry = _visibleEntries # _forEachIndex;
        _entry params ["", "", "_count", "_entryIcon", "_entryLabel"];

        private _col = _forEachIndex mod _columns;
        private _row = floor (_forEachIndex / _columns);
        private _xPos = _originX + (_col * (_cellW + _gapX));
        private _yPos = _entryYBase + (_row * (_cellH + _gapY));

        _bgCtrl ctrlShow true;
        _bgCtrl ctrlSetPosition [_xPos, _yPos, _cellW, _cellH];
        _bgCtrl ctrlSetBackgroundColor [0, 0, 0, 0.48];
        _bgCtrl ctrlCommit 0;

        _textCtrl ctrlShow true;
        _textCtrl ctrlSetPosition [_xPos, _yPos, _cellW, _cellH];
        _textCtrl ctrlSetStructuredText parseText format [
            "<img image='%1' size='1.55'/><br/><t align='center' font='PuristaMedium' size='0.80' color='#F4F4F4'>x%2</t>",
            _entryIcon,
            _count
        ];
        _textCtrl ctrlCommit 0;

        _optionRecords pushBack [["entry", _entry, _entryLabel], [_xPos + (_cellW * 0.5), _yPos + (_cellH * 0.5)]];
    } else {
        _bgCtrl ctrlShow false;
        _textCtrl ctrlShow false;
    };
} forEach _entryCtrls;

private _selectedIndex = -1;
private _selectedDistance = 1e9;

{
    _x params ["", "_optionPos"];
    private _distance = _centerPos distance2D _optionPos;
    if ((_distance < 0.12) && {_distance < _selectedDistance}) then {
        _selectedDistance = _distance;
        _selectedIndex = _forEachIndex;
    };
} forEach _optionRecords;

if (_selectedIndex >= 0) then {
    private _selected = _optionRecords # _selectedIndex;
    uiNamespace setVariable ["DB_dsi_selectedOption", _selected # 0];
    (_selected # 0) params ["", "", "_selectedLabel"];

    _footerCtrl ctrlSetStructuredText parseText format [
        "<t font='PuristaLight' size='0.78' color='#F4F4F4'>%1  |  PAGE %2/%3  |  TAB PANEL  |  SPACE SELECT</t>",
        toUpper _selectedLabel,
        _pageIndex + 1,
        _pageCount
    ];
    _footerCtrl ctrlCommit 0;

    private _tabCount = count _panels;
    if (_selectedIndex < _tabCount) then {
        private _selectedTab = (_tabCtrls # _selectedIndex) # 0;
        _selectedTab ctrlSetBackgroundColor [1, 1, 1, 0.34];
        _selectedTab ctrlCommit 0;
    } else {
        private _entryIndex = _selectedIndex - _tabCount;
        if (_entryIndex < count _entryCtrls) then {
            private _selectedEntry = (_entryCtrls # _entryIndex) # 0;
            _selectedEntry ctrlSetBackgroundColor [1, 1, 1, 0.30];
            _selectedEntry ctrlCommit 0;
        };
    };
} else {
    uiNamespace setVariable ["DB_dsi_selectedOption", []];
    _footerCtrl ctrlSetStructuredText parseText format [
        "<t font='PuristaLight' size='0.78' color='#D6D6D6'>PAGE %1/%2  |  TAB PANEL  |  SPACE SELECT</t>",
        _pageIndex + 1,
        _pageCount
    ];
    _footerCtrl ctrlCommit 0;
}
