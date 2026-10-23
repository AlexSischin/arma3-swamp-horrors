params ["_params", "_state"];

private _hideDistanceMin = _params get "_hideDistanceMin";
private _groupWorldPos = _state get "_groupWorldPos";

private _subjectArray = [] call fn_groupGetRenderSubjects;

private _shouldHide = true;
for [{private _s = 0}, {(_s < count _subjectArray) && _shouldHide}, {_s = _s + 1}] do {
    private _subject = _subjectArray select _s;

    if (_subject distance2D _groupWorldPos <= _hideDistanceMin) then {
        _shouldHide = false;
    };
};
_shouldHide
