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

private _deviceVehiclePlacementRadius = 50;
private _deviceVehicleObjectDistance = 10;
private _chunkGrid = _chunkMap # 1;
private _chunkSize = _chunkMap # 2;
private _deviceVehicleSpawnIndexPos = ([_chunkGrid, {_this # 1}] call fn_commonSelectRandomWeightedFromHashMap) # 0;
private _deviceVehicleSpawnWorldPosCenter = [_deviceVehicleSpawnIndexPos, _chunkSize] call fn_chunkGetPosForIndex;
private _deviceVehicleSpawnWorldPos = [_deviceVehicleSpawnWorldPosCenter, 0, _deviceVehiclePlacementRadius, _deviceVehicleObjectDistance, 1, 0, 0, [], [_deviceVehicleSpawnWorldPosCenter, _deviceVehicleSpawnWorldPosCenter]] call BIS_fnc_findSafePos;
deviceVehicle setPos _deviceVehicleSpawnWorldPos;
deviceVehicle setDir random 360;

if (_markersEnabled) then {
    [_deviceVehicleSpawnWorldPos, _color, "KIA"] call fn_commonVisualizePoint;
};
