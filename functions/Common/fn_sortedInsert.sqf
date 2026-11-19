// Array must be sorted in ascending order consistently with the scoreFn.
// Element will be inserted preserving sorting.
params ["_array", "_element", "_scoreFn"];

private _target = _element call _scoreFn;
private _low = 0;
private _high = count _array;

// Find the first position whose score is >= target.
while { _low < _high } do {
    private _mid = floor ((_low + _high) / 2);
    private _score = (_array select _mid) call _scoreFn;

    if (_score < _target) then {
        _low = _mid + 1;
    } else {
        _high = _mid;
    };
};

_array insert [_low, [_element]];

_low
