params ["_chunkMap", "_time", "_path", "_groupIndexPos", "_speedKmH", "_migrationMaxDistance"];

private _chunkSize = _chunkMap select 2;

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
private _migrationPlan = [_path, _groupIndexPos, _nHops, _untraveledTime];
_migrationPlan
