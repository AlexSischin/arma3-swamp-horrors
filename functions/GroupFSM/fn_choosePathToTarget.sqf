params ["_chunkMap", "_fromPoint", "_toPoint"];

private _pathMap = [_chunkMap] call LCX_fnc_chunkMapToPathMap;
private _pathFinding = [_pathMap, _fromPoint, _toPoint] call LCX_fnc_findPath;
private _toKey = _pathFinding # 0;
private _bestPathGrid = _pathFinding # 1;
private _path = _bestPathGrid getOrDefault [_toKey, []];
if !(_path isEqualTo []) exitWith {_path};

private _bestPathWeightGrid = _pathFinding # 2;
private _closestPoint = [_bestPathWeightGrid, _toPoint] call LCX_fnc_getNearestPoint;
private _closestPointPath = [];
if !(_closestPoint isEqualTo []) then {
    private _closestPointKey = _closestPoint call LCX_fnc_ijToKey;
    _closestPointPath = _bestPathGrid getOrDefault [_closestPointKey, []];
};
_closestPointPath
