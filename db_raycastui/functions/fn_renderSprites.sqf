#include "\db_raycastui\script_component.hpp"

params [
    ["_state", [], [[]]]
];

disableSerialization;

if (_state isEqualTo []) exitWith
{
    _state
};

private _settings = _state # DB_RUI_S_SETTINGS;
private _player = _state # DB_RUI_S_PLAYER;
private _fov = _settings # DB_RUI_CFG_FOV;
private _projectionScale = _settings # DB_RUI_CFG_PROJ_SCALE;
private _zBuffer = _state # DB_RUI_S_ZBUFFER;
private _colW = _settings # DB_RUI_CFG_COLUMN_W;
private _columns = _settings # DB_RUI_CFG_COLUMNS;
private _pool = _state # DB_RUI_S_SPRITE_POOL;

{
    {
        _x ctrlShow false;
    }
    forEach _x;
}
forEach _pool;

private _sprites = [];

{
    if (_x # DB_RUI_E_ALIVE) then
    {
        private _dx = (_x # DB_RUI_E_X) - (_player # DB_RUI_P_X);
        private _dy = (_x # DB_RUI_E_Y) - (_player # DB_RUI_P_Y);
        private _distance = sqrt ((_dx * _dx) + (_dy * _dy));
        private _angleTo = ((_dy atan2 _dx) + 360) % 360;
        private _relative = (((_angleTo - (_player # DB_RUI_P_DIR)) + 540) % 360) - 180;
        private _depth = _distance * cos _relative;

        if ((abs _relative) < (_fov * 0.65)) then
        {
            if (_depth > 0.15) then
            {
                private _screenCenter = (DB_RUI_W * 0.5) + ((_relative / (_fov * 0.5)) * (DB_RUI_W * 0.5));
                private _height = (_projectionScale * 0.88) / _depth;
                private _width = _height * 0.70;
                _sprites pushBack [_depth, "enemy", _screenCenter, _height, _width, _x];
            };
        };
    };
}
forEach (_state # DB_RUI_S_ENEMIES);

{
    if (_x # DB_RUI_PK_ALIVE) then
    {
        private _dx = (_x # DB_RUI_PK_X) - (_player # DB_RUI_P_X);
        private _dy = (_x # DB_RUI_PK_Y) - (_player # DB_RUI_P_Y);
        private _distance = sqrt ((_dx * _dx) + (_dy * _dy));
        private _angleTo = ((_dy atan2 _dx) + 360) % 360;
        private _relative = (((_angleTo - (_player # DB_RUI_P_DIR)) + 540) % 360) - 180;
        private _depth = _distance * cos _relative;

        if ((abs _relative) < (_fov * 0.70)) then
        {
            if (_depth > 0.12) then
            {
                private _screenCenter = (DB_RUI_W * 0.5) + ((_relative / (_fov * 0.5)) * (DB_RUI_W * 0.5));
                private _height = (_projectionScale * 0.42) / _depth;
                private _width = _height * 0.55;
                _sprites pushBack [_depth, "pickup", _screenCenter, _height, _width, _x];
            };
        };
    };
}
forEach (_state # DB_RUI_S_PICKUPS);

_sprites sort false;

private _visibleCount = ((count _sprites) min (count _pool));
for "_index" from 0 to (_visibleCount - 1) do
{
    private _slot = _pool # _index;
    private _sprite = _sprites # _index;
    private _depth = _sprite # 0;
    private _kind = _sprite # 1;
    private _screenCenter = _sprite # 2;
    private _height = (_sprite # 3) min (DB_RUI_H * 1.10);
    private _width = (_sprite # 4) min (DB_RUI_W * 0.25);
    private _data = _sprite # 5;

    private _left = _screenCenter - (_width * 0.5);
    private _top = (DB_RUI_H * 0.5) - (_height * 0.5);

    private _startColumn = ((floor (_left / _colW)) max 0) min (_columns - 1);
    private _endColumn = ((ceil ((_left + _width) / _colW)) max 0) min (_columns - 1);
    private _visible = false;

    for "_column" from _startColumn to _endColumn do
    {
        if ((_zBuffer # _column) > (_depth - 0.04)) exitWith
        {
            _visible = true;
        };
    };

    if (_visible) then
    {
        _top = _top + (DB_RUI_H * 0.06);
        if (_kind isEqualTo "pickup") then
        {
            _top = _top + (DB_RUI_H * 0.11);
        };

        private _main = _slot # 0;
        private _second = _slot # 1;
        private _third = _slot # 2;
        private _fourth = _slot # 3;
        private _fifth = _slot # 4;

        {
            _x ctrlShow true;
        }
        forEach _slot;

        if (_kind isEqualTo "enemy") then
        {
            private _stateName = _data # DB_RUI_E_STATE;
            private _bodyColor = [0.66, 0.12, 0.08, 0.96];
            private _headColor = [0.88, 0.72, 0.56, 0.96];
            private _eyeColor = [1, 0.92, 0.36, 1];
            private _accentColor = [0.22, 0.22, 0.22, 0.95];

            if (_stateName isEqualTo "attack") then
            {
                _bodyColor = [0.90, 0.20, 0.10, 0.98];
            };

            if (_stateName isEqualTo "hurt") then
            {
                _accentColor = [1, 1, 1, 1];
            };

            _main ctrlSetBackgroundColor _bodyColor;
            _main ctrlSetPosition [_left + (_width * 0.28), _top + (_height * 0.36), _width * 0.44, _height * 0.42];

            _second ctrlSetBackgroundColor _headColor;
            _second ctrlSetPosition [_left + (_width * 0.33), _top + (_height * 0.14), _width * 0.34, _height * 0.18];

            _third ctrlSetBackgroundColor _eyeColor;
            _third ctrlSetPosition [_left + (_width * 0.39), _top + (_height * 0.20), _width * 0.05, _height * 0.03];

            _fourth ctrlSetBackgroundColor _eyeColor;
            _fourth ctrlSetPosition [_left + (_width * 0.56), _top + (_height * 0.20), _width * 0.05, _height * 0.03];

            _fifth ctrlSetBackgroundColor _accentColor;
            _fifth ctrlSetPosition [_left + (_width * 0.30), _top + (_height * 0.58), _width * 0.40, _height * 0.05];
        }
        else
        {
            private _pickupType = _data # DB_RUI_PK_TYPE;
            private _bodyColor = [0.84, 0.60, 0.12, 0.96];
            private _accentColor = [0.18, 0.16, 0.12, 1];

            if (_pickupType isEqualTo "medkit") then
            {
                _bodyColor = [0.18, 0.58, 0.20, 0.96];
                _accentColor = [0.96, 0.96, 0.96, 1];
            };

            _main ctrlSetBackgroundColor _bodyColor;
            _main ctrlSetPosition [_left + (_width * 0.20), _top + (_height * 0.28), _width * 0.60, _height * 0.44];

            if (_pickupType isEqualTo "medkit") then
            {
                _second ctrlSetBackgroundColor _accentColor;
                _second ctrlSetPosition [_left + (_width * 0.45), _top + (_height * 0.34), _width * 0.10, _height * 0.30];

                _third ctrlSetBackgroundColor _accentColor;
                _third ctrlSetPosition [_left + (_width * 0.33), _top + (_height * 0.46), _width * 0.34, _height * 0.08];

                _fourth ctrlSetPosition [0, 0, 0, 0];
                _fifth ctrlSetPosition [0, 0, 0, 0];
                _fourth ctrlShow false;
                _fifth ctrlShow false;
            }
            else
            {
                _second ctrlSetBackgroundColor _accentColor;
                _second ctrlSetPosition [_left + (_width * 0.27), _top + (_height * 0.36), _width * 0.12, _height * 0.26];

                _third ctrlSetBackgroundColor _accentColor;
                _third ctrlSetPosition [_left + (_width * 0.44), _top + (_height * 0.36), _width * 0.12, _height * 0.26];

                _fourth ctrlSetBackgroundColor _accentColor;
                _fourth ctrlSetPosition [_left + (_width * 0.61), _top + (_height * 0.36), _width * 0.12, _height * 0.26];

                _fifth ctrlSetPosition [0, 0, 0, 0];
                _fifth ctrlShow false;
            };
        };

        {
            _x ctrlCommit 0;
        }
        forEach [_main, _second, _third, _fourth, _fifth];
    };
};

_state
