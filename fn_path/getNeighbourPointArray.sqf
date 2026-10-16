params ["_point", "_dimensions"];

private _i = _point select 0;
private _j = _point select 1;
private _sizeI = _dimensions select 0;
private _sizeJ = _dimensions select 1;
private _neighbourPointArray = [];
if (_i - 1 >= 0) then {
    _neighbourPointArray pushBack [_i - 1, _j];
};
if (_j - 1 >= 0) then {
    _neighbourPointArray pushBack [_i, _j - 1];
};
if (_i + 1 < _sizeI) then {
    _neighbourPointArray pushBack [_i + 1, _j];
};
if (_j + 1 < _sizeJ) then {
    _neighbourPointArray pushBack [_i, _j + 1];
};
_neighbourPointArray
