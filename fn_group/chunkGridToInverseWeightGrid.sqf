params ["_chunkMap"];

private _chunkId = _chunkMap # 0;
private _cacheKey = format ["inverseWeightGrid_%1", _chunkId];

if (_cacheKey call fn_commonCacheHas) exitWith {_cacheKey call fn_commonCacheGet};

private _chunkGrid = _chunkMap # 1;
if (count _chunkGrid == 0) exitWith {[createHashMap, 0]};

private _pathGrid = createHashMap;
private _randomChunk = {breakWith _y} forEach _chunkGrid;
private _minWeight = _randomChunk # 1;
{
    private _weight = _y # 1;
    if (_weight > 0) then {
        private _pathWeight = 1 / _weight;
        _pathGrid set [_x, _pathWeight];

        if (_pathWeight < _minWeight) then {
            _minWeight = _pathWeight;
        };
    };
} forEach _chunkGrid;

private _pathMap = [_pathGrid, _minWeight];
[_cacheKey, _pathMap] call fn_commonCachePut;
_pathMap
