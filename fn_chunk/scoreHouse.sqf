params ["_pos", "_k"];

private _searchDistance = 500;
private _minDistance = 5;

private _score = 0;
private _nearHouses = nearestObjects [_pos, ["house"], _searchDistance, true];
for [{private _h = 0}, {_h < count _nearHouses}, {_h = _h + 1}] do {
    private _house = _nearHouses select _h;

    private _distance = _house distance2D _pos;
    _score = _score + _minDistance / (_minDistance max _distance);
};
_score = _score ^ 2;
_score = [_score, _k] call fn_chunkPositiveSigmoid;
_score
