if (is3DEN) exitWith {};

params ["_luncher"];

_reloadtime = 55;

_UAV = objnull;

private _drone_type = "orlan_F_OPF";

switch (side _luncher) do {
    case EAST: { _drone_type = "orlan_F_OPF" };
    case WEST: { _drone_type = "orlan_F_BLU" };
    case INDEPENDENT: { _drone_type = "orlan_F_IND" };
};


private _allObjects = player nearEntities 10;
private _reloadableBox = _allObjects # (_allObjects findIf {(typeOf _x == "orlan_reloadBox") && { !(_x getVariable ["used", false]) }});

_reloadableBox setVariable ["used", true, true];

if ((_luncher animationsourcephase 'luch_anim' > 0) || (_luncher animationsourcephase 'reload_uav' > 0))	then {_luncher animatesource ['luch_anim',0,(1/_reloadtime)];_luncher animatesource ['reload_uav',0,(1/_reloadtime)]};

waituntil {sleep 0.3;((_luncher animationsourcephase 'reload_uav' == 0) && (_luncher animationsourcephase 'luch_anim' == 0)) || !(alive _luncher) || (!(isnull _UAV) && (!alive _UAV))};


if (!(isnull _UAV) && (!alive _UAV)) then {
	detach _UAV;
	[_luncher, 0] remoteExec ["setVehicleAmmo"];
}else {
	_UAV =  _drone_type createVehicle (_luncher modeltoworld (_luncher selectionposition "pos_luncher"));
	//createVehicleCrew _uav; //what if tripos will be used by other side crew blufor or GUER? - this should be like this
	_crew = "O_UAV_AI";
	_side = side _luncher;
	switch (_side) do
							{
								case WEST: {_crew = "B_UAV_AI";};
								case EAST: {_crew = "O_UAV_AI";};
								case independent: {_crew = "I_UAV_AI";};
							};
	private _group = createGroup _side;

	_unit = _group createUnit [_crew, [0, 0, 0], [], 0, "FORM"]; _unit moveInAny _UAV;
	_unit = _group createUnit [_crew, [0, 0, 0], [], 0, "FORM"]; _unit moveInAny _UAV;

	_UAV attachto [_luncher,[0,0,0],"pos_luncher",true];
	_UAV setVectorDirAndUp [[0,0.8,0.2],[0,0,1]];
	_luncher setvariable ['proxy',_UAV,true];
	[_luncher, 1] remoteExec ["setVehicleAmmo"];
};



