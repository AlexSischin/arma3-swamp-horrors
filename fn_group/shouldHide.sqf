params ["_pos", "_maxDistance"];

private _subjectArray = [] call fn_groupGetRenderSubjects;

private _shouldHide = true;
for [{private _s = 0}, {(_s < count _subjectArray) && _shouldHide}, {_s = _s + 1}] do {
    private _subject = _subjectArray select _s;

    if (_subject distance2D _pos <= _maxDistance) then {
        _shouldHide = false;
    };
};
_shouldHide
