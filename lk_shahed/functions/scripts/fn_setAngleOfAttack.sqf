//https://community.bistudio.com/wiki/setVectorDirAndUp
private ["_object","_rotations","_aroundX","_aroundY","_aroundZ","_dirX","_dirY","_dirZ","_upX","_upY","_upZ","_dir","_up","_dirXTemp", "_upXTemp"];
_object = _this select 0;          // Get the object to be rotated
_rotations = _this select 1;       // Get the array of rotation angles [X, Y, Z]

_aroundX = _rotations select 0;    // Rotation angle around X axis
_aroundY = _rotations select 1;    // Rotation angle around Y axis
_aroundZ = (360 - (_rotations select 2)) - 360; // Rotation angle around Z axis

// Initialize default direction and up vectors
_dirX = 0;
_dirY = 1;
_dirZ = 0;
_upX = 0;
_upY = 0;
_upZ = 1;

// If rotation around X axis is not 0
if (_aroundX != 0) then {
    // Update direction and up vectors based on X-axis rotation
    _dirY = cos _aroundX;
    _dirZ = sin _aroundX;
    _upY = -sin _aroundX;
    _upZ = cos _aroundX;
};

// If rotation around Y axis is not 0
if (_aroundY != 0) then {
    // Update direction and up vectors based on Y-axis rotation
    _dirX = _dirZ * sin _aroundY;
    _dirZ = _dirZ * cos _aroundY;
    _upX = _upZ * sin _aroundY;
    _upZ = _upZ * cos _aroundY;
};

// If rotation around Z axis is not 0
if (_aroundZ != 0) then {
    // Store temporary values for direction and up vectors
    _dirXTemp = _dirX;
    _upXTemp = _upX;
    
    // Update direction and up vectors based on Z-axis rotation
    _dirX = (_dirXTemp * cos _aroundZ) - (_dirY * sin _aroundZ);
    _dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
    _upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
    _upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
};

// Assemble the new direction vector (_dir) and the new up vector (_up) using the updated values
_dir = [_dirX, _dirY, _dirZ];
_up = [_upX, _upY, _upZ];

// Apply the new direction and up vectors to the _object, effectively rotating it
_object setVectorDirAndUp [_dir, _up];