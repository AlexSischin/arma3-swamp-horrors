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
private _groupWorldPos = _state get "_groupWorldPos";
private _path = _state get "_path";
private _untraveledTime = _state get "_untraveledTime";

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
        _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectUnitPos;
    } else {
        _nHopsRemaining = _nHopsRemaining - 1;
    };
};

_state set ["_groupIndexPos", _groupIndexPos];
_state set ["_groupWorldPos", _groupWorldPos];
_state set ["_path", _path];
_state set ["_untraveledTime", _untraveledTime];
_state set ["_nHops", _nHops];
