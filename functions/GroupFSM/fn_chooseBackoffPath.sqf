params ["_chunkMap", "_groupIndexPos"];

private _pathMap = [_chunkMap] call LCX_fnc_chunkMapToPathMap;
private _pathGrid = _pathMap # 0;
private _indexPath = [_pathGrid, _groupIndexPos] call LCX_fnc_findBackoffPath;
_indexPath
