params ["_params"];

private _posState = nil;
private _gameObjectLightState = nil;
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
            _gameObjectLightState = [_params, _posState] call fn_groupInitGameObjectLightState;
            _migrationState = [] call fn_groupInitMigrationState;
            _markerState = [_params, _posState] call fn_groupInitMarkerState;
        }
    ],
    [
        "HIDDEN",
        [
            [
                "NORMAL",
                {[_params, _posState] call fn_groupShouldShow},
                {[_params, _posState, _gameObjectLightState] call fn_groupFSMCreate}
            ],
            [
                "HIDDEN",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _migrationState] call fn_groupMigrateVirtually;
            [_params, _posState, _gameObjectLightState, _migrationState, _markerState] call fn_groupUpdateMarkers;
        }
    ],
    [
        "NORMAL",
        [
            [
                "ELIMINATED",
                {[_gameObjectLightState] call fn_groupIsEliminated},
                {}
            ],
            [
                "HIDDEN",
                {[_params, _posState] call fn_groupShouldHide},
                {
                    [_params, _posState, _gameObjectLightState] call fn_groupReloadGameObjectLightState;
                    [_gameObjectLightState] call fn_groupFSMDelete;
                }
            ],
            [
                "NORMAL",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _gameObjectLightState] call fn_groupReloadGameObjectLightState;
            [_params, _posState, _gameObjectLightState, _migrationState] call fn_groupMigratePhysically;
            [_params, _posState, _gameObjectLightState, _migrationState, _markerState] call fn_groupUpdateMarkers;
        }
    ],
    [
        "ELIMINATED",
        [],
        {
            [_params, _posState, _markerState] call fn_groupFinalizeMarkers;
        }
    ]
];
private _delay = _params get "_delay";
[_fsm, _delay] call fn_FSMExec;
