params ["_chunkMap", "_groupIndexPos", "_migrationMaxDistance"];

private _chunkGrid = _chunkMap select 1;
private _chunkSize = _chunkMap select 2;

private _migrationMaxIndexDistance = floor (_migrationMaxDistance / _chunkSize);
private _chunkInverseWeightGrid = [_chunkMap] call fn_groupChunkGridToInverseWeightGrid;
private _pathGrid = [_chunkInverseWeightGrid, _groupIndexPos, _migrationMaxIndexDistance] call fn_pathFindAll;
private _weightedPathGrid = [_pathGrid, _chunkGrid] call fn_groupWeightPathGrid;
private _indexPath = [_weightedPathGrid, 2, {_this select 1}] call fn_commonSelectRandomWeighted select 0;
if (isNil "_indexPath") exitWith {[]};
_indexPath
