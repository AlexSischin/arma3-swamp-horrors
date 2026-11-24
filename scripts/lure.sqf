private _chunkSize = 25;
private _searchAreaRadius = 500;
private _searchAreaBrush = "Border";
private _searchAreaColor = "Color1_FD_F";
private _searchAreaIcon = "loc_search";
private _searchAreaText = "Heat signature";
private _markersEnabled = false
private _chunkMap = [
    _chunkSize,
    [
        {-1},
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, ["lure_zone"]] call LCX_fnc_scoreMarker)
        },
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, _chunkSize, 0.3] call LCX_fnc_scoreWaterThresholdDepth)
        },
        {
            params ["_pos", "_chunkSize"];
            -1 * ([_pos, islandArray] call LCX_fnc_scoreMarker)
        },
        {
            params ["_pos", "_chunkSize"];
            -10 * ([_pos, _chunkSize, 1] call LCX_fnc_scoreWaterThresholdDepth)
        },
        {
            params ["_pos", "_chunkSize"];
            -16 * ([_pos, blackZoneArray] call LCX_fnc_scoreMarker)
        }
    ]
] call LCX_fnc_buildChunkMap;
if (_markersEnabled) then {
    [_chunkMap, _searchAreaColor] call LCX_fnc_visualizeChunkMap;
};

private _placementRadius = 25;
private _objectDistance = 5;
private _chunkGrid = _chunkMap # 1;
private _chunkSize = _chunkMap # 2;

private _spawnIndexPos = ([_chunkGrid, {_this # 1}] call LCX_fnc_selectRandomWeightedFromHashMap) # 0;
private _spawnIndexPosCenter = [_spawnIndexPos, _chunkSize] call LCX_fnc_getPosForIndex;
private _spawnWorldPos = [_spawnIndexPosCenter, 0, _placementRadius, _objectDistance, 2, 0, 0, [], [_spawnIndexPosCenter, _spawnIndexPosCenter]] call BIS_fnc_findSafePos;
_spawnWorldPos set [2, getTerrainHeightASL _spawnWorldPos];
lure setPosASL _spawnWorldPos;
lure setDir random 360;

[lure] call LCX_fnc_makeLoadableExplicitly;

if (_markersEnabled) then {
    [lure, _searchAreaColor, "KIA"] call LCX_fnc_visualizeObject;
};

[_spawnWorldPos, _searchAreaRadius, _searchAreaBrush, _searchAreaColor, _searchAreaIcon, _searchAreaText] call LCX_fnc_createSearchAreaMarker;
