params ["_pos", "_chunkSize"];

private _precision = 2;

private _score = 0;
private _chunkArea = [_pos, _chunkSize, _chunkSize / _precision] call fn_chunkSquareArea;
for [{private _i = 0}, {_i < count _chunkArea}, {_i = _i + 1}] do {
    private _chunkPoint = _chunkArea select _i;
    if (surfaceIsWater _chunkPoint) then {
        _score = _score + 1;
    };
};
_score = _score / (count _chunkArea);

_score
