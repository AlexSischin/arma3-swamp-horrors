params ["_groupWorldPos", "_nUnits", "_nVehicles"];

private _objDist = 5;
private _vehicleCoef = 2;
private _sparsityCoef = 2;
private _radius = _sparsityCoef * (sqrt (_nUnits + (_vehicleCoef * _nVehicles))) * _objDist;
private _squareSize = _radius / sqrt 2;
private _defaultPos = [
    random (2 * _squareSize) - _squareSize,
    random (2 * _squareSize) - _squareSize,
    0
];
_pos = [_groupWorldPos, 0, _radius, _objDist, 1, 0, 0, [], _defaultPos] call BIS_fnc_findSafePos;
_pos
