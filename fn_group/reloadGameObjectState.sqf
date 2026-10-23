params ["_params", "_state"];

private _chunkSize = _params get "_chunkSize";

private _unit = _state get "_unit";

private _groupWorldPos = getPos _unit;
private _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
_state set ["_groupWorldPos", _groupWorldPos];
_state set ["_groupIndexPos", _groupIndexPos];
