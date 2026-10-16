params ["_pos", "_k"];

private _roadSearchDistance = 200;

private _score = 0;
private _nearRoads = _pos nearRoads _roadSearchDistance;
for [{private _r = 0}, {_r < count _nearRoads}, {_r = _r + 1}] do {
    private _road = _nearRoads select _r;

    private _roadDistance = _road distance2D _pos;
    _score = _score + 1 / _roadDistance;
};
_score = [_score, _k] call fn_chunkPositiveSigmoid;

_score
