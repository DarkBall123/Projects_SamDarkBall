params ["_position", "_grid", "_nested", ["_fromGrid", false]];

_position params ["_x", "_y", "_w", "_h"];

private _pixelGridW = pixelW * pixelGrid;
private _pixelGridH = pixelH * pixelGrid;
private _guiGridWAbs = (safeZoneW / safeZoneH) min 1.2;
private _guiGridHAbs = _guiGridWAbs / 1.2;
private _guiGridW = _guiGridWAbs / 40;
private _guiGridH = _guiGridHAbs / 25;
private _guiGridX = safeZoneX;
private _guiGridY = safeZoneY + safeZoneH - _guiGridHAbs;

if (_fromGrid) exitWith {
    switch (_grid) do {
        case 0: {
            if (_nested) then {
                [_x * safeZoneW, _y * safeZoneH, _w * safeZoneW, _h * safeZoneH]
            } else {
                [safeZoneX + _x * safeZoneW, safeZoneY + _y * safeZoneH, _w * safeZoneW, _h * safeZoneH]
            }
        };
        case 1: {
            if (_nested) then {
                [_x * _pixelGridW, _y * _pixelGridH, _w * _pixelGridW, _h * _pixelGridH]
            } else {
                [safeZoneX + _x * _pixelGridW, safeZoneY + _y * _pixelGridH, _w * _pixelGridW, _h * _pixelGridH]
            }
        };
        case 2: {
            [_x * _pixelGridW, _y * _pixelGridH, _w * _pixelGridW, _h * _pixelGridH]
        };
        case 3: {
            if (_nested) then {
                [_x * _guiGridW, _y * _guiGridH, _w * _guiGridW, _h * _guiGridH]
            } else {
                [_guiGridX + _x * _guiGridW, _guiGridY + _y * _guiGridH, _w * _guiGridW, _h * _guiGridH]
            }
        };
        default {
            _position
        };
    }
};

switch (_grid) do {
    case 0: {
        if (_nested) then {
            [_x / safeZoneW, _y / safeZoneH, _w / safeZoneW, _h / safeZoneH]
        } else {
            [(_x - safeZoneX) / safeZoneW, (_y - safeZoneY) / safeZoneH, _w / safeZoneW, _h / safeZoneH]
        }
    };
    case 1: {
        if (_nested) then {
            [_x / _pixelGridW, _y / _pixelGridH, _w / _pixelGridW, _h / _pixelGridH]
        } else {
            [(_x - safeZoneX) / _pixelGridW, (_y - safeZoneY) / _pixelGridH, _w / _pixelGridW, _h / _pixelGridH]
        }
    };
    case 2: {
        [_x / _pixelGridW, _y / _pixelGridH, _w / _pixelGridW, _h / _pixelGridH]
    };
    case 3: {
        if (_nested) then {
            [_x / _guiGridW, _y / _guiGridH, _w / _guiGridW, _h / _guiGridH]
        } else {
            [(_x - _guiGridX) / _guiGridW, (_y - _guiGridY) / _guiGridH, _w / _guiGridW, _h / _guiGridH]
        }
    };
    default {
        _position
    };
}
