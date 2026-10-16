params ["_chunkMap", "_groupIndexPos", "_target"];

private _chunkInverseWeightGrid = [_chunkMap] call fn_groupChunkGridToInverseWeightGrid;
_indexPath = [_chunkInverseWeightGrid, _groupIndexPos, _target] call fn_pathFind;
_indexPath
