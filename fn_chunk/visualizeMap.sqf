params [
    ["_chunkMap", nil],
    ["_color", "ColorBLUFOR"]
];

private _chunkMapId = _chunkMap # 0;
private _chunkGrid = _chunkMap # 1;
private _chunkSize = _chunkMap # 2;

private _maxChunkScore = 0;
{
	_maxChunkScore = _maxChunkScore max (_y # 1);
} forEach _chunkGrid;

{
	private _chunkIndex = _y # 0;
	private _chunkScore = _y # 1;
	private _chunkPos = [_chunkIndex, _chunkSize] call fn_chunkGetPosForIndex;
	private _markerName = format ["chunk_%1_%2", _chunkMapId, str _x];
	private _marker = createMarker [_markerName, _chunkPos];
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerSize [_chunkSize / 2, _chunkSize / 2];
	_marker setMarkerBrush "SOLID";
	_marker setMarkerColor _color;
	_marker setMarkerAlpha (_chunkScore / _maxChunkScore);
} forEach _chunkGrid;
