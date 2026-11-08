params ["_chunkMap", "_groupIndexPos"];

private _pathMap = [_chunkMap] call fn_groupChunkMapToPathMap;
private _indexPath = [_pathMap, _groupIndexPos] call fn_pathFindBackoff;
_indexPath
