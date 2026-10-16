params ["_array", "_dimensions", "_weightFn"];

private _flatArray = [_array, _dimensions - 1] call fn_commonFlattenArray;
private _preparedArray = [];
for [{private _i = 0}, {_i < count _flatArray}, {_i = _i + 1}] do {
    private _element = _flatArray select _i;

    private _weight = _element call _weightFn;
    _preparedArray pushBack _element;
    _preparedArray pushBack _weight;
};
private _randomElement = selectRandomWeighted _preparedArray;
if (isNil "_randomElement") exitWith {};
_randomElement
