params ["_pos", "_markerArray"];

private _score = 0;
for [{private _m = 0}, {_m < count _markerArray}, {_m = _m + 1}] do {
    private _marker = _markerArray select _m;

    private _zoneScore = 0;
    if (_pos inArea _marker) then {
        _zoneScore = 1;
    };
    _score = _score + _zoneScore;
};

_score
