params ["_UAV"];

while {alive _UAV} do
{
	waituntil {sleep 1;((isengineon _UAV) && (isnull attachedto _UAV) && (((getpos _UAV)#2)> 1)) || !(alive _UAV)};

	if (_UAV animationsourcephase 'mainturret_hide' < 1) then {_UAV animatesource ["mainturret_hide",1,1]};

	waituntil {sleep 1;(!(isengineon _UAV) || !(isnull attachedto _UAV) || (((getpos _UAV)#2) < 1) ) || !(alive _UAV)};

	if (_UAV animationsourcephase 'mainturret_hide' > 0) then {_UAV animatesource ["mainturret_hide",0,1]};
};