params ["_params", "_posState", "_gameObjectState", "_migrationState"];

private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = _posState get "_groupIndexPos";
private _unit = _gameObjectState get "_unit";
private _nHops = _migrationState get "_nHops";

if (_nHops > 0) then {
    private _groupWorldPos = [_groupIndexPos, _chunkSize] call fn_chunkSelectRandomWorldPos;
    _unit setPos _groupWorldPos;
};
