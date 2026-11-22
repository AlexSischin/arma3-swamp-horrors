private _chunkSize = 25;
private _searchAreaRadius = 200;
private _searchAreaBrush = "Border";
private _searchAreaColor = "Color1_FD_F";
private _markersEnabled = false;
private _chunkMap = [
    _chunkSize,
    [
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, ["lure_zone"]] call LCX_fnc_scoreMarker)
        },
        {
            params ["_pos", "_chunkSize"];
            -1 * ([_pos, 20] call LCX_fnc_scoreRoad)
        },
        {
            params ["_pos", "_chunkSize"];
            -1 * ([_pos, islandArray] call LCX_fnc_scoreMarker)
        },
        {
            params ["_pos", "_chunkSize"];
            -10 * ([_pos, _chunkSize, 1] call LCX_fnc_scoreWaterMaxDepth)
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

for [{private _l = 0}, {_l < count lureArray}, {_l = _l + 1}] do {
    private _lure = lureArray # _l;

    private _spawnIndexPos = ([_chunkGrid, {_this # 1}] call LCX_fnc_selectRandomWeightedFromHashMap) # 0;
    private _spawnIndexPosCenter = [_spawnIndexPos, _chunkSize] call LCX_fnc_getPosForIndex;
    private _spawnWorldPos = [_spawnIndexPosCenter, 0, _placementRadius, _objectDistance, 1, 0, 0, [], [_spawnIndexPosCenter, _spawnIndexPosCenter]] call BIS_fnc_findSafePos;
    _spawnWorldPos set [2, getTerrainHeightASL _spawnWorldPos];
    _lure setPosASL _spawnWorldPos;
    _lure setDir random 360;

    [_lure] call LCX_fnc_makeLoadableExplicitly;

    if (_markersEnabled) then {
        [_lure, _searchAreaColor, "KIA"] call LCX_fnc_visualizeObject;
    };

    [_spawnWorldPos, _searchAreaRadius, _searchAreaBrush, _searchAreaColor] call LCX_fnc_createSearchAreaMarker;
};
