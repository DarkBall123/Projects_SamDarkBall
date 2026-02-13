#include "\vnd_main\script_macros.hpp"

params ["_nodes"];
if ((count _nodes) < 2) exitWith {};

private _clr    = [1,1,1,0.05];
private _observer = GETMVAR(bis_fnc_moduleRemoteControl_unit, player);
if (isNull _observer) then {
    _observer = player;
};

for "_s" from 0 to ((count _nodes) - 2) do
{
    private _a = _nodes # _s;
    private _b = _nodes # (_s + 1);

    private _d = _a distance _b;
    if (_d < 0.05) then { continue };

    private _delta = _b vectorDiff _a;
    private _mid = _a vectorAdd (_delta vectorMultiply 0.5);
    private _viewDist = _observer distance _mid;

    private _segLen = VND_FIBER_SEG_FAR;
    if (_viewDist <= VND_FIBER_SEG_NEAR_DIST) then {
        _segLen = VND_FIBER_SEG_NEAR;
    } else {
        if (_viewDist <= VND_FIBER_SEG_MID_DIST) then {
            _segLen = VND_FIBER_SEG_MID;
        };
    };

    private _nSeg = (ceil (_d / _segLen)) max 1;

    for "_i" from 0 to (_nSeg - 1) do {
        private _pA = _a vectorAdd (_delta vectorMultiply (_i   / _nSeg));
        private _pB = _a vectorAdd (_delta vectorMultiply ((_i+1)/ _nSeg));
        drawLine3D [_pA, _pB, _clr, 1];
    };
};
