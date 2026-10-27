params ["_params", "_posState", "_gameObjectState", "_migrationState"];

private _nHops = _migrationState get "_nHops";

if (_nHops <= 0) exitWith {};

private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _chunkSize = _params get "_chunkSize";
private _groupIndexPos = _posState get "_groupIndexPos";
private _unitGameObjectArray = _gameObjectState get "_unitGameObjectArray";
private _vehicleGameObjectArray = _gameObjectState get "_vehicleGameObjectArray";

private _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
private _nUnits = count _unitGameObjectArray;
private _nVehicles = count _vehicleGameObjectArray;

for [{private _u = 0}, {_u < _nUnits}, {_u = _u + 1}] do {
    private _unit = _unitGameObjectArray select _u;

    if (_unit == vehicle _unit) then {
        private _unitPos = [_groupWorldPos, _nUnits, _nVehicles] call fn_groupFindSafePos;
        _unit setPos _unitPos;
    };
};

for [{private _v = 0}, {_v < _nVehicles}, {_v = _v + 1}] do {
    private _vehicle = _vehicleGameObjectArray select _v;

    private _vehiclePos = [_groupWorldPos, _nUnits, _nVehicles] call fn_groupFindSafePos;
    _vehicle setPos _vehiclePos;
};
