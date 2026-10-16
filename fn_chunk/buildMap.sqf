params [
    "_chunkSize",
    "_scoreFunctionArray"
];

private _chunkMapId = call fn_commonGenerateId;
private _chunkMaxIndex = ceil (worldSize / _chunkSize);
private _chunkGrid = [];
for [{private _x_ = 0}, {_x_ < _chunkMaxIndex}, {_x_ = _x_ + 1}] do {

	private _chunkMapColumn = [];
    for [{private _y = 0}, {_y < _chunkMaxIndex}, {_y = _y + 1}] do {

        private _chunkIndex = [_x_, _y];
        private _chunkCenter = [_chunkIndex, _chunkSize] call fn_chunkGetPosForIndex;
		private _chunkScore = 0;
		for [{private _f = 0}, {_f < count _scoreFunctionArray}, {_f = _f + 1}] do {
		    private _scoreFunction = _scoreFunctionArray select _f;
		    private _score = [_chunkCenter, _chunkSize] call _scoreFunction;
		    _chunkScore = _chunkScore + _score;
		};
		_chunkScore = (0 max _chunkScore);

		private _chunk = [_chunkIndex, _chunkScore];
        _chunkMapColumn pushBack _chunk;
    };
	_chunkGrid pushBack _chunkMapColumn;
};

[_chunkMapId, _chunkGrid, _chunkSize]
