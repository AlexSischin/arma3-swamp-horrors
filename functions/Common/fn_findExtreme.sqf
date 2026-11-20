params ["_array", "_fnKey", ["_mode", 0]];

if (_array isEqualTo []) exitWith {};

private _result = _array select 0;
private _bestKey = _result call _fnKey;

{
    private _key = _x call _fnKey;

    if (
        (_mode == 0 && {_key < _bestKey}) ||
        (_mode == 1 && {_key > _bestKey})
    ) then {
        _result = _x;
        _bestKey = _key;
    };
} forEach (_array select [1]);

_result
