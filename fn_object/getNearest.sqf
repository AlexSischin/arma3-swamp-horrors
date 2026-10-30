params ["_pos", "_objectArray"];

if (count _objectArray == 0) exitWith {};

private _nearestObject = _objectArray select 0;
private _nearestObjectDistance = _nearestObject distance2D _pos;
for [{private _o = 1}, {_o < count _objectArray}, {_o = _o + 1}] do {
    private _object = _objectArray select _o;

    private _objectDistance = _object distance2D _pos;
    if (_objectDistance < _nearestObjectDistance) then {
        _nearestObject = _object;
        _nearestObjectDistance = _objectDistance;
    };
};
[_nearestObject, _nearestObjectDistance]
