params ["_pathGrid", "_point"];

if (count _pathGrid == 0) exitWith {[]};

private _randomPointKey = {breakWith _x} forEach _pathGrid;
private _randomPoint = _randomPointKey call LCX_fnc_keyToIj;
private _searchDistance = [_point, _randomPoint] call LCX_fnc_manhattanDistance;

private _nearestPointArray = [];
for [{private _d = 0}, {(_d <= _searchDistance) && (count _nearestPointArray == 0)}, {_d = _d + 1}] do {

    for [{private _dI = 0}, {_dI <= _d}, {_dI = _dI + 1}] do {

        private _dJ = _d - _dI;
        for [{private _iSign = -1}, {_iSign <= 1}, {_iSign = _iSign + 2}] do {
            for [{private _jSign = -1}, {_jSign <= 1}, {_jSign = _jSign + 2}] do {
                private _i = (_point # 0) + (_iSign * _dI);
                private _j = (_point # 1) + (_jSign * _dJ);
                private _candidatePoint = [_i, _j];
                private _key = _candidatePoint call LCX_fnc_ijToKey;
                private _weight = _pathGrid getOrDefault [_key, -1];
                if (_weight > 0) then {
                    private _preferrability = 1 / _weight;
                    _nearestPointArray pushBack [_candidatePoint, _preferrability];
                };
            };
        };
    };
};

private _nearestPoint = [];
if (count _nearestPointArray > 0) then {
    _nearestPoint = ([_nearestPointArray, 1, {_this # 1}] call LCX_fnc_selectRandomWeighted) # 0;
};
_nearestPoint
