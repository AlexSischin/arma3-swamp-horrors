// Searches the most optimal path to the target point.
// _weightGrid - HashMap where keys represent coordinates and values represent weights.
// _fromPoint - starting point for search.
// _toPoint - target point to find path to.
// returns an array of points or an empty array if path not found.
// This function works purely with indices, not metric distances.
params ["_weightGrid", "_fromPoint", "_toPoint"];

private _pathGrid = createHashMap;
private _fromKey = _fromPoint call fn_commonIjToKey;
private _fromWeight = _weightGrid getOrDefault [_fromKey, -1];
if (_fromWeight < 0) exitWith {[[], -1]};

_pathGrid set [_fromKey, [[_fromPoint], _fromWeight]];
private _pointToVisitArray = [[_fromPoint, _fromWeight]];
private _toKey = _toPoint call fn_commonIjToKey;
while {(count _pointToVisitArray > 0) && !(_toKey in _pathGrid)} do {
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
                private _neighbourPointCumWeight = _neighbourPointWeight + _pointCumWeight;
                private _neighbourPointPath = _pointPath + [_neighbourPoint];
                _pathGrid set [_neighbourPointKey, [_neighbourPointPath, _neighbourPointCumWeight]];
                [_pointToVisitArray, [_neighbourPoint, _neighbourPointCumWeight], {_this # 1}] call fn_commonSortedInsert;
            };
        };
    };
};
_pathToTarget = _pathGrid getOrDefault [_toKey, [[], -1]];
_pathToTarget
