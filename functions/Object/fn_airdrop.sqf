params [
    ["_startPos", nil],
    ["_targetPos", nil],
    ["_finishPos", nil],
    ["_vehicleClass", nil],
    ["_cargoArray", []],
    ["_targetRadius", 100],
    ["_targetFlybyRadius", 500],
    ["_finishRadius", 500],
    ["_delay", 1]
];

private _flightHeight = _startPos # 2;
private _startVector = (_targetPos vectorDiff _startPos) select [0, 2];
private _startDir = (_startVector # 0) atan2 (_startVector # 1);

private _aircraft = createVehicle [_vehicleClass, _startPos, [], 0, "FLY"];
_aircraft setDir _startDir;
{_aircraft setVehicleCargo _x} forEach _cargoArray;

createVehicleCrew _aircraft;
_aircraft flyInHeight _flightHeight;
_aircraft setSpeedMode "FULL";

private _group = group (driver _aircraft);
private _wp = _group addWaypoint [_targetPos, 0];
_wp setWaypointType "MOVE";

while {true} do {
    sleep _delay;

    if (!alive _aircraft) exitWith {};

    private _pos = getPosATL _aircraft;
    private _targetDistance = _pos distance2D _targetPos;

    if (_targetDistance > _targetFlybyRadius) then {continue};

    if (_targetDistance <= _targetRadius)  exitWith {};

    private _velocityVector = (velocity _aircraft) select [0, 2];
    private _targetVector = (_targetPos vectorDiff _pos) select [0, 2];
    private _dotProduct = _velocityVector vectorDotProduct _targetVector;
    if (_dotProduct <= 0) exitWith {};
};
if (!alive _aircraft) exitWith {};

_aircraft setVehicleCargo objNull;

private _exitWP = _group addWaypoint [_finishPos, 0];
_exitWP setWaypointType "MOVE";

while {true} do {
    sleep _delay;

    if (!alive _aircraft) exitWith {};

    private _pos = getPosATL _aircraft;
    private _targetDistance = _pos distance2D _finishPos;
    if (_targetDistance <= _finishRadius)  exitWith {};
};
if (!alive _aircraft) exitWith {};

{deleteVehicle _x} forEach crew _aircraft;
deleteVehicle _aircraft;
