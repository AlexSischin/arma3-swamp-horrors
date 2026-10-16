params ["_weightGrid", "_fromPoint"];

private _sizeI = count _weightGrid;
private _sizeJ = count (_weightGrid select 0);
private _neighbourPointArray = [_fromPoint, [_sizeI, _sizeJ]] call fn_pathGetNeighbourPointArray;
private _toPoint = selectRandom _neighbourPointArray;
private _path = [_fromPoint, _toPoint];
_path
