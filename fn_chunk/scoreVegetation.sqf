params ["_pos", "_k"];

private _searchDistance = 100;
private _minDistance = 10;

private _score = 0;
private _nearBushes = nearestTerrainObjects [_pos, ["BUSH", "TREE", "SMALL TREE"], _searchDistance, false, true];
for [{private _b = 0}, {_b < count _nearBushes}, {_b = _b + 1}] do {
    private _bush = _nearBushes select _b;

    private _distance = _bush distance2D _pos;
    _score = _score + _minDistance / (_minDistance max _distance);
};
_score = _score ^ 2;
_score = [_score, _k] call fn_chunkPositiveSigmoid;
_score
