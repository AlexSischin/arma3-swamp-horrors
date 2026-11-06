params ["_chunkMap", "_groupIndexPos", "_migrationMaxDistance"];

private _chunkGrid = _chunkMap select 1;
private _chunkSize = _chunkMap select 2;

private _migrationMaxIndexDistance = floor (_migrationMaxDistance / _chunkSize);
private _chunkInverseWeightGrid = [_chunkMap] call fn_groupChunkGridToInverseWeightGrid;
private _pathGrid = [{[_chunkInverseWeightGrid, _groupIndexPos, _migrationMaxIndexDistance] call fn_pathFindAll}, "fn_pathFindAll"] call fn_commonLogExecutionTime;
private _weightedPathGrid = [{[_pathGrid, _chunkGrid] call fn_groupWeightPathGrid}, "fn_groupWeightPathGrid"] call fn_commonLogExecutionTime;
private _indexPath = [{([_weightedPathGrid, {_this # 1}] call fn_commonSelectRandomWeightedFromHashMap) # 0}, "fn_commonSelectRandomWeightedFromHashMap"] call fn_commonLogExecutionTime;
if (isNil "_indexPath") exitWith {[]};
_indexPath
