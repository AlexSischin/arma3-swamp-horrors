params ["_weightGrid", "_fromPoint"];
scopeName "main";

if (count _weightGrid == 0) exitWith {[]};

private _i0 = _fromPoint # 0;
private _j0 = _fromPoint # 1;

private _randomPointKey = {breakWith _x} forEach _weightGrid;
private _randomPoint = _randomPointKey call fn_commonKeyToIj;
private _randomPointDistanceX = abs (_i0 - (_randomPoint # 0));
private _randomPointDistanceY = abs (_j0 - (_randomPoint # 1));
private _searchDistance = _randomPointDistanceX + _randomPointDistanceY;

private _backoffPoint = nil;
for [{private _d = 0}, {_d <= _searchDistance}, {_d = _d + 1}] do {

    for [{private _dI = 0}, {_dI <= _d}, {_dI = _dI + 1}] do {

        private _dJ = _d - _dI;
        for [{private _iSign = -1}, {_iSign <= 1}, {_iSign = _iSign + 2}] do {
            for [{private _jSign = -1}, {_jSign <= 1}, {_jSign = _jSign + 2}] do {
                private _i = _i0 + (_iSign * _dI);
                private _j = _j0 + (_jSign * _dJ);
                private _key = [_i, _j] call fn_commonIjToKey;
                private _weight = _weightGrid getOrDefault [_key, -1];
                if (_weight > 0) then {
                    _backoffPoint = [_i, _j];
                    breakTo "main";
                };
            };
        };
    };
};
if (isNil "_backoffPoint") exitWith {[]};

private _path = [_fromPoint];
for [{private _d = 0}, {_d < 2}, {_d = _d + 1}] do {
    private _startDimension = _fromPoint select _d;
    private _targetDimension = _backoffPoint select _d;

    private _diff = _targetDimension - _startDimension;
    if (_diff == 0) then {continue};

    private _absDiff = abs _diff;
    private _step = _diff / _absDiff;
    for [{private _i = 1}, {_i <= _absDiff}, {_i = _i + 1}] do {
        private _point = ((_path + []) select -1) + [];
        _point set [_d, (_point select _d) + _step];
        _path pushBack _point;
    };
};
_path
