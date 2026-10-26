private _chunkSize = 50;
private _chunkMap = [
    _chunkSize,
    [
        // {
        //     params ["_pos", "_chunkSize"];
        //     [_pos, 1] call fn_chunkScoreHouse
        // },
        // {
        //     params ["_pos", "_chunkSize"];
        //     [_pos, 1] call fn_chunkScoreRoad
        // },
        {
            params ["_pos", "_chunkSize"];
            [_pos, _chunkSize] call fn_chunkScoreWater
        }
        // {
        //     params ["_pos", "_chunkSize"];
        //     [_pos, 1] call fn_chunkScoreHeight
        // },
        // {
        //     params ["_pos", "_chunkSize"];
        //     [_pos, ["marker_0"]] call fn_chunkScoreMarker
        // }
    ]
] call fn_chunkBuildMap;
[_chunkMap] call fn_chunkVisualizeMap;

private _params = createHashMap;
// Map parameters.
_params set ["_chunkMap", _chunkMap];
_params set ["_chunkMapId", _chunkMap select 0];
_params set ["_chunkGrid", _chunkMap select 1];
_params set ["_chunkSize", _chunkMap select 2];
// Identity parameters.
_params set ["_side", west];
_params set ["_class", "B_Soldier_F"];
_params set ["_unitArray", [
    "rhsusf_socom_marsoc_elementleader",
    "rhsusf_socom_marsoc_cso",
    "rhsusf_socom_marsoc_cso_breacher",
    "rhsusf_socom_marsoc_cso_mechanic",
    "rhsusf_socom_marsoc_sarc"
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
_params set ["_speedKmH", 80];
// Performance parameters.
_params set ["_delay", 2];
// Marker parameters.
_params set ["_markersEnabled", true];

for [{private _i = 0}, {_i < 1}, {_i = _i + 1}] do {
    [_params] spawn fn_groupExecFSM;
};
