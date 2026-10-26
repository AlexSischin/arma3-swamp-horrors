params ["_params"];

private _chunkGrid = _params get "_chunkGrid";
private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = [_chunkGrid, 2, {_this select 1}] call fn_commonSelectRandomWeighted select 0;

private _posState = createHashMap;
_posState set ["_groupIndexPos", _groupIndexPos];
_posState
