// Searches the most optimal path for nearby points using Dijkstra algorithm.
// _weightGrid - HashMap where keys represent coordinates and values represent weights.
// _fromPoint - starting point for search.
// _maxPathLength - max distance to search within.
// returns a HashMap grid with keys as coordinates
// and value as a tuple containing the shortest path to it and path weight.
// This function works purely with indices, not metric distances.
params ["_weightGrid", "_fromPoint", "_maxPathLength"];

private _pathGrid = createHashMap;
private _fromKey = _fromPoint call fn_commonIjToKey;
private _fromWeight = _weightGrid getOrDefault [_fromKey, -1];
if (_fromWeight < 0) exitWith {[]};

_pathGrid set [_fromKey, [[_fromPoint], _fromWeight]];
private _pointToVisitArray = [[_fromPoint, _fromWeight]];
while {count _pointToVisitArray > 0} do {
    private _pointToVisit = _pointToVisitArray # 0;
    _pointToVisitArray deleteAt 0;

    private _point = _pointToVisit # 0;
    private _pointCumWeight = _pointToVisit # 1;
    private _pointKey = _point call fn_commonIjToKey;
    private _pointValue = _pathGrid get _pointKey;
    private _pointPath = _pointValue # 0;
    private _neighbourPointArray = _point call fn_pathGetNeighbourPointArray;
    for [{private _n = 0}, {_n < count _neighbourPointArray}, {_n = _n + 1}] do {
        private _neighbourPoint = _neighbourPointArray # _n;

        private _neighbourPointKey = _neighbourPoint call fn_commonIjToKey;
        if !(_neighbourPointKey in _pathGrid) then {
            private _neighbourPointWeight = _weightGrid getOrDefault [_neighbourPointKey, -1];
            if (_neighbourPointWeight > 0) then {
                if ((count _pointPath) <= _maxPathLength) then {
                    private _neighbourPointCumWeight = _neighbourPointWeight + _pointCumWeight;
                    private _neighbourPointPath = _pointPath + [_neighbourPoint];
                    _pathGrid set [_neighbourPointKey, [_neighbourPointPath, _neighbourPointCumWeight]];
                    [_pointToVisitArray, [_neighbourPoint, _neighbourPointCumWeight], {_this # 1}] call fn_commonSortedInsert;
                };
            };
        };
    };
};
_pathGrid
