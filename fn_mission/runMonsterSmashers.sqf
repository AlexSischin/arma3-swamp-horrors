private _chunkSize = 25;
private _color = "ColorGreen";
private _markersEnabled = false;
private _chunkMap = [
    _chunkSize,
    [
        {0.00001},
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, 0.3] call fn_chunkScoreHouse)
        },
        {
            params ["_pos", "_chunkSize"];
            -16 * ([_pos, ["side_right", "side_left", "side_top", "side_bottom"]] call fn_chunkScoreMarker)
        }
    ]
] call fn_chunkBuildMap;
if (_markersEnabled) then {
    [_chunkMap, _color] call fn_chunkVisualizeMap;
};

private _number = 15;
private _groupSizeDistribution = [1, 2, 4];
private _classNameArray = [
    "WBK_SpecialZombie_Smasher_1",
    "WBK_SpecialZombie_Smasher_Acid_1"
];
for [{private _i = 0}, {_i < _number}, {_i = _i + 1}] do {

    private _unitArray = [selectRandom _classNameArray];

    private _params = createHashMap;
    // Map parameters.
    _params set ["_chunkMap", _chunkMap];
    _params set ["_chunkMapId", _chunkMap # 0];
    _params set ["_chunkGrid", _chunkMap # 1];
    _params set ["_chunkSize", _chunkMap # 2];
    // Identity parameters.
    _params set ["_side", independent];
    _params set ["_unitArray", _unitArray];
    // Placement parameters.
    _params set ["_housePosWeight", 4];
    _params set ["_roadPosWeight", 1];
    _params set ["_otherPosWeight", 1];
    // Render parameters.
    _params set ["_showDistanceMin", 50];
    _params set ["_showDistanceMax", 500];
    _params set ["_hideDistanceMin", 600];
    // Migration parameters.
    _params set ["_migrationMaxDistance", 20];
    _params set ["_speedKmH", 10];
    _params set ["_pathfindingMode", "NORMAL"];
    _params set ["_checkpointCompletionDistance", 10];
    _params set ["_checkpointMaxDistance", 100];
    _params set ["_checkpointMode", "DOMOVE"];
    // Performance parameters.
    _params set ["_delay", 5];
    // Marker parameters.
    _params set ["_markersEnabled", _markersEnabled];
    _params set ["_markerColor", _color];
    [_params] spawn fn_groupExecFSMLight;
};
