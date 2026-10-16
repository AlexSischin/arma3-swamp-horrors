params ["_chunkIndexArray", "_chunkSize"];

_chunkIndexArray apply {[_x, _chunkSize] call fn_chunkGetPosForIndex};
