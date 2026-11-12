params ["_pathMap", "_fromPoint"];
scopeName "main";

private _backoffPoint = [_pathMap, _fromPoint] call fn_pathFindNearestPoint;
if (_backoffPoint isEqualTo []) exitWith {[]};

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
