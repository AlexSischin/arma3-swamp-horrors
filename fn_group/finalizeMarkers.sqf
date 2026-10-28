params ["_params", "_posState", "_markerState"];

private _markersEnabled = _params get "_markersEnabled";

if (!_markersEnabled) exitWith {};

private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = _posState get "_groupIndexPos";
private _groupMarker = _markerState get "_groupMarker";
private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
_groupMarker setMarkerPos _groupWorldPos;
_groupMarker setMarkerColor "ColorGrey";

private _pathMarkerArray = _markerState get "_pathMarkerArray";
{deleteMarker _x} forEach _pathMarkerArray;
