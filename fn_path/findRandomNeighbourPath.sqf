params ["_fromPoint", "_xMin", "_xMax", "_yMin", "_yMax"];

private _neighbourPointArray = _fromPoint call fn_pathGetNeighbourPointArray;
private _validNeighbourPointArray = _neighbourPointArray
    select {_x # 0 >= _xMin}
    select {_x # 0 < _xMax}
    select {_x # 1 >= _yMin}
    select {_x # 1 < _yMax};
private _toPoint = selectRandom _validNeighbourPointArray;
private _path = [_fromPoint, _toPoint];
_path
