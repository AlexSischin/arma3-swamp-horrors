params ["_params", "_posState", "_migrationState"];

private _destination = [];
private _fn = _params get "_fnDestination";
if !(isNil "_fn") then {
    private _groupIndexPos = _posState get "_groupIndexPos";
    private _chunkSize = _params get "_chunkSize";
    private _chunkCenter = [_groupIndexPos, _chunkSize] call LCX_fnc_getPosForIndex;
    _destination = [_chunkCenter] call _fn;
    if (isNil "_destination") then {
        _destination = [];
    };
};
_migrationState set ["_destination", _destination];
