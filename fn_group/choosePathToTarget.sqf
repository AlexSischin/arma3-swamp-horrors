params ["_chunkMap", "_groupIndexPos", "_target"];

private _pathMap = [_chunkMap] call fn_groupChunkMapToPathMap;
_indexPath = ([_pathMap, _groupIndexPos, _target] call fn_pathFind) # 0;
_indexPath
