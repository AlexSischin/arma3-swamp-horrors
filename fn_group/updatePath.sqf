params ["_chunkMap", "_indexPath", "_groupIndexPos", "_migrationMaxDistance"];

private _onTrack = false;
private _remainingPath = [];
for [{private _i = 0}, {_i < count _indexPath}, {_i = _i + 1}] do {
    private _point = _indexPath select _i;

    if (_point isEqualTo _groupIndexPos) then {
        _onTrack = true;
    };
    if (_onTrack) then {
        _remainingPath pushBack _point;
    };
};

if (count _remainingPath > 1) exitWith {_remainingPath};

private _newPathToTarget = [];
if (count _indexPath > 1) then {
    private _target = _indexPath select -1;
    _newPathToTarget = [_chunkMap, _groupIndexPos, _target] call fn_groupChoosePathToTarget;
};
if (count _newPathToTarget > 1) exitWith {_newPathToTarget};

private _newRandomPath = [_chunkMap, _groupIndexPos, _migrationMaxDistance] call fn_groupChooseRandomPath;
if (count _newRandomPath > 0) exitWith {_newRandomPath};

private _newBackoffPath = [_chunkMap, _groupIndexPos] call fn_groupChooseBackoffPath;
if (count _newBackoffPath > 1) exitWith {_newBackoffPath};

private _randomNeighbourPath = [_chunkMap, _groupIndexPos] call fn_groupChooseRandomNeighbourPath;
_randomNeighbourPath
