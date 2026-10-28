params ["_params", "_posState", "_gameObjectState", "_migrationState", "_markerState"];

private _markersEnabled = _params get "_markersEnabled";

if (!_markersEnabled) exitWith {};

private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = _posState get "_groupIndexPos";
private _groupMarker = _markerState get "_groupMarker";
private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
_groupMarker setMarkerPos _groupWorldPos;

private _path = _migrationState get "_path";
private _pathMarkerArray = _markerState get "_pathMarkerArray";
{deleteMarker _x} forEach _pathMarkerArray;
_pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
_markerState set ["_pathMarkerArray", _pathMarkerArray];

private _waypointMarker = _markerState get "_waypointMarker";
if !(isNil "_waypointMarker") then {
    deleteMarker _waypointMarker;
    _markerState set ["_waypointMarker", nil];
};
private _group = _gameObjectState get "_group";
private _currentWaypointWorldPos = waypointPosition [_group, currentWaypoint _group];
if !(_currentWaypointWorldPos isEqualTo [0, 0, 0]) then {
    _waypointMarker = [_currentWaypointWorldPos, "ColorBLUFOR", "mil_circle_noShadow"] call fn_commonVisualizePoint;
    _markerState set ["_waypointMarker", _waypointMarker];
};
