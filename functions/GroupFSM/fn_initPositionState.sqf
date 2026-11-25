params ["_params"];

private _chunkSize = _params get "_chunkSize";
private _group = _params get "_group";
private _groupWorldPos = getPos leader _group;
private _groupIndexPos = [_groupWorldPos, _chunkSize] call LCX_fnc_getIndexForPos;

private _posState = createHashMap;
_posState set ["_groupIndexPos", _groupIndexPos];
_posState
