params ["_pos", "_minDistance", "_maxDistance"];

private _subjectArray = [] call fn_groupGetRenderSubjects;

private _shouldShow = false;
for [{private _s = 0}, {(_s < count _subjectArray) && !_shouldShow}, {_s = _s + 1}] do {
    private _subject = _subjectArray select _s;

    if (_subject distance2D _pos <= _maxDistance) then {
        if (_subject distance2D _pos >= _minDistance) then {
            _shouldShow = true;
        };
    };
};
_shouldShow
