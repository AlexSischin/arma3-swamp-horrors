params ["_params"];

private _chunkGrid = _params get "_chunkGrid";

private _groupIndexPos = ([_chunkGrid, {_this # 1}] call LCX_fnc_selectRandomWeightedFromHashMap) # 0;

private _posState = createHashMap;
_posState set ["_groupIndexPos", _groupIndexPos];
_posState
