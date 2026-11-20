private _chunkSize = 25;
private _color = "Color3_FD_F";
private _markersEnabled = false;
private _chunkMap = [
    _chunkSize,
    [
        {
            params ["_pos", "_chunkSize"];
            1 * ([_pos, 0.003] call LCX_fnc_scorePhragmitesAustralis)
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

private _groupNumber = 25;
private _groupSizeDistribution = [1, 3, 6];
private _className = "Zombie_Special_GREENFOR_Boomer";
for [{private _g = 0}, {_g < _groupNumber}, {_g = _g + 1}] do {

    private _groupSize = floor random _groupSizeDistribution;
    private _unitArray = [];
    _unitArray resize [_groupSize, _className];

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
    _params set ["_showDistanceMax", 300];
    _params set ["_hideDistanceMin", 400];
    // Migration parameters.
    _params set ["_migrationMaxDistance", 4];
    _params set ["_speedKmH", 8];
    _params set ["_pathfindingMode", "SIMPLE"];
    _params set ["_checkpointCompletionDistance", 10];
    _params set ["_checkpointMaxDistance", 100];
    _params set ["_fnDestination", {}];
    _params set ["_checkpointMode", "DOMOVE"];
    // Performance parameters.
    _params set ["_delay", 5];
    // Marker parameters.
    _params set ["_markersEnabled", _markersEnabled];
    _params set ["_markerColor", _color];
    [_params] spawn LCX_fnc_execFSMLight;
};
