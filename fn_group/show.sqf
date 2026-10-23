params ["_state"];

private _group = _state get "_group";

private _unitArray = units _group;
for [{private _u = 0}, {_u < count _unitArray}, {_u = _u + 1}] do {
    private _unit = _unitArray select _u;

    _unit hideObject false;
    _unit enableSimulationGlobal true;
    [_unit, "ALL"] remoteExec ["enableAI", 0, true];
};
