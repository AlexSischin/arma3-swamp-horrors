params [
    ["_pos", nil],
    ["_radius", nil],
    ["_brush", "Border"],
    ["_color", "ColorBlack"],
    ["_icon", "loc_search"],
    ["_text", ""],
    ["_alpha", 1]
];

private _markerId = call LCX_fnc_generateId;
private _markerName = format ["search_area_%1", _markerId];
private _markerPos = [_radius, _pos] call LCX_fnc_randomCirclePoint;
private _marker = createMarker [_markerName, _markerPos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [_radius, _radius];
_marker setMarkerColor _color;
_marker setMarkerBrush _brush;
_marker setMarkerAlpha _alpha;

private _iconMarker = "";
if !(_icon isEqualTo "") then {
    private _iconMarkerName = _markerName + "_icon";
    _iconMarker = createMarker [_iconMarkerName, _markerPos];
    _iconMarker setMarkerType _icon;
    _iconMarker setMarkerColor _color;
    if !(_text isEqualTo "") then {
        _iconMarker setMarkerText _text;
    };
};

[_marker, _iconMarker]
