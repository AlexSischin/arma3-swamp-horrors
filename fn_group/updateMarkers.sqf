params ["_params", "_posState", "_migrationState", "_markerState"];

private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = _posState get "_groupIndexPos";
private _path = _migrationState get "_path";
private _nHops = _migrationState get "_nHops";
private _groupMarker = _markerState get "_groupMarker";
private _pathMarkerArray = _markerState get "_pathMarkerArray";

private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
_groupMarker setMarkerPos _groupWorldPos;
if (_nHops > 0) then {
    {deleteMarker _x} forEach _pathMarkerArray;
    _pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
    _markerState set ["_pathMarkerArray", _pathMarkerArray];
};
