params ["_pos", "_k"];

private _searchDistance = 100;

private _score = 0;
private _nearBushes = nearestTerrainObjects [_pos, ["BUSH"], _searchDistance, false, true];
private _phragmitesAustralisBushes = _nearBushes select {
    ((getModelInfo _x) select 0) == "b_phragmites_australis.p3d"
};
for [{private _b = 0}, {_b < count _phragmitesAustralisBushes}, {_b = _b + 1}] do {
    private _bush = _phragmitesAustralisBushes select _b;

    private _distance = _bush distance2D _pos;
    _score = _score + 1 / _distance;
};
_score = [_score, _k] call fn_chunkPositiveSigmoid;
_score
