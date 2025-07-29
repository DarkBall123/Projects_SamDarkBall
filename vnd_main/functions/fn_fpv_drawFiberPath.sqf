params ["_nodes"];
if ((count _nodes) < 2) exitWith {};

private _segLen = 1.0;
private _clr    = [1,1,1,0.05];

for "_s" from 0 to ((count _nodes) - 2) do
{
    private _a = _nodes # _s;
    private _b = _nodes # (_s + 1);

    private _d = _a distance _b;
    if (_d < 0.05) then { continue };

    private _nSeg  = ceil (_d / _segLen);
    private _delta = _b vectorDiff _a;

    for "_i" from 0 to (_nSeg - 1) do {
        private _pA = _a vectorAdd (_delta vectorMultiply (_i   / _nSeg));
        private _pB = _a vectorAdd (_delta vectorMultiply ((_i+1)/ _nSeg));
        drawLine3D [_pA, _pB, _clr, 1];
    };
};
