params ["_params", "_posState", "_gameObjectState", "_migrationState", "_markerState"];

private _markersEnabled = _params get "_markersEnabled";

if (!_markersEnabled) exitWith {};

private _chunkSize = _params get "_chunkSize";
private _markerColor = _params get "_markerColor";

private _groupIndexPos = _posState get "_groupIndexPos";
private _groupMarker = _markerState get "_groupMarker";
private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
_groupMarker setMarkerPos _groupWorldPos;

private _path = _migrationState get "_path";
private _pathMarkerArray = _markerState get "_pathMarkerArray";
{deleteMarker _x} forEach _pathMarkerArray;
_pathMarkerArray = [_path, _chunkSize, _markerColor] call fn_groupVisualizeIndexPath;
_markerState set ["_pathMarkerArray", _pathMarkerArray];

private _destinationMarker = _markerState get "_destinationMarker";
if !(isNil "_destinationMarker") then {
    deleteMarker _destinationMarker;
    _markerState set ["_destinationMarker", nil];
};
private _group = _gameObjectState get "_group";
private _currentDestination = expectedDestination leader _group;
private _currentDestinationWorldPos = (_currentDestination select 0) select [0, 2];
if !(_currentDestinationWorldPos isEqualTo [0, 0]) then {
    _destinationMarker = [_currentDestinationWorldPos, _markerColor, "mil_circle_noShadow"] call fn_commonVisualizePoint;
    _markerState set ["_destinationMarker", _destinationMarker];
};
