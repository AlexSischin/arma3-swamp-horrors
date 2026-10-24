params ["_params", "_posState"];

private _showDistanceMin = _params get "_showDistanceMin";
private _showDistanceMax = _params get "_showDistanceMax";

private _groupWorldPos = _posState get "_groupWorldPos";

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
