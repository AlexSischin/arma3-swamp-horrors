params ["_chunkMap"];

private _chunkId = _chunkMap select 0;
private _cacheKey = format ["inverseWeightGrid_%1", _chunkId];

if (_cacheKey call fn_commonCacheHas) exitWith {_cacheKey call fn_commonCacheGet};

private _chunkGrid = _chunkMap select 1;
private _weightGrid = [];
for [{private _i = 0}, {_i < count _chunkGrid}, {_i = _i + 1}] do {
    private _chunkColumn = _chunkGrid select _i;

    private _weightColumn = [];
    for [{private _j = 0}, {_j < count _chunkColumn}, {_j = _j + 1}] do {
        private _chunk = _chunkColumn select _j;

        private _weight = _chunk select 1;
        private _inverseWeight = -1;
        if (_weight > 0) then {
            _inverseWeight = 1 / _weight;
        };
        _weightColumn pushBack _inverseWeight;
    };
    _weightGrid pushBack _weightColumn;
};
[_cacheKey, _weightGrid] call fn_commonCachePut;
_weightGrid
