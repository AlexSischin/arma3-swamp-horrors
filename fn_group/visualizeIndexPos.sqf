params [
    ["_indexPos", nil],
    ["_chunkSize", nil],
    ["_color", "colorBLUFOR"],
    ["_icon", "b_inf"]
];

private _chunkCenterPos = [_indexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _marker = [_chunkCenterPos, _color, _icon] call fn_commonVisualizePoint;
_marker
