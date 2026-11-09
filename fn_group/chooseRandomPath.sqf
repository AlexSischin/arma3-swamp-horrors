params ["_chunkMap", "_groupIndexPos", "_migrationMaxDistance"];

private _chunkGrid = _chunkMap select 1;
private _chunkSize = _chunkMap select 2;

private _pathMap = [_chunkMap] call fn_groupChunkMapToPathMap;
private _bestPathGrid = [_pathMap, _groupIndexPos, _migrationMaxDistance] call fn_pathFindAll;
private _weightedPathGrid = [_bestPathGrid, _chunkGrid] call fn_groupWeightPathGrid;
private _indexPath = ([_weightedPathGrid, {_this # 1}] call fn_commonSelectRandomWeightedFromHashMap) # 0;
if (isNil "_indexPath") exitWith {[]};
_indexPath
