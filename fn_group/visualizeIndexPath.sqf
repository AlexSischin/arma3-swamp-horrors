params [
    ["_indexPath", nil],
    ["_chunkSize", nil],
    ["_color", "colorBLUFOR"]
];

if (count _indexPath == 0) exitWith {[]};

private _chunkCenterPath = [_indexPath, _chunkSize] call fn_chunkGetPosForIndexArray;
private _pathLength = count _chunkCenterPath;

if (_pathLength == 0) exitWith {[]};

private _destination = _chunkCenterPath select -1;
private _destinationMarker = [_destination, _color, "mil_end_noShadow"] call fn_commonVisualizePoint;
if (_pathLength == 1) exitWith {[_destinationMarker]};

private _markerArray = [];
for [{private _i = 0}, {_i < _pathLength - 1}, {_i = _i + 1}] do {
    private _point = _chunkCenterPath select _i;
    private _nextPoint = _chunkCenterPath select (_i + 1);

    private _vector = _nextPoint vectorDiff _point;
    private _dir = (_vector select 0) atan2 (_vector select 1);
    private _marker = [_point, _color, "mil_arrow_noShadow"] call fn_commonVisualizePoint;
    _marker setMarkerDir _dir;
    _markerArray pushBack _marker;
};
_markerArray pushBack _destinationMarker;
_markerArray
