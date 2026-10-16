params ["_key", "_value"];

if (isNil "CACHE_STORAGE") then {
    CACHE_STORAGE = createHashMap;
};

CACHE_STORAGE set [_key, _value];
format ["%1: set to cache", _key] call fn_commonDebug;
