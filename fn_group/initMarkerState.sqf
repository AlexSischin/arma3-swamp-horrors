params ["_params", "_posState"];

private _markersEnabled = _params get "_markersEnabled";

if (!_markersEnabled) exitWith {createHashMap};

private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = _posState get "_groupIndexPos";

private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _groupMarker = [_groupWorldPos, "ColorBLUFOR", "b_inf"] call fn_commonVisualizePoint;

private _markerState = createHashMap;
_markerState set ["_groupMarker", _groupMarker];
_markerState set ["_pathMarkerArray", []];
_markerState set ["_destinationMarker", nil];
_markerState
