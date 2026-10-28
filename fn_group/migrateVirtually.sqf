params ["_params", "_posState", "_migrationState"];

private _chunkMap = _params get "_chunkMap";
private _chunkSize = _params get "_chunkSize";
private _speedKmH = _params get "_speedKmH";
private _migrationMaxDistance = _params get "_migrationMaxDistance";
private _delay = _params get "_delay";

private _groupIndexPos = _posState get "_groupIndexPos";
private _path = _migrationState get "_path";
private _untraveledTime = _migrationState get "_untraveledTime";

private _time = _untraveledTime + _delay;
private _pathHopPlan = [_time, _speedKmH, _chunkSize] call fn_groupCalculatePathHopPlan;
private _nHops = _pathHopPlan select 0;
private _untraveledTime = _pathHopPlan select 1;
private _nHopsRemaining = _nHops;
while {_nHopsRemaining > 0} do {
    _path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance] call fn_groupUpdatePath;
    if (count _path > 1) then {
        private _currentPathHops = _nHopsRemaining min ((count _path) - 1);
        _nHopsRemaining = _nHopsRemaining - _currentPathHops;
        _path deleteRange [0, _currentPathHops];
        _groupIndexPos = _path select 0;
    } else {
        _nHopsRemaining = _nHopsRemaining - 1;
    };
};
_posState set ["_groupIndexPos", _groupIndexPos];
_migrationState set ["_path", _path];
_migrationState set ["_untraveledTime", _untraveledTime];

if (_nHops > 0) then {
    private _housePosWeight = _params get "_housePosWeight";
    private _roadPosWeight = _params get "_roadPosWeight";
    private _otherPosWeight = _params get "_otherPosWeight";

    private _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
    private _unitGameObjectArray = _gameObjectState get "_unitGameObjectArray";
    private _nUnits = count _unitGameObjectArray;
    private _vehicleGameObjectArray = _gameObjectState get "_vehicleGameObjectArray";
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
};
