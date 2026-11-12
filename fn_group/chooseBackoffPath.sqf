params ["_chunkMap", "_groupIndexPos"];

private _pathMap = [_chunkMap] call fn_groupChunkMapToPathMap;
private _pathGrid = _pathMap # 0;
private _indexPath = [_pathGrid, _groupIndexPos] call fn_pathFindBackoff;
_indexPath
