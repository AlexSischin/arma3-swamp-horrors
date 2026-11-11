params ["_pos", "_chunkSize", "_k"];

private _precision = 2;
private _seaLevel = 0;

private _chunkArea = [_pos, _chunkSize, _chunkSize / _precision] call fn_chunkSquareArea;
private _score = 0;
private _waterPointCount = 0;
{
    private _chunkPoint = _x;

    if (surfaceIsWater _chunkPoint) then {
        private _seabedHeight = getTerrainHeightASL _chunkPoint;
        private _depth = _seaLevel - _seabedHeight;

        _score = _score + _depth;
        _waterPointCount = _waterPointCount + 1;
    };
} forEach _chunkArea;

if (_waterPointCount > 0) then {
    _score = 0 max (_score / _waterPointCount);
    _score = [_score, _k] call fn_chunkPositiveSigmoid;
} else {
    _score = 0;
};
_score
