params ["_nUnits", "_nVehicles"];

private _objDist = 5;
private _vehicleCoef = 2;
private _sparsityCoef = 2;
private _radius = _sparsityCoef * (sqrt (_nUnits + (_vehicleCoef * _nVehicles))) * _objDist;
[_radius, _objDist]
