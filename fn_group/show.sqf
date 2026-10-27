params ["_gameObjectState"];

private _group = _gameObjectState get "_group";

private _unitGameObjectArray = _gameObjectState get "_unitGameObjectArray";
for [{private _u = 0}, {_u < count _unitGameObjectArray}, {_u = _u + 1}] do {
    private _unit = _unitGameObjectArray select _u;

    _unit hideObject false;
    _unit enableSimulationGlobal true;
    [_unit, "ALL"] remoteExec ["enableAI", 0, true];
};

private _vehicleGameObjectArray = _gameObjectState get "_vehicleGameObjectArray";
for [{private _v = 0}, {_v < count _vehicleGameObjectArray}, {_v = _v + 1}] do {
    private _vehicle = _vehicleGameObjectArray select _v;

    _vehicle hideObject false;
    _vehicle enableSimulationGlobal true;
};
