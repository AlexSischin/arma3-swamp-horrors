params ["_gameObjectState"];

private _group = _gameObjectState get "_group";
private _aliveUnits = [_group] call LCX_fnc_getGroupUnits;
private _isEliminated = count _aliveUnits == 0;
_isEliminated
