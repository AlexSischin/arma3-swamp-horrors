params ["_params", "_posState"];

private _side = _params get "_side";
private _class = _params get "_class";

private _groupWorldPos = _posState get "_groupWorldPos";

private _dir = random 360;
private _group = createGroup [_side, true];
_group setFormDir _dir;
private _unit = [_group, _groupWorldPos, _class] call fn_groupCreateUnit;
_unit setDir _dir;

private _gameObjectState = createHashMap;
_gameObjectState set ["_group", _group];
_gameObjectState set ["_unit", _unit];
_gameObjectState
