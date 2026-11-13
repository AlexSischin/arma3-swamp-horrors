params ["_params", "_posState", "_migrationState"];

private _chunkSize = _params get "_chunkSize";
private _speedKmH = _params get "_speedKmH";
private _delay = _params get "_delay";
private _untraveledTime = _migrationState get "_untraveledTime";
private _time = _untraveledTime + _delay;
private _pathHopPlan = [_time, _speedKmH, _chunkSize] call fn_groupCalculatePathHopPlan;
private _nHops = _pathHopPlan select 0;
private _untraveledTime = _pathHopPlan select 1;
_migrationState set ["_untraveledTime", _untraveledTime];

if (_nHops > 0) then {
    private _path = _migrationState get "_path";
    private _chunkMap = _params get "_chunkMap";
    private _migrationMaxDistance = _params get "_migrationMaxDistance";
    private _pathfindingMode = _params get "_pathfindingMode";
    private _groupIndexPos = _posState get "_groupIndexPos";
    private _destination = _migrationState get "_destination";
    private _destinationIndexPos = [];
    if !(_destination isEqualTo []) then {
        _destinationIndexPos = [_destination, _chunkSize] call fn_chunkGetIndexForPos;
    };
    private _lastDestination = _migrationState get "_lastDestination";
    private _lastDestinationIndexPos = [];
    if !(_lastDestination isEqualTo []) then {
        if (_lastDestination isEqualTo _destination) then {
            _lastDestinationIndexPos = _destinationIndexPos;
        } else {
            _lastDestinationIndexPos = [_lastDestination, _chunkSize] call fn_chunkGetIndexForPos;
        };
    };
    private _nHopsRemaining = _nHops;
    while {_nHopsRemaining > 0} do {
        _path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance, _destinationIndexPos, _lastDestinationIndexPos, _pathfindingMode] call fn_groupUpdatePath;
        if (count _path > 1) then {
            private _currentPathHops = _nHopsRemaining min ((count _path) - 1);
            _nHopsRemaining = _nHopsRemaining - _currentPathHops;
            _path deleteRange [0, _currentPathHops];
            _groupIndexPos = _path select 0;
            _posState set ["_groupIndexPos", _groupIndexPos];
        } else {
            _nHopsRemaining = _nHopsRemaining - 1;
        };
    };
    _migrationState set ["_path", _path];
    _migrationState set ["_lastDestination", _destination];
};
