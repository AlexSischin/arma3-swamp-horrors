params ["_pos", "_k"];

private _searchDistance = 200;
private _minDistance = 5;

private _score = 0;
private _nearRoads = _pos nearRoads _searchDistance;
for [{private _r = 0}, {_r < count _nearRoads}, {_r = _r + 1}] do {
    private _road = _nearRoads select _r;

    private _distance = _road distance2D _pos;
    _score = _score + _minDistance / (_minDistance max _distance);
};
_score = _score ^ 2;
_score = [_score, _k] call fn_chunkPositiveSigmoid;
_score
