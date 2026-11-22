params [
    ["_object", objNull],
    ["_color", "Default"],
    ["_type", "mil_dot_noShadow"],
    ["_refreshPeriod", 5],
    ["_trackRotation", false]
];

private _markerId = call LCX_fnc_generateId;
private _markerName = format ["marker_%1", _markerId];
private _marker = createMarker [_markerName, _object];
_marker setMarkerColor _color;
_marker setMarkerType _type;

[_marker, _object, _refreshPeriod, _trackRotation] spawn {
    params ["_marker", "_object", "_refreshPeriod", "_trackRotation"];

    while {!isNull _object} do {
        _marker setMarkerPos _object;
        if (_trackRotation) then {
            _marker setMarkerDir getDir _object;
        };

        sleep _refreshPeriod;
    };
    deleteMarker _marker;
};
