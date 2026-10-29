params ["_params"];

private _posState = nil;
private _gameObjectState = nil;
private _migrationState = nil;
private _markerState = nil;

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
            _posState = [_params] call fn_groupInitPositionState;
            _gameObjectState = [_params, _posState] call fn_groupInitGameObjectState;
            _migrationState = [] call fn_groupInitMigrationState;
            _markerState = [_params, _posState] call fn_groupInitMarkerState;
        }
    ],
    [
        "HIDDEN",
        [
            [
                "ELIMINATED",
                {[_gameObjectState] call fn_groupIsEliminated},
                {}
            ],
            [
                "NORMAL",
                {[_params, _posState] call fn_groupShouldShow},
                {[_gameObjectState] call fn_groupFSMShow}
            ],
            [
                "HIDDEN",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _migrationState] call fn_groupMigrateVirtually;
            [_params, _posState, _gameObjectState] call fn_groupUpdateGameObjectPos;
            [_params, _posState, _gameObjectState, _migrationState, _markerState] call fn_groupUpdateMarkers;
        }
    ],
    [
        "NORMAL",
        [
            [
                "ELIMINATED",
                {[_gameObjectState] call fn_groupIsEliminated},
                {}
            ],
            [
                "HIDDEN",
                {[_params, _posState] call fn_groupShouldHide},
                {
                    [_params, _posState, _gameObjectState] call fn_groupReloadGameObjectState;
                    [_gameObjectState] call fn_groupFSMHide;
                }
            ],
            [
                "NORMAL",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _gameObjectState] call fn_groupReloadGameObjectState;
            [_params, _posState, _gameObjectState, _migrationState] call fn_groupMigratePhysically;
            [_params, _posState, _gameObjectState, _migrationState, _markerState] call fn_groupUpdateMarkers;
        }
    ],
    [
        "ELIMINATED",
        [],
        {
            [_gameObjectState] call fn_groupFSMShow;
            [_params, _posState, _markerState] call fn_groupFinalizeMarkers;
        }
    ]
];
private _delay = _params get "_delay";
[_fsm, _delay] call fn_FSMExec;
