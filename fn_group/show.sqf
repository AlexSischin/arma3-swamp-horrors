params ["_gameObjectState"];

private _group = _gameObjectState get "_group";

private _unitArray = [_group] call fn_objectGetGroupUnits;
for [{private _u = 0}, {_u < count _unitArray}, {_u = _u + 1}] do {
    private _unit = _unitArray select _u;

    _unit hideObject false;
    _unit enableSimulationGlobal true;
    [_unit, "ALL"] remoteExec ["enableAI", 0, true];
};

private _vehicleArray = [_group] call fn_objectGetGroupVehicles;
for [{private _v = 0}, {_v < count _vehicleArray}, {_v = _v + 1}] do {
    private _vehicle = _vehicleArray select _v;

    _vehicle hideObject false;
    _vehicle enableSimulationGlobal true;
};
