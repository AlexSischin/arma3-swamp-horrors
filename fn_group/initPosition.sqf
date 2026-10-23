params ["_params"];

private _chunkGrid = _params get "_chunkGrid";
private _chunkSize = _params get "_chunkSize";
private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";

private _groupIndexPos = [_chunkGrid, 2, {_this select 1}] call fn_commonSelectRandomWeighted select 0;
private _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectUnitPos;
_state set ["_groupIndexPos", _groupIndexPos];
_state set ["_groupWorldPos", _groupWorldPos];
