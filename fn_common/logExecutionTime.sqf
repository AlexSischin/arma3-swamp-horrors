params ["_code", "_key"];

private _startTime = diag_tickTime;
private _result = call _code;

private _executionTime = (diag_tickTime - _startTime) * 1000;

diag_log format [
    "[EXECUTION_TIME][%1]: %2 ms",
    _key,
    _executionTime toFixed 3
];

if !(isNil "_result") exitWith {_result};
