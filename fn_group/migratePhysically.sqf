params ["_params", "_posState", "_gameObjectState", "_migrationState"];
scopeName "main";

private _chunkMap = _params get "_chunkMap";
private _chunkSize = _params get "_chunkSize";
private _migrationMaxDistance = _params get "_migrationMaxDistance";
private _destinationChunkDistance = _params get "_destinationChunkDistance";
private _migrationMode = _params get "_migrationMode";
private _groupIndexPos = _posState get "_groupIndexPos";
private _group = _gameObjectState get "_group";
private _path = _migrationState get "_path";

_path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance] call fn_groupUpdatePath;
if (count _path <= _destinationChunkDistance) then {
    _path = [];
};
_migrationState set ["_path", _path];

private _leader = leader _group;
if !(alive _leader) exitWith {};

if (_path isEqualTo []) exitWith {
    switch (_migrationMode) do {
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

private _currentDestination = expectedDestination _leader;
private _currentDestinationWorldPos = (_currentDestination select 0) select [0, 2];
if !(_currentDestinationWorldPos isEqualTo [0, 0]) then {
    private _currentDestinationIndexPos = [_currentDestinationWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
    private _pathNextTarget = _path select _destinationChunkDistance;
    if (_currentDestinationIndexPos isEqualTo _pathNextTarget) then {
        if ((getUnitState _leader) != "WAIT") then {
            breakOut "main";
        };
    };
};

private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _newDestinationIndexPos = _path select _destinationChunkDistance;
private _newDestinationWorldPos = [_newDestinationIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
switch (_migrationMode) do {
    case "WAYPOINT": {
        for [{private _w = 0}, {_w < count waypoints _group}, {_w = _w + 1}] do {
            deleteWaypoint [_group, 0];
        };
        _group addWaypoint [_newDestinationWorldPos, 0];
    };
    case "DOMOVE": {
        private _units = [_group] call fn_objectGetGroupUnits;
        _units doMove _newDestinationWorldPos;
    };
    default {};
};
