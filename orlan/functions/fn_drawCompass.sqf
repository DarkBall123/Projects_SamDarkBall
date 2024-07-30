private _fov = call CBA_fnc_getFov select 0; 
private _center = AGLToASL (positionCameraToWorld [0, 0, 3.5]);
private _offSetD = 1;

// Draw North Line 
drawIcon3D [ 
	"", 
	[1,1,1,1], 
	ASLToAGL(_center vectorAdd [0,(_offSetD*_fov),0]), 
	0, 
	0, 
	0, 
	"N", 
	1, 
	0.075, 
	"PuristaMedium" 
]; 

// Draw South Line 
drawIcon3D [ 
	"", 
	[1,1,1,0.5], 
	ASLToAGL(_center vectorAdd [0,-(_offSetD*_fov),0]), 
	0, 
	0, 
	0, 
	"S", 
	0.5, 
	0.075, 
	"PuristaMedium" 
]; 

// Draw East Line 
drawIcon3D [ 
	"", 
	[1,1,1,0.5], 
	ASLToAGL(_center vectorAdd [(_offSetD*_fov),0,0]), 
	0, 
	0, 
	0, 
	"E", 
	0.5, 
	0.075, 
	"PuristaMedium" 
]; 
  
// Draw West Line 
drawIcon3D [ 
	"", 
	[1,1,1,0.5], 
	ASLToAGL(_center vectorAdd [-(_offSetD*_fov),0,0]), 
	0, 
	0, 
	0, 
	"W", 
	0.5, 
	0.075, 
	"PuristaMedium" 
]; 
