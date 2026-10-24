params ["_params", "_posState", "_gameObjectState"];

private _chunkSize = _params get "_chunkSize";

private _unit = _gameObjectState get "_unit";

private _groupWorldPos = getPos _unit;
private _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;

_posState set ["_groupWorldPos", _groupWorldPos];
_posState set ["_groupIndexPos", _groupIndexPos];
