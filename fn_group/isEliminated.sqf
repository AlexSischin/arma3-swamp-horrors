params ["_gameObjectState"];

private _group = _gameObjectState get "_group";
private _aliveUnits = [_group] call fn_objectGetGroupUnits;
private _isEliminated = count _aliveUnits == 0;
_isEliminated
