params ["_params", "_posState"];

private _chunkSize = _params get "_chunkSize";
private _side = _params get "_side";
private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _unitArray = _params get "_unitArray";
private _vehicleArray = _params get "_vehicleArray";
private _groupIndexPos = _posState get "_groupIndexPos";

private _group = createGroup [_side, true];
private _groupDir = random 360;
_group setFormDir _groupDir;
private _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
private _nUnits = count _unitArray;
private _nVehicles = count _vehicleArray;

private _unitGameObjectArray = [];
for [{private _u = 0}, {_u < _nUnits}, {_u = _u + 1}] do {
    private _unit = _unitArray select _u;

    private _unitPos = [_groupWorldPos, _nUnits, _nVehicles] call fn_groupFindSafePos;
    private _unitGameObject = [_group, _unitPos, _unit] call fn_groupCreateUnit;
    _unitGameObjectArray pushBack _unitGameObject;
    _unitGameObject setDir _groupDir;
};

private _vehicleGameObjectArray = [];
for [{private _v = 0}, {_v < _nVehicles}, {_v = _v + 1}] do {
    private _vehicle = _vehicleArray select _v;

    private _vehicleClass = _vehicle select 0;
    private _vehiclePos = [_groupWorldPos, _nUnits, _nVehicles] call fn_groupFindSafePos;
    private _vehicleGameObject = [_vehiclePos, _vehicleClass] call fn_groupCreateVehicle;
    _vehicleGameObjectArray pushBack _vehicleGameObject;
    _vehicleGameObject setDir _groupDir;

    private _crewArray = _vehicle select 1;
    for [{private _c = 0}, {_c < count _crewArray}, {_c = _c + 1}] do {
        private _crew = _crewArray select _c;

        private _crewPos = [_groupWorldPos, _nUnits, _nVehicles] call fn_groupFindSafePos;
        private _crewClass = _crew select 0;
        private _crewGameObject = [_group, _crewPos, _crewClass] call fn_groupCreateUnit;
        _unitGameObjectArray pushBack _crewGameObject;
        private _crewRole = _crew select 1;
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

private _gameObjectState = createHashMap;
_gameObjectState set ["_group", _group];
_gameObjectState set ["_unitGameObjectArray", _unitGameObjectArray];
_gameObjectState set ["_vehicleGameObjectArray", _vehicleGameObjectArray];
_gameObjectState
