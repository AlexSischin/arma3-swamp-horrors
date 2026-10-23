params ["_params", "_state"];

private _chunkSize = _params get "_chunkSize";

private _groupWorldPos = _state get "_groupWorldPos";
private _path = _state get "_path";
private _nHops = _state get "_nHops";
private _groupMarker = _state get "_groupMarker";
private _pathMarkerArray = _state get "_pathMarkerArray";

_groupMarker setMarkerPos _groupWorldPos;
if (_nHops > 0) then {
    {deleteMarker _x} forEach _pathMarkerArray;
    _pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
    _state set ["_pathMarkerArray", _pathMarkerArray];
};
