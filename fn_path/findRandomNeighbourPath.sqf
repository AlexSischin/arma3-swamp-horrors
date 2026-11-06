params ["_fromPoint"];

private _neighbourPointArray = _fromPoint call fn_pathGetNeighbourPointArray;
private _toPoint = selectRandom _neighbourPointArray;
private _path = [_fromPoint, _toPoint];
_path
