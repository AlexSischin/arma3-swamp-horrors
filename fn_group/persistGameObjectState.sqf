params ["_state"];

private _groupWorldPos = _state get "_groupWorldPos";
private _unit = _state get "_unit";
private _nHops = _state get "_nHops";

if (_nHops > 0) then {
    _unit setPos _groupWorldPos;
}
