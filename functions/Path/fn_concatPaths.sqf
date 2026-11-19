if (count _this == 0) exitWith {[]};

private _resultPath = _this # 0;
for [{private _p = 1}, {_p < count _this}, {_p = _p + 1}] do {
    private _path = _this # _p;

    if (count _path == 0) then {
        continue;
    };

    if ((_resultPath # -1) isEqualTo (_path # 0)) then {
        _resultPath = _resultPath + _path;
    };
};
_resultPath
