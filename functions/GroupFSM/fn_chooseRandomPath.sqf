params ["_chunkMap", "_groupIndexPos", "_migrationMaxDistance"];

private _chunkGrid = _chunkMap select 1;
private _chunkSize = _chunkMap select 2;

private _pathMap = [_chunkMap] call LCX_fnc_chunkMapToPathMap;
private _bestPathGrid = [_pathMap, _groupIndexPos, _migrationMaxDistance] call LCX_fnc_findPathGrid;
private _weightedPathGrid = [_bestPathGrid, _chunkGrid] call LCX_fnc_applyChunkMapToPathMap;
private _indexPath = ([_weightedPathGrid, {_this # 1}] call LCX_fnc_selectRandomWeightedFromHashMap) # 0;
if (isNil "_indexPath") exitWith {[]};
_indexPath
