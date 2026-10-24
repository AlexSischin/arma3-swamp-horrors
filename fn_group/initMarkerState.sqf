params ["_params", "_posState"];

private _chunkSize = _params get "_chunkSize";

private _groupWorldPos = _posState get "_groupWorldPos";

private _groupMarker = [_groupWorldPos, "ColorBLUFOR", "b_inf"] call fn_commonVisualizePoint;

private _markerState = createHashMap;
_markerState set ["_groupMarker", _groupMarker];
_markerState set ["_pathMarkerArray", []];
_markerState
