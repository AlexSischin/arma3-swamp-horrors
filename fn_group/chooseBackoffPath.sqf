params ["_chunkMap", "_groupIndexPos"];

private _chunkInverseWeightGrid = [_chunkMap] call fn_groupChunkGridToInverseWeightGrid;
private _indexPath = [_chunkInverseWeightGrid, _groupIndexPos] call fn_pathFindBackoff;
_indexPath
