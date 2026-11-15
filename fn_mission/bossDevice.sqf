private _chunkSize = 25;
private _color = "Color1_FD_F";
private _markersEnabled = false;
private _chunkMap = [
    _chunkSize,
    [
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, ["device_vehicle_zone"]] call fn_chunkScoreMarker)
        },
        {
            params ["_pos", "_chunkSize"];
            -1 * ([_pos, 20] call fn_chunkScoreRoad)
        },
        {
            params ["_pos", "_chunkSize"];
            -1 * ([_pos, ["island_1", "island_2"]] call fn_chunkScoreMarker)
        },
        {
            params ["_pos", "_chunkSize"];
            -10 * ([_pos, _chunkSize, 1] call fn_chunkScoreWaterMaxDepth)
        }
    ]
] call fn_chunkBuildMap;
if (_markersEnabled) then {
    [_chunkMap, _color] call fn_chunkVisualizeMap;
};

private _placementRadius = 50;
private _objectDistance = 10;
private _chunkGrid = _chunkMap # 1;
private _chunkSize = _chunkMap # 2;
private _spawnIndexPos = ([_chunkGrid, {_this # 1}] call fn_commonSelectRandomWeightedFromHashMap) # 0;
private _spawnIndexPosCenter = [_spawnIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _spawnWorldPos = [_spawnIndexPosCenter, 0, _placementRadius, _objectDistance, 1, 0, 0, [], [_spawnIndexPosCenter, _spawnIndexPosCenter]] call BIS_fnc_findSafePos;
_spawnWorldPos set [2, getTerrainHeightASL _spawnWorldPos];
bossDevice setPosASL _spawnWorldPos;
bossDevice setDir random 360;

[bossDevice] call fn_objectMakeLoadableExplicitly;

if (_markersEnabled) then {
    [bossDevice, _color, "loc_container"] call fn_commonVisualizeObject;
};
