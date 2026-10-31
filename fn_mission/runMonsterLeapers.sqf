private _chunkSize = 25;
private _color = "Color5_FD_F";
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

private _groupNumber = 25;
private _groupSizeDistribution = [1, 2, 4];
private _classNameArray = [
    "Zombie_Special_GREENFOR_Leaper_1",
    "Zombie_Special_GREENFOR_Leaper_2"
];
for [{private _g = 0}, {_g < _groupNumber}, {_g = _g + 1}] do {

    private _groupSize = floor random _groupSizeDistribution;
    private _unitArray = [];
    _unitArray resize [_groupSize, selectRandom _classNameArray];

    private _params = createHashMap;
    // Map parameters.
    _params set ["_chunkMap", _chunkMap];
    _params set ["_chunkMapId", _chunkMap select 0];
    _params set ["_chunkGrid", _chunkMap select 1];
    _params set ["_chunkSize", _chunkMap select 2];
    // Identity parameters.
    _params set ["_side", independent];
    _params set ["_unitArray", [
        "Zombie_Special_GREENFOR_Leaper_1",
        "Zombie_Special_GREENFOR_Leaper_2"
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
    _params set ["_delay", 5];
    // Marker parameters.
    _params set ["_markersEnabled", _markersEnabled];
    _params set ["_markerColor", _color];
    [_params] spawn fn_groupExecFSMLight;
};
