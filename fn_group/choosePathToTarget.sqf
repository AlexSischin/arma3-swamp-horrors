params ["_chunkMap", "_fromPoint", "_toPoint"];

private _pathMap = [_chunkMap] call fn_groupChunkMapToPathMap;
private _pathFinding = [_pathMap, _fromPoint, _toPoint] call fn_pathFind;
private _toKey = _pathFinding # 0;
private _bestPathGrid = _pathFinding # 1;
private _path = _bestPathGrid getOrDefault [_toKey, []];
if !(_path isEqualTo []) exitWith {_path};

private _bestPathWeightGrid = _pathFinding # 2;
private _closestPoint = [_bestPathWeightGrid, _toPoint] call fn_pathFindNearestPoint;
private _closestPointKey = _closestPoint call fn_commonIjToKey;
private _closestPointPath = _bestPathGrid getOrDefault [_closestPointKey, []];
_closestPointPath
