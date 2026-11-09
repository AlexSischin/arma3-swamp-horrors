params ["_params", "_gameObjectState", "_migrationState"];
scopeName "main";

private _group = _gameObjectState get "_group";

private _leader = leader _group;
if !(alive _leader) exitWith {};

private _chunkSize = _params get "_chunkSize";
private _checkpointCompletionDistance = _params get "_checkpointCompletionDistance";
private _checkpointMaxDistance = _params get "_checkpointMaxDistance";
private _checkpointMode = _params get "_checkpointMode";

private _chunkMap = _params get "_chunkMap";
private _migrationMaxDistance = _params get "_migrationMaxDistance";
private _pathfindingMode = _params get "_pathfindingMode";
private _path = _migrationState get "_path";
private _groupWorldPos = getPos _leader;
private _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
_path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance, _pathfindingMode] call fn_groupUpdatePath;
_migrationState set ["_path", _path];

private _checkpointIsValid = false;
private _currentCheckpointWorldPos = ((expectedDestination _leader) # 0) select [0, 2];
if !(_currentCheckpointWorldPos isEqualTo [0, 0]) then {
    private _checkPointDistance = _groupWorldPos distance2D _currentCheckpointWorldPos;
    if (_checkPointDistance > _checkpointCompletionDistance && _checkPointDistance <= _checkpointMaxDistance) then {
        private _currentCheckpointIndexPos = [_currentCheckpointWorldPos, _chunkSize] call fn_chunkGetIndexForPos;

        for [{private _p = 0}, {_p < count _path}, {_p = _p + 1}] do {
            private _indexPos = _path # _p;

            if (_currentCheckpointIndexPos isEqualTo _indexPos) then {
                _checkpointIsValid = true;
            };
        };
    };
    if !(_checkpointIsValid) then {
        switch (_checkpointMode) do {
            case "WAYPOINT": {
                for [{private _w = 0}, {_w < count waypoints _group}, {_w = _w + 1}] do {
                    deleteWaypoint [_group, 0];
                };
            };
            case "DOMOVE": {
                private _units = [_group] call fn_objectGetGroupUnits;
                _units doMove (getPos _leader);
            };
            default {};
        };
    };
};
if (_checkpointIsValid) exitWith {};

private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _newCheckpointWorldPos = nil;
for [{private _p = 1}, {_p < count _path}, {_p = _p + 1}] do {
    private _indexPos = _path # _p;

    private _worldPos = [_indexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
    private _distance = _groupWorldPos distance2D _worldPos;
    if (_distance > _checkpointCompletionDistance) then {
        if (_distance <= _checkpointMaxDistance) then {
            _newCheckpointWorldPos = _worldPos;
        } else {
            breakTo "main";
        };
    };
};
if (isNil "_newCheckpointWorldPos") then {
    _migrationState set ["_path", []];
} else {
    switch (_checkpointMode) do {
        case "WAYPOINT": {
            for [{private _w = 0}, {_w < count waypoints _group}, {_w = _w + 1}] do {
                deleteWaypoint [_group, 0];
            };
            _group addWaypoint [_newCheckpointWorldPos, 0];
        };
        case "DOMOVE": {
            private _units = [_group] call fn_objectGetGroupUnits;
            _units doMove _newCheckpointWorldPos;
        };
        default {};
    };
};
