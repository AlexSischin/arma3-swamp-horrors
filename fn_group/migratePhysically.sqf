params ["_params", "_posState", "_gameObjectState", "_migrationState"];

private _chunkMap = _params get "_chunkMap";
private _chunkSize = _params get "_chunkSize";
private _migrationMaxDistance = _params get "_migrationMaxDistance";
private _waypointChunkDistance = _params get "_waypointChunkDistance";
private _groupIndexPos = _posState get "_groupIndexPos";
private _group = _gameObjectState get "_group";
private _path = _migrationState get "_path";

private _deleteExistingWaypoints = false;
private _createNewWaypoint = false;
_path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance] call fn_groupUpdatePath;
if (count _path > _waypointChunkDistance) then {
    private _currentWaypointWorldPos = waypointPosition [_group, currentWaypoint _group];
    if (_currentWaypointWorldPos isEqualTo [0, 0, 0]) then {
        _deleteExistingWaypoints = true;
        _createNewWaypoint = true;
    } else {
        private _currentWaypointIndexPos = [_currentWaypointWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
        private _pathNextTarget = _path select _waypointChunkDistance;
        if !(_currentWaypointIndexPos isEqualTo _pathNextTarget) then {
            _deleteExistingWaypoints = true;
            _createNewWaypoint = true;
        };
    };
} else {
    _path = [];
    _deleteExistingWaypoints = true;
};

_migrationState set ["_path", _path];
if (_deleteExistingWaypoints) then {
    for [{private _w = 0}, {_w < count waypoints _group}, {_w = _w + 1}] do {
        deleteWaypoint [_group, 0];
    };
};
if (_createNewWaypoint) then {
    private _housePosWeight = _params get "_housePosWeight";
    private _roadPosWeight = _params get "_roadPosWeight";
    private _otherPosWeight = _params get "_otherPosWeight";
    private _newWaypointIndexPos = _path select _waypointChunkDistance;
    private _newWaypointWorldPos = [_newWaypointIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
    _group addWaypoint [_newWaypointWorldPos, 0];
};
