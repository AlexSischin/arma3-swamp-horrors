params ["_params", "_gameObjectState", "_migrationState"];

private _destination = [];
private _fn = _params get "_fnDestinationPhysical";
if !(isNil "_fn") then {
    _destination = [_gameObjectState] call _fn;
    if (isNil "_destination") then {
        _destination = [];
    };
};
_migrationState set ["_destination", _destination];
