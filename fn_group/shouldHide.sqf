params ["_params", "_posState"];

private _chunkSize = _params get "_chunkSize";
private _hideDistanceMin = _params get "_hideDistanceMin";

private _groupIndexPos = _posState get "_groupIndexPos";

private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _subjectArray = [] call fn_groupGetRenderSubjects;
private _shouldHide = true;
for [{private _s = 0}, {(_s < count _subjectArray) && _shouldHide}, {_s = _s + 1}] do {
    private _subject = _subjectArray select _s;

    if (_subject distance2D _groupWorldPos <= _hideDistanceMin) then {
        _shouldHide = false;
    };
};
_shouldHide
