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
        // {
        //     params ["_pos", "_chunkSize"];
        //     [_pos, _chunkSize] call fn_chunkScoreWater
        // }
        // {
        //     params ["_pos", "_chunkSize"];
        //     [_pos, 1] call fn_chunkScoreHeight
        // },
        {
            params ["_pos", "_chunkSize"];
            [_pos, ["marker_0"]] call fn_chunkScoreMarker
        }
    ]
] call fn_chunkBuildMap;
[_chunkMap] call fn_chunkVisualizeMap;

for [{private _i = 0}, {_i < 1}, {_i = _i + 1}] do {
    [_chunkMap] spawn fn_groupExecFSM;
};
