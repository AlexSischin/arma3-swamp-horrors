params ["_params", "_posState", "_migrationState"];

private _destination = [];
private _fn = _params get "_fnDestinationVirtual";
if !(isNil "_fn") then {
    _destination = [_posState] call _fn;
    if (isNil "_destination") then {
        _destination = [];
    };
};
_migrationState set ["_destination", _destination];
