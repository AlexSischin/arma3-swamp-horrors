// Searches the most optimal path for nearby points using Dijkstra algorithm.
// _weightGrid - 2D array with numbers representing weights.
// _fromPoint - starting point for search.
// _maxPathLength - max distance to search within.
// returns a grid with the same dimensions as _weightGrid.
// Each cell contains the shortest path from the _fromPoint to the cell.
// This function works purely with indices, not metric distances.
params ["_weightGrid", "_fromPoint", "_maxPathLength"];

private _sizeI = count _weightGrid;
private _sizeJ = count (_weightGrid select 0);

private _pathGrid = [];
for [{private _i = 0}, {_i < _sizeI}, {_i = _i + 1}] do {

    private _pathColumn = [];
    _pathColumn resize [_sizeJ, []];
    _pathGrid pushBack _pathColumn;
};

private _fromPointI = _fromPoint select 0;
private _fromPointJ = _fromPoint select 1;
private _fromPointWeight = (_weightGrid select _fromPointI) select _fromPointJ;
if (_fromPointWeight < 0) exitWith {[]};

(_pathGrid select _fromPointI) set [_fromPointJ, [[_fromPoint], _fromPointWeight]];
private _pointToVisitArray = [[_fromPoint, _fromPointWeight]];

while {count _pointToVisitArray > 0} do {
    private _pointToVisit = _pointToVisitArray select 0;
    _pointToVisitArray deleteAt 0;

    private _point = _pointToVisit select 0;
    private _pointCumWeight = _pointToVisit select 1;
    private _i = _point select 0;
    private _j = _point select 1;
    private _pathGridCell = (_pathGrid select _i) select _j;
    private _pointPath = _pathGridCell select 0;
    private _pointWeight = _pathGridCell select 1;
    private _neighbourPointArray = [_point, [_sizeI, _sizeJ]] call fn_pathGetNeighbourPointArray;
    for [{private _n = 0}, {_n < count _neighbourPointArray}, {_n = _n + 1}] do {
        private _neighbourPoint = _neighbourPointArray select _n;

        private _neighbourPointI = _neighbourPoint select 0;
        private _neighbourPointJ = _neighbourPoint select 1;
        private _pathColumn = _pathGrid select _neighbourPointI;
        private _neighbourPointWeight = (_weightGrid select _neighbourPointI) select _neighbourPointJ;
        private _neighbourPointIsEvaluated = count (_pathColumn select _neighbourPointJ) != 0;
        private _neighbourPointIsTraversable = _neighbourPointWeight > 0;
        private _neighbourPointIsWithinMaxDistance = (count _pointPath) <= _maxPathLength;
        if (!_neighbourPointIsEvaluated && _neighbourPointIsTraversable && _neighbourPointIsWithinMaxDistance) then {
            private _neighbourPointCumWeight = _neighbourPointWeight + _pointCumWeight;
            private _neighbourPointPath = _pointPath + [_neighbourPoint];
            _pathColumn set [_neighbourPointJ, [_neighbourPointPath, _neighbourPointCumWeight]];
            [_pointToVisitArray, [_neighbourPoint, _neighbourPointCumWeight], {_this select 1}] call fn_commonSortedInsert;
        };
    };
};
_pathGrid
