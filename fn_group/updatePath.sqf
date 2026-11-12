params ["_chunkMap", "_path", "_groupIndexPos", "_migrationMaxDistance", "_destination", "_pathfindingMode"];

if (_destination isEqualTo _groupIndexPos) exitWith {[]};

private _pathFinishPointIsValid = true;
if !(_destination isEqualTo []) then {
    if (count _path == 0) then {
        _pathFinishPointIsValid = false;
    } else {
        private _currentDestination = _path select -1;
        _pathFinishPointIsValid = _currentDestination isEqualTo _destination;
    };
};

private _remainingPath = [];
if (_pathFinishPointIsValid) then {
    private _onTrack = false;
    for [{private _i = 0}, {_i < count _path}, {_i = _i + 1}] do {
        private _point = _path select _i;

        if (_point isEqualTo _groupIndexPos) then {
            _onTrack = true;
        };
        if (_onTrack) then {
            _remainingPath pushBack _point;
        };
    };
};
if (count _remainingPath > 1) exitWith {_remainingPath};

if ((_destination isEqualTo []) && (count _path > 1)) then {
    _destination = _path select -1;
};
private _newPathToTarget = [];
if !(_destination isEqualTo []) then {
    _newPathToTarget = [_chunkMap, _groupIndexPos, _destination] call fn_groupChoosePathToTarget;
};
if (count _newPathToTarget > 1) exitWith {_newPathToTarget};

private _newRandomPath = nil;
switch (_pathfindingMode) do {
    case "NORMAL": {
        _newRandomPath = [_chunkMap, _groupIndexPos, _migrationMaxDistance] call fn_groupChooseRandomPath;
    };
    case "SIMPLE": {
        _newRandomPath = [_chunkMap, _groupIndexPos, _migrationMaxDistance] call fn_groupChooseSimpleRandomPath;
    };
    default {};
};
if (count _newRandomPath > 0) exitWith {_newRandomPath};

private _newBackoffPath = [_chunkMap, _groupIndexPos] call fn_groupChooseBackoffPath;
if (count _newBackoffPath > 1) exitWith {_newBackoffPath};

private _randomNeighbourPath = [_groupIndexPos] call fn_pathFindRandomNeighbourPath;
_randomNeighbourPath
