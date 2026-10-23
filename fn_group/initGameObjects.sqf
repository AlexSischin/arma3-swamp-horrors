params ["_params", "_state"];

private _side = _params get "_side";
private _class = _params get "_class";

private _groupWorldPos = _state get "_groupWorldPos";

private _dir = random 360;
private _group = createGroup [_side, true];
_group setFormDir _dir;
private _unit = [_group, _groupWorldPos, _class] call fn_groupCreateUnit;
_unit setDir _dir;
_state set ["_group", _group];
_state set ["_unit", _unit];
