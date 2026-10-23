params ["_params", "_state"];

private _chunkMap = _params get "_chunkMap";
private _chunkSize = _params get "_chunkSize";
private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _speedKmH = _params get "_speedKmH";
private _migrationMaxDistance = _params get "_migrationMaxDistance";
private _delay = _params get "_delay";

private _groupIndexPos = _state get "_groupIndexPos";
private _group = _state get "_group";
private _path = _state get "_path";
private _untraveledTime = _state get "_untraveledTime";

private _time = _untraveledTime + _delay;
private _pathHopPlan = [_time, _speedKmH, _chunkSize] call fn_groupCalculatePathHopPlan;
private _nHops = _pathHopPlan select 0;
private _untraveledTime = _pathHopPlan select 1;
private _currentPath = _path;
private _newTargetWorldPos = nil;
private _deleteExistingWaypoints = false;
private _createNewWaypoint = false;
if (_nHops > 0) then {
    _path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance] call fn_groupUpdatePath;
    if (count _path > 1) then {
        private _currentWaypointWorldPos = waypointPosition [_group, currentWaypoint _group];
        if (_currentWaypointWorldPos isEqualTo [0, 0, 0]) then {
            _deleteExistingWaypoints = true;
            _createNewWaypoint = true;
        } else {
            private _currentWaypointIndexPos = [_currentWaypointWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
            private _pathNextTarget = _path select 1;
            if !(_currentWaypointIndexPos isEqualTo _pathNextTarget) then {
                _deleteExistingWaypoints = true;
                _createNewWaypoint = true;
            };
        };
    } else {
        _deleteExistingWaypoints = true;
    };
};
private _newWaypointWorldPos = nil;
if (_createNewWaypoint) then {
    private _newWaypointIndexPos = _path select 1;
    _newWaypointWorldPos = [_newWaypointIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectUnitPos;
};

_state set ["_path", _path];
_state set ["_untraveledTime", _untraveledTime];
_state set ["_nHops", _nHops];

if (_deleteExistingWaypoints) then {
    for [{private _w = 0}, {_w < count waypoints _group}, {_w = _w + 1}] do {
        deleteWaypoint [_group, 0];
    };
};
if (_createNewWaypoint) then {
    _group addWaypoint [_newWaypointWorldPos, 0];
};
