params ["_params", "_state"];

private _chunkSize = _params get "_chunkSize";

private _groupWorldPos = _state get "_groupWorldPos";
private _path = _state get "_path";

private _groupMarker = [_groupWorldPos, "ColorBLUFOR", "b_inf"] call fn_commonVisualizePoint;
private _pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
_state set ["_groupMarker", _groupMarker];
_state set ["_pathMarkerArray", _pathMarkerArray];
