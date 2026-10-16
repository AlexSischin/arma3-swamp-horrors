params ["_chunkMap"];

// Identity parameters.
private _side = west;
private _class = "B_Soldier_F";

// Placement parameters.
private _housePosWeight = 4;
private _roadPosWeight = 1;
private _otherPosWeight = 1;

// Render parameters.
private _showDistanceMin = 50;
private _showDistanceMax = 500;
private _hideDistanceMin = _showDistanceMax + 100;

// Migration parameters.
private _migrationMaxDistance = 500;
private _speedKmH = 80;

// Performance parameters.
private _delay = 2;

// Convenience variables.
private _chunkGrid = _chunkMap select 1;
private _chunkSize = _chunkMap select 2;

// State variables.
private _groupIndexPos = nil;
private _groupWorldPos = nil;

private _group = nil;
private _unit = nil;

private _path = nil;
private _untraveledTime = nil;

private _groupMarker = nil;
private _pathMarkerArray = nil;

// Behaviour.
private _fsm = [
    [
        "CREATED",
        [
            [
                "HIDDEN",
                {true},
                {}
            ]
        ],
        {
            // Init position.
            _groupIndexPos = [_chunkGrid, 2, {_this select 1}] call fn_commonSelectRandomWeighted select 0;
            _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectUnitPos;

            // Init game objects.
            private _dir = random 360;
            _group = createGroup [_side, true];
            _group setFormDir _dir;
            _unit = [_group, _groupWorldPos, _class] call fn_groupCreateUnit;
            _unit setDir _dir;

            // Init path.
            _path = [];
            _untraveledTime = 0;

            // Create markers.
            _groupMarker = [_groupWorldPos, "ColorBLUFOR", "b_inf"] call fn_commonVisualizePoint;
            _pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
        }
    ],
    [
        "HIDDEN",
        [
            [
                "NORMAL",
                {[_groupWorldPos, _showDistanceMin, _showDistanceMax] call fn_groupShouldShow},
                {[_group] call fn_groupFSMShow}
            ],
            [
                "HIDDEN",
                {true},
                {}
            ]
        ],
        {
            // Update group pos.
            _groupWorldPos = getPos _unit;
            _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;

            // Migrate.
            private _time = _untraveledTime + _delay;
            private _migrationPlan = [_chunkMap, _time, _path, _groupIndexPos, _speedKmH, _migrationMaxDistance] call fn_groupCalculateVirtualMigration;
            _path = _migrationPlan select 0;
            _groupIndexPos = _migrationPlan select 1;
            _nHops = _migrationPlan select 2;
            _untraveledTime = _migrationPlan select 3;

            // Update game objects.
            if (_nHops > 0) then {
                _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectUnitPos;
                _unit setPos _groupWorldPos;
            };

            // Update markers.
            _groupMarker setMarkerPos _groupWorldPos;
            if (_nHops > 0) then {
                {deleteMarker _x} forEach _pathMarkerArray;
                _pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
            };
        }
    ],
    [
        "NORMAL",
        [
            [
                "ELIMINATED",
                {[] call fn_groupFSMIsEliminated},
                {}
            ],
            [
                "HIDDEN",
                {[_groupWorldPos, _hideDistanceMin] call fn_groupShouldHide},
                {[_group] call fn_groupFSMHide}
            ],
            [
                "NORMAL",
                {true},
                {}
            ]
        ],
        {
            // Update group pos and chunk.
            _groupWorldPos = getPos _unit;
            _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;

            // Update waypoint.
            private _time = _untraveledTime + _delay;
            private _pathHopPlan = [_time, _speedKmH, _chunkSize] call fn_groupCalculatePathHopPlan;
            private _nHops = _pathHopPlan select 0;
            private _untraveledTime = _pathHopPlan select 1;
            private _currentPath = _path;
            if (_nHops > 0) then {
                _path = [_chunkMap, _path, _groupIndexPos, _migrationMaxDistance] call fn_groupUpdatePath;
                if (count _path > 1) then {
                    if !(_currentPath isEqualTo _path) then {
                        private _newTargetIndexPos = _path select (1 min ((count _path) - 1));
                        private _newTargetWorldPos = [_newTargetIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectUnitPos;
                        for [{private _w = 0}, {_w < count waypoints _group}, {_w = _w + 1}] do {
                            deleteWaypoint [_group, 0];
                        };
                        _group addWaypoint [_newTargetWorldPos, 0];
                    };
                };
            };

            // Update marker.
            _groupMarker setMarkerPos _groupWorldPos;
            if !(_currentPath isEqualTo _path) then {
                {deleteMarker _x} forEach _pathMarkerArray;
                _pathMarkerArray = [_path, _chunkSize, "colorBLUFOR"] call fn_groupVisualizeIndexPath;
            };
        }
    ],
    [
        "ELIMINATED",
        [],
        {}
    ]
];

[_fsm, _delay] call fn_FSMExec;
