params ["_chunkMap", "_fromPoint", "_migrationMaxDistance"];
scopeName "main";

private _chunkGrid = _chunkMap # 1;
private _visitedPointMap = createHashMap;
private _path = [_fromPoint];
for [{private _s = 0}, {_s < _migrationMaxDistance}, {_s = _s + 1}] do {
    private _point = _path # -1;

    private _neighbourPointArray = _point call fn_pathGetNeighbourPointArray;
    private _neighbourGrid = createHashMap;
    for [{private _p = 0}, {_p < count _neighbourPointArray}, {_p = _p + 1}] do {
        private _neighbourPoint = _neighbourPointArray # _p;

        private _chunkKey = _neighbourPoint call fn_commonIjToKey;
        private _chunkValue = _chunkGrid get _chunkKey;
        if !(isNil "_chunkValue") then {
            if !(_chunkKey in _visitedPointMap) then {
                _neighbourGrid set [_chunkKey, _chunkValue];
                _visitedPointMap set [_chunkKey, _chunkKey];
            };
        };
    };
    if (count _neighbourGrid == 0) then {
        breakTo "main";
    };

    private _nextPoint = ([_neighbourGrid, {_this # 1}] call fn_commonSelectRandomWeightedFromHashMap) # 0;
    _path pushBack _nextPoint;
};
_path
