params ["_groupWorldPos", "_nUnits", "_nVehicles"];

private _safePosParams = [_nUnits, _nVehicles] call fn_groupCalculateSafePosParams;
private _radius = _safePosParams select 0;
private _objDist = _safePosParams select 1;
private _innerSquareSize = _radius / sqrt 2;
private _defaultPos = [
    random (2 * _innerSquareSize) - _innerSquareSize,
    random (2 * _innerSquareSize) - _innerSquareSize,
    0
];
_pos = [_groupWorldPos, 0, _radius, _objDist, 1, 0, 0, [], _defaultPos] call BIS_fnc_findSafePos;
_pos
