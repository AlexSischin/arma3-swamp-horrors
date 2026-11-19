params ["_pos", "_k"];

private _score = 0 max (getTerrainHeightASL _pos);
_score = [_score, _k] call LCX_fnc_positiveSigmoid;

_score
