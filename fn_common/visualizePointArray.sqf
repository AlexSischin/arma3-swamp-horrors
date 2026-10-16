params [
    ["_pointArray", []],
    ["_color", "colorBLUFOR"]
];

private _markerArray = [];
for [{private _i = 0}, {_i < count _pointArray}, {_i = _i + 1}] do {
    private _point = _pointArray select _i;

    private _marker = [_point, _color] call fn_commonVisualizePoint;
    _markerArray pushBack _marker;
};
_markerArray
