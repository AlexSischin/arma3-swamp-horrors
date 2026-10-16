params ["_pos", "_k"];

private _score = 0 max (getTerrainHeightASL _pos);
_score = [_score, _k] call fn_chunkPositiveSigmoid;

_score
