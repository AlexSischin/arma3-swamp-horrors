params [
    ["_chunkMap", nil],
    ["_color", "ColorBLUFOR"]
];

private _chunkMapId = _chunkMap select 0;
private _chunkGrid = _chunkMap select 1;
private _chunkSize = _chunkMap select 2;

private _maxChunkScore = 0;
for [{private _x_ = 0}, {_x_ < count _chunkGrid}, {_x_ = _x_ + 1}] do {
	private _chunkMapColumn = _chunkGrid select _x_;
    for [{private _y = 0}, {_y < count _chunkMapColumn}, {_y = _y + 1}] do {
		private _chunk = _chunkMapColumn select _y;

		private _chunkScore = _chunk select 1;
		_maxChunkScore = _maxChunkScore max _chunkScore;
	};
};

for [{private _x_ = 0}, {_x_ < count _chunkGrid}, {_x_ = _x_ + 1}] do {
	private _chunkMapColumn = _chunkGrid select _x_;

    for [{_y = 0}, {_y < count _chunkMapColumn}, {_y = _y + 1}] do {
		private _chunk = _chunkMapColumn select _y;

		private _chunkIndex = _chunk select 0;
		private _chunkPos = [_chunkIndex, _chunkSize] call fn_chunkGetPosForIndex;
		private _chunkScore = _chunk select 1;
		private _markerName = format ["chunk_%1_%2_%3", _chunkMapId, _x_, _y];
		private _marker = createMarker [_markerName, _chunkPos];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerSize [_chunkSize / 2, _chunkSize / 2];
		_marker setMarkerBrush "SOLID";
		_marker setMarkerColor _color;
		_marker setMarkerAlpha (_chunkScore / _maxChunkScore);
	};
};
