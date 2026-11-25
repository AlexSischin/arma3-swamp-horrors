params [
    ["_side", nil],
    ["_unitArray", []],
    ["_vehicleArray", []],
    ["_groupWorldPos", [0, 0, 0]],
    ["_randomSafePos", [0, 0, 0]]
];

private _group = createGroup [_side, true];
private _groupDir = random 360;
_group setFormDir _groupDir;
private _nUnits = count _unitArray;
private _nVehicles = count _vehicleArray;

for [{private _u = 0}, {_u < _nUnits}, {_u = _u + 1}] do {
    private _unit = _unitArray select _u;

    private _unitGameObject = _group createUnit [_unit, _randomSafePos, [], 0, "NONE"];
    private _unitPos = [_groupWorldPos, _nUnits, _nVehicles] call LCX_fnc_findSafePos;
    [_unitGameObject] call LCX_fnc_protectFromCollisions;
    _unitGameObject setPos _unitPos;
    _unitGameObject setDir _groupDir;
};

for [{private _v = 0}, {_v < _nVehicles}, {_v = _v + 1}] do {
    private _vehicle = _vehicleArray select _v;

    private _vehicleClass = _vehicle select 0;
    private _vehicleGameObject = createVehicle [_randomSafePos, _randomSafePos, [], 0, "NONE"];
    private _vehiclePos = [_groupWorldPos, _nUnits, _nVehicles] call LCX_fnc_findSafePos;
    [_vehicleGameObject] call LCX_fnc_protectFromCollisions;
    _vehicleGameObject setPos _unitPos;
    _vehicleGameObject setDir _groupDir;

    private _crewArray = _vehicle select 1;
    for [{private _c = 0}, {_c < count _crewArray}, {_c = _c + 1}] do {
        private _crew = _crewArray select _c;

        private _crewClass = _crew select 0;
        private _crewGameObject = _group createUnit [_crewClass, _randomSafePos, [], 0, "NONE"];
        private _crewRole = _crew select 1;
        [_crewGameObject] call LCX_fnc_protectFromCollisions;
        switch (_crewRole) do {
            case "driver": {
                _crewGameObject moveInDriver _vehicleGameObject;
            };
            case "gunner": {
                _crewGameObject moveInGunner _vehicleGameObject;
            };
            case "commander": {
                _crewGameObject moveInCommander _vehicleGameObject;
            };
            case "turret": {
                private _crewTurretPath = _crew select 2;
                _crewGameObject moveInTurret [_vehicleGameObject, _crewTurretPath];
            };
            default {
                _crewGameObject moveInAny _vehicleGameObject;
            };
        };
    };
};

_group
