if (is3DEN) exitWith {};
if (!isServer) exitWith {};

waitUntil {time > 1};

params ["_unit"];

private _drone_type = "orlan_F_OPF";

switch (side _unit) do {
    case EAST: { _drone_type = "orlan_F_OPF" };
    case WEST: { _drone_type = "orlan_F_BLU" };
    case INDEPENDENT: { _drone_type = "orlan_F_IND" };
};

_UAV =  _drone_type createVehicle (_unit modeltoworld (_unit selectionposition "pos_luncher"));
createVehicleCrew _uav;
_UAV attachto [_unit,[0,0,0],"pos_luncher",true];
_UAV setVectorDirAndUp [[0,0.8,0.2],[0,0,1]];
_unit setvariable ['proxy',_UAV,true];
