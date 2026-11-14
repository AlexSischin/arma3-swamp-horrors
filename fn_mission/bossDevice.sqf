private _chunkSize = 25;
private _color = "ColorOPFOR";
private _markersEnabled = true;
private _chunkMap = [
    _chunkSize,
    [
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, ["device_vehicle_zone"]] call fn_chunkScoreMarker)
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

private _bossDevicePlacementRadius = 50;
private _bossDeviceObjectDistance = 10;
private _chunkGrid = _chunkMap # 1;
private _chunkSize = _chunkMap # 2;
private _bossDeviceSpawnIndexPos = ([_chunkGrid, {_this # 1}] call fn_commonSelectRandomWeightedFromHashMap) # 0;
private _bossDeviceSpawnWorldPosCenter = [_bossDeviceSpawnIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _bossDeviceSpawnWorldPos = [_bossDeviceSpawnWorldPosCenter, 0, _bossDevicePlacementRadius, _bossDeviceObjectDistance, 1, 0, 0, [], [_bossDeviceSpawnWorldPosCenter, _bossDeviceSpawnWorldPosCenter]] call BIS_fnc_findSafePos;
bossDevice setPos _bossDeviceSpawnWorldPos;
bossDevice setDir random 360;

if (_markersEnabled) then {
    [_bossDeviceSpawnWorldPos, _color, "KIA"] call fn_commonVisualizePoint;
};
