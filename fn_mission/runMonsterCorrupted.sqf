private _chunkSize = 25;
private _color = "ColorBrown";
private _chunkMap = [
    _chunkSize,
    [
        {0.01},
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, _chunkSize] call fn_chunkScoreWater)
        },
        {
            params ["_pos", "_chunkSize"];
            -16 * ([_pos, ["side_right", "side_left", "side_top", "side_bottom"]] call fn_chunkScoreMarker)
        }
    ]
] call fn_chunkBuildMap;
[_chunkMap, _color] call fn_chunkVisualizeMap;

private _params = createHashMap;
// Map parameters.
_params set ["_chunkMap", _chunkMap];
_params set ["_chunkMapId", _chunkMap select 0];
_params set ["_chunkGrid", _chunkMap select 1];
_params set ["_chunkSize", _chunkMap select 2];
// Identity parameters.
_params set ["_side", independent];
_params set ["_unitArray", [
    "WBK_SpecialZombie_Corrupted_1",
    "WBK_SpecialZombie_Corrupted_1",
    "WBK_SpecialZombie_Corrupted_1",
    "WBK_SpecialZombie_Corrupted_1",
    "WBK_SpecialZombie_Corrupted_1"
]];
// Placement parameters.
_params set ["_housePosWeight", 4];
_params set ["_roadPosWeight", 1];
_params set ["_otherPosWeight", 1];
// Render parameters.
_params set ["_showDistanceMin", 50];
_params set ["_showDistanceMax", 500];
_params set ["_hideDistanceMin", 600];
// Migration parameters.
_params set ["_migrationMaxDistance", 500];
_params set ["_speedKmH", 40];
_params set ["_destinationChunkDistance", 3];
_params set ["_migrationMode", "DOMOVE"];
// Performance parameters.
_params set ["_delay", 2];
// Marker parameters.
_params set ["_markersEnabled", true];
_params set ["_markerColor", _color];

for [{private _i = 0}, {_i < 1}, {_i = _i + 1}] do {
    [_params] spawn fn_groupExecFSMLight;
};
