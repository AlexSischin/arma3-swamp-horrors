params ["_pathGrid", "_chunkGrid"];

private _sizeI = (count _pathGrid) min (count _chunkGrid);
private _sizeJ = (count (_pathGrid select 0)) min (count (_chunkGrid select 0));

private _combinedGrid = [];
for [{private _i = 0}, {_i < _sizeI}, {_i = _i + 1}] do {
    private _pathColumn = _pathGrid select _i;
    private _chunkColumn = _chunkGrid select _i;

    private _combinedColumn = [];
    for [{private _j = 0}, {_j < _sizeJ}, {_j = _j + 1}] do {
        private _pathCell = _pathColumn select _j;
        private _weightCell = _chunkColumn select _j;

        private _combinedCell = [[], 0];
        if ((count _pathCell) != 0) then {
            private _pathWeight = _pathCell select 1;
            if (_pathWeight > 0) then {
                private _chunkWeight = _weightCell select 1;
                private _combinedWeight = _chunkWeight / _pathWeight;
                private _path = _pathCell select 0;
                _combinedCell = [_path, _combinedWeight];
            };
        };

        _combinedColumn pushBack _combinedCell;
    };
    _combinedGrid pushBack _combinedColumn;
};
_combinedGrid
