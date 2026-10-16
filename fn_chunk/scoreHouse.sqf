params ["_pos", "_k"];

private _houseSearchDistance = 500;

private _score = 0;
private _nearHouses = nearestObjects [_pos, ["house"], 500, true];
for [{private _h = 0}, {_h < count _nearHouses}, {_h = _h + 1}] do {
    private _house = _nearHouses select _h;

    private _houseDistance = _house distance2D _pos;
    _score = _score + 1 / _houseDistance;
};
_score = [_score, _k] call fn_chunkPositiveSigmoid;

_score
