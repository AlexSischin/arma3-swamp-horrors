params [
    ["_point", nil],
    ["_color", "colorBLUFOR"],
    ["_type", "mil_dot_noShadow"]
];

private _markerId = call fn_commonGenerateId;
private _markerName = format ["marker_%1", _markerId];
private _marker = createMarker [_markerName, _point];
_marker setMarkerType _type;
_marker setMarkerColor _color;
_marker
