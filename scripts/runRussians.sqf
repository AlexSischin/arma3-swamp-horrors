private _chunkSize = 25;
private _color = "ColorOPFOR";
private _markersEnabled = false;
private _chunkMap = [
    _chunkSize,
    [
        {0.1},
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, 20] call LCX_fnc_scoreRoad)
        },
        {
            params ["_pos", "_chunkSize"];
            0.05 * ([_pos, 0.1] call LCX_fnc_scoreHeight)
        },
        {
            params ["_pos", "_chunkSize"];
            -5 * ([_pos, 0.1] call LCX_fnc_scoreHouse)
        },
        {
            params ["_pos", "_chunkSize"];
            -1 * ([_pos, 0.0001] call LCX_fnc_scoreVegetation)
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
    [_chunkMap, _color] call LCX_fnc_visualizeChunkMap;
};

private _params = createHashMap;
// Map parameters.
_params set ["_chunkMap", _chunkMap];
_params set ["_chunkMapId", _chunkMap # 0];
_params set ["_chunkGrid", _chunkMap # 1];
_params set ["_chunkSize", _chunkMap # 2];
// Identity parameters.
_params set ["_side", east];
_params set ["_unitArray", [
    "rhs_msv_sergeant",
    "rhs_msv_machinegunner",
    "rhs_msv_at",
    "rhs_msv_strelok_rpg_assist"
]];
_params set ["_vehicleArray", [
    ["rhs_tigr_m_msv", [["rhs_msv_emr_combatcrew", "driver", []], ["rhs_msv_emr_combatcrew", "gunner", [0]]]],
    ["rhs_uaz_open_MSV_01", [["rhs_msv_emr_combatcrew", "driver", []]]]
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
_params set ["_migrationMaxDistance", 40];
_params set ["_speedKmH", 40];
_params set ["_pathfindingMode", "NORMAL"];
_params set ["_checkpointCompletionDistance", 25];
_params set ["_checkpointMaxDistance", 200];
_params set ["_fnDestination", {}];
_params set ["_checkpointMode", "WAYPOINT"];
// Performance parameters.
_params set ["_delay", 2];
// Marker parameters.
_params set ["_markersEnabled", _markersEnabled];
_params set ["_markerColor", _color];

for [{private _i = 0}, {_i < 1}, {_i = _i + 1}] do {
    [_params] spawn LCX_fnc_execFSMNormal;
};
