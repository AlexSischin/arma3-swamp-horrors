params [
    "_chunkSize",
    "_scoreFunctionArray"
];

private _chunkGridSizeX = ceil (worldSize / _chunkSize);
private _chunkGridSizeY = _chunkGridSizeX;
private _chunkGrid = createHashMap;
for [{private _x_ = 0}, {_x_ < _chunkGridSizeX}, {_x_ = _x_ + 1}] do {

    for [{private _y = 0}, {_y < _chunkGridSizeY}, {_y = _y + 1}] do {

        private _chunkIndex = [_x_, _y];
        private _chunkCenter = [_chunkIndex, _chunkSize] call fn_chunkGetPosForIndex;
		private _chunkScore = 0;
		for [{private _f = 0}, {_f < count _scoreFunctionArray}, {_f = _f + 1}] do {
		    private _scoreFunction = _scoreFunctionArray select _f;
		    private _score = [_chunkCenter, _chunkSize] call _scoreFunction;
		    _chunkScore = _chunkScore + _score;
		};
		if (_chunkScore > 0) then {
			private _key = [_x_, _y] call fn_commonIjToKey;
			private _chunk = [_chunkIndex, _chunkScore];
			_chunkGrid set [_key, _chunk];
		};
    };
};

private _chunkMapId = call fn_commonGenerateId;
private _chunkGridSize = [_chunkGridSizeX, _chunkGridSizeY];
[_chunkMapId, _chunkGrid, _chunkSize, _chunkGridSize]
