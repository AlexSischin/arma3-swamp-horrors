params ["_chunkMap"];

private _chunkId = _chunkMap # 0;
private _cacheKey = format ["inverseWeightGrid_%1", _chunkId];

if (_cacheKey call fn_commonCacheHas) exitWith {_cacheKey call fn_commonCacheGet};

private _chunkGrid = _chunkMap # 1;
private _weightGrid = createHashMap;
{
    private _weight = _y # 1;
    if (_weight > 0) then {
        _weightGrid set [_x, 1 / _weight];
    };
} forEach _chunkGrid;
[_cacheKey, _weightGrid] call fn_commonCachePut;
_weightGrid
