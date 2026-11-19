params ["_pos", "_areaSize", "_stepSize"];

private _pointArray = [];
private _startPoint = _pos vectorDiff [_areaSize / 2, _areaSize / 2];
for [{private _x_ = 0}, {_x_ <= _areaSize}, {_x_ = _x_ + _stepSize}] do {
    for [{private _y = 0}, {_y <= _areaSize}, {_y = _y + _stepSize}] do {
        _pointArray pushBack ([_x_, _y] vectorAdd _startPoint);
    };
};
_pointArray
