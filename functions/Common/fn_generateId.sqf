private _chars = toArray "0123456789ABCDEF";
private _result = "";

for "_i" from 1 to 16 do {
    _result = _result + toString [selectRandom _chars];
};

_result
