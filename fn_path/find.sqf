params ["_pathMap", "_fromPoint", "_toPoint"];

private _bestPathGrid = createHashMap;
private _fromKey = _fromPoint call fn_commonIjToKey;
private _pathGrid = _pathMap # 0;
private _fromWeight = _pathGrid getOrDefault [_fromKey, 0];
if (_fromWeight <= 0) exitWith {[[], -1]};

private _minWeight = _pathMap # 1;
private _toKey = _toPoint call fn_commonIjToKey;
_bestPathGrid set [_fromKey, [[_fromPoint], _fromWeight]];
private _pointToVisitArray = [[_fromPoint, 0]];
while {(count _pointToVisitArray > 0) && !(_toKey in _bestPathGrid)} do {
    private _pointToVisit = _pointToVisitArray # 0;
    _pointToVisitArray deleteAt 0;

    private _point = _pointToVisit # 0;
    private _pointKey = _point call fn_commonIjToKey;
    private _pointValue = _bestPathGrid get _pointKey;
    private _pointPath = _pointValue # 0;
    private _pointCumWeight = _pointValue # 1;
    private _neighbourPointArray = _point call fn_pathGetNeighbourPointArray;
    for [{private _n = 0}, {_n < count _neighbourPointArray}, {_n = _n + 1}] do {
        private _neighbourPoint = _neighbourPointArray # _n;

        private _neighbourPointKey = _neighbourPoint call fn_commonIjToKey;
        if !(_neighbourPointKey in _bestPathGrid) then {
            private _neighbourPointWeight = _pathGrid getOrDefault [_neighbourPointKey, -1];
            if (_neighbourPointWeight > 0) then {
                private _neighbourPointCumWeight = _neighbourPointWeight + _pointCumWeight;
                private _neighbourPointPath = _pointPath + [_neighbourPoint];
                _bestPathGrid set [_neighbourPointKey, [_neighbourPointPath, _neighbourPointCumWeight]];
                private _neighbourPointTargetDistance = [_neighbourPoint, _toPoint] call fn_pathManhattanDistance;
                private _neighbourPointCompoundWeight = _neighbourPointCumWeight + _minWeight * _neighbourPointTargetDistance;
                [_pointToVisitArray, [_neighbourPoint, _neighbourPointCompoundWeight], {_this # 1}] call fn_commonSortedInsert;
            };
        };
    };
};
_pathToTarget = _bestPathGrid getOrDefault [_toKey, [[], -1]];
_pathToTarget
