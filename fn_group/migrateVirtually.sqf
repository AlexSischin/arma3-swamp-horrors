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
_migrationState set ["_nHops", _nHops];
