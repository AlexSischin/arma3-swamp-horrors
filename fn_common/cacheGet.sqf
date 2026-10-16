if (isNil "CACHE_STORAGE") exitWith {};
private _value = CACHE_STORAGE get _this;
format ["%1: returned from cache", _this] call fn_commonDebug;
_value
