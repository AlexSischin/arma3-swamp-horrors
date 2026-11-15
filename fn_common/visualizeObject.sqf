params [
    ["_object", objNull],
    ["_color", "Default"],
    ["_type", "mil_dot_noShadow"],
    ["_refreshPeriod", 5]
];

private _markerId = call fn_commonGenerateId;
private _markerName = format ["marker_%1", _markerId];
private _marker = createMarker [_markerName, _object];
_marker setMarkerColor _color;
_marker setMarkerType _type;

[_marker, _object, _refreshPeriod] spawn {
    params ["_marker", "_object", "_refreshPeriod"];

    while {!isNull _object} do {
        _marker setMarkerPos _object;
        _marker setMarkerDir getDir _object;

        sleep _refreshPeriod;
    };
    deleteMarker _marker;
};
