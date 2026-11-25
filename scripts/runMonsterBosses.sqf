private _chunkSize = 25;
private _color = "ColorGreen";
private _markersEnabled = true;
private _chunkMap = [
    _chunkSize,
    [
        {0.01},
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, 0.3] call LCX_fnc_scoreHouse)
        },
        {
            params ["_pos", "_chunkSize"];
            -10 * ([_pos, _chunkSize, 1] call LCX_fnc_scoreWaterThresholdDepth)
        },
        {
            params ["_pos", "_chunkSize"];
            -16 * ([_pos, blackZoneArray + islandArray] call LCX_fnc_scoreMarker)
        }
    ]
] call LCX_fnc_buildChunkMap;
if (_markersEnabled) then {
    [_chunkMap, _color] call LCX_fnc_visualizeChunkMap;
};

private _fnDestination = {
    if (sunOrMoon <= 0.001 && {alive lure}) exitWith {getPos lure}
};
private _number = 15;
private _groupSizeDistribution = [1, 2, 4];
private _classNameArray = [
    "WBK_SpecialZombie_Smasher_1"
];
private _spawnAreaCenter = getPos lure;
for [{private _i = 0}, {_i < _number}, {_i = _i + 1}] do {

    private _unitArray = [selectRandom _classNameArray];

    private _initPos = [_spawnAreaCenter, _number, 1] call LCX_fnc_findSafePos;
    private _group = [independent, _unitArray, [], _initPos] call LCX_fnc_createGroup;

    private _params = createHashMap;
    // Map parameters.
    _params set ["_chunkMap", _chunkMap];
    _params set ["_chunkMapId", _chunkMap # 0];
    _params set ["_chunkGrid", _chunkMap # 1];
    _params set ["_chunkSize", _chunkMap # 2];
    // Identity parameters.
    _params set ["_group", _group];
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
    _params set ["_speedKmH", 30];
    _params set ["_pathfindingMode", "NORMAL"];
    _params set ["_checkpointCompletionDistance", 10];
    _params set ["_checkpointMaxDistance", 100];
    _params set ["_fnDestination", _fnDestination];
    _params set ["_checkpointMode", "DOMOVE"];
    // Performance parameters.
    _params set ["_delay", 5];
    // Marker parameters.
    _params set ["_markersEnabled", _markersEnabled];
    _params set ["_markerColor", _color];
    [_params] spawn LCX_fnc_execFSMNormal;
};
