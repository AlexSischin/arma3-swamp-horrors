params [
    ["_object", nil],
    ["_initialDelay", 3],
    ["_checkInterval", 1],
    ["_speedThreshold", 0.1],
    ["_timeout", 60]
];

_object allowDamage false;

sleep _initialDelay;

private _startTime = time;

waitUntil {
    sleep _checkInterval;

    if (isNull _object) exitWith { true };

    private _speed = abs speed _object;

    (_speed <= _speedThreshold) || (time - _startTime >= _timeout)
};

if (!isNull _object) then {
    _object allowDamage true;
};
