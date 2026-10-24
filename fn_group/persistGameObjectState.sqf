params ["_posState", "_gameObjectState", "_migrationState"];

private _groupWorldPos = _posState get "_groupWorldPos";
private _unit = _gameObjectState get "_unit";
private _nHops = _migrationState get "_nHops";

if (_nHops > 0) then {
    _unit setPos _groupWorldPos;
};
