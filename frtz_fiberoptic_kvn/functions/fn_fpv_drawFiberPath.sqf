params ["_nodes"];
if ((count _nodes) < 2) exitWith {};

private _clr = [1,1,1,0.05];

for "_s" from 0 to ((count _nodes) - 2) do
{
    private _a = _nodes # _s;
    private _b = _nodes # (_s + 1);

    if ((_a distanceSqr _b) < 0.0025) then { continue };
    drawLine3D [_a, _b, _clr, 1];
};
