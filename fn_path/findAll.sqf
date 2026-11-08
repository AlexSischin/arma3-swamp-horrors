params ["_pathMap", "_fromPoint", "_maxPathLength"];

private _bestPathGrid = createHashMap;
private _fromKey = _fromPoint call fn_commonIjToKey;
private _pathGrid = _pathMap # 0;
private _fromWeight = _pathGrid getOrDefault [_fromKey, 0];
if (_fromWeight <= 0) exitWith {createHashMap};

_bestPathGrid set [_fromKey, [[_fromPoint], _fromWeight]];
private _pointToVisitArray = [[_fromPoint, _fromWeight]];
while {count _pointToVisitArray > 0} do {
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
                if ((count _pointPath) <= _maxPathLength) then {
                    private _neighbourPointCumWeight = _neighbourPointWeight + _pointCumWeight;
                    private _neighbourPointPath = _pointPath + [_neighbourPoint];
                    _bestPathGrid set [_neighbourPointKey, [_neighbourPointPath, _neighbourPointCumWeight]];
                    [_pointToVisitArray, [_neighbourPoint, _neighbourPointCumWeight], {_this # 1}] call fn_commonSortedInsert;
                };
            };
        };
    };
};
_bestPathGrid
