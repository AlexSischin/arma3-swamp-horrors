params ["_params", "_posState"];

private _chunkSize = _params get "_chunkSize";
private _showDistanceMin = _params get "_showDistanceMin";
private _showDistanceMax = _params get "_showDistanceMax";

private _groupIndexPos = _posState get "_groupIndexPos";

private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _subjectArray = [] call fn_groupGetRenderSubjects;
private _shouldShow = false;
for [{private _s = 0}, {(_s < count _subjectArray) && !_shouldShow}, {_s = _s + 1}] do {
    private _subject = _subjectArray select _s;

    if (_subject distance2D _groupWorldPos <= _showDistanceMax) then {
        if (_subject distance2D _groupWorldPos >= _showDistanceMin) then {
            _shouldShow = true;
        };
    };
};
_shouldShow
