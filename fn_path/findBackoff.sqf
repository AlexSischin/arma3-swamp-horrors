params ["_weightGrid", "_fromPoint"];
scopeName "main";

private _iSize = count _weightGrid;
private _jSize = count (_weightGrid select 0);
private _searchDistance = _iSize max _jSize;
private _i0 = _fromPoint select 0;
private _j0 = _fromPoint select 1;
private _backoffPoint = nil;
for [{private _d = 0}, {_d <= _searchDistance}, {_d = _d + 1}] do {

    for [{private _dI = 0}, {_dI <= _d}, {_dI = _dI + 1}] do {

        private _dJ = _d - _dI;
        for [{private _iSign = -1}, {_iSign <= 1}, {_iSign = _iSign + 2}] do {
            for [{private _jSign = -1}, {_jSign <= 1}, {_jSign = _jSign + 2}] do {
                private _i = _i0 + (_iSign * _dI);
                private _j = _j0 + (_jSign * _dJ);
                if ((_i > 0) && (_i < _iSize) && (_j > 0) && (_j < _jSize)) then {

                    private _weight = (_weightGrid select _i) select _j;
                    if (_weight > 0) then {
                        _backoffPoint = [_i, _j];
                        breakTo "main";
                    };
                };
            };
        };
    };
};
if (isNil "_backoffPoint") exitWith {[]};

private _path = [_fromPoint];
private _dimensionNumber = (count _fromPoint) min (count _backoffPoint);
for [{private _d = 0}, {_d < _dimensionNumber}, {_d = _d + 1}] do {
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
