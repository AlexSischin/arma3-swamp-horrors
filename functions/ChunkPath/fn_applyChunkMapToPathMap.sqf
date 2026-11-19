params ["_pathGrid", "_chunkGrid"];

private _combinedGrid = createHashMap;
{
    private _pathWeight = _y # 1;
    if (_pathWeight > 0) then {
        private _chunk = _chunkGrid getOrDefault [_x, 0];
        private _chunkWeight = _chunk # 1;
        if (_chunkWeight > 0) then {
            private _path = _y # 0;
            private _combinedWeight = _chunkWeight / _pathWeight;
            _combinedGrid set [_x, [_path, _combinedWeight]];
        };
    };
} forEach _pathGrid;
_combinedGrid
