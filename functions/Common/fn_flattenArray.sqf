params ["_array", "_dimensions"];

if (_dimensions <= 0) exitWith {_array};

private _resultArray = _array;

for [{private _d = 0}, {_d < _dimensions}, {_d = _d + 1}] do {
    private _flattenedArray = [];

    for [{private _i = 0}, {_i < count _resultArray}, {_i = _i + 1}] do {
        _flattenedArray append (_resultArray select _i);
    };

    _resultArray = _flattenedArray;
};

_resultArray
