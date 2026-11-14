params ["_chunkMap", "_path", "_groupIndexPos", "_migrationMaxDistance", "_destination", "_lastDestination", "_pathfindingMode"];
scopeName "main";

private _remainingPath = [];
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

if (_destination isEqualTo []) then {
    if (_destination isEqualTo _lastDestination) then {
        if (count _remainingPath > 1) then {
            _remainingPath breakOut "main";
        };

        if (count _path > 0) then {
            private _pathDestination = _path select -1;
            private _newPathToSameDestination = [_chunkMap, _groupIndexPos, _pathDestination] call fn_groupChoosePathToTarget;
            if (count _newPathToSameDestination > 1) then {
                _newPathToSameDestination breakOut "main";
            };
        };
    };

    private _newRandomPath = [];
    switch (_pathfindingMode) do {
        case "NORMAL": {
            _newRandomPath = [_chunkMap, _groupIndexPos, _migrationMaxDistance] call fn_groupChooseRandomPath;
        };
        case "SIMPLE": {
            _newRandomPath = [_chunkMap, _groupIndexPos, _migrationMaxDistance] call fn_groupChooseSimpleRandomPath;
        };
        default {};
    };
    if (count _newRandomPath > 0) then {
        _newRandomPath breakOut "main";
    };

    private _newBackoffPath = [_chunkMap, _groupIndexPos] call fn_groupChooseBackoffPath;
    if (count _newBackoffPath > 1) then {
        _newBackoffPath breakOut "main";
    };
} else {
    if ((_destination isEqualTo _lastDestination) && (count _remainingPath > 0)) then {
        _remainingPath breakOut "main";
    } else {
        private _newPathToDestination = [_chunkMap, _groupIndexPos, _destination] call fn_groupChoosePathToTarget;
        if (count _newPathToDestination > 0) then {
            _newPathToDestination breakOut "main";
        };

        private _newBackoffPath = [_chunkMap, _groupIndexPos] call fn_groupChooseBackoffPath;
        if (count _newBackoffPath > 0) then {
            private _backoffPoint = _newBackoffPath select -1;
            private _pathToDestinationFromBackoffPoint = [_chunkMap, _backoffPoint, _destination] call fn_groupChoosePathToTarget;
            private _newBackoffWithPathToDestination = [_newBackoffPath, _pathToDestinationFromBackoffPoint] call fn_pathConcat;
            if (count _newBackoffWithPathToDestination > 1) then {
                _newBackoffWithPathToDestination breakOut "main";
            };
        };
    };
};

private _chunkSize = _chunkMap # 2;
private _randomNeighbourPath = [_groupIndexPos, 0, _chunkSize, 0, _chunkSize] call fn_pathFindRandomNeighbourPath;
_randomNeighbourPath breakOut "main";
