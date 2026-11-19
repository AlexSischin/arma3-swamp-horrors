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
            _posState = [_params] call LCX_fnc_initPositionState;
            _gameObjectState = [_params, _posState] call LCX_fnc_initGameObjectState;
            _migrationState = [] call LCX_fnc_initMigrationState;
            _markerState = [_params, _posState] call LCX_fnc_initMarkerState;
        }
    ],
    [
        "HIDDEN",
        [
            [
                "ELIMINATED",
                {[_gameObjectState] call LCX_fnc_isEliminated},
                {}
            ],
            [
                "NORMAL",
                {[_params, _posState] call LCX_fnc_shouldShow},
                {[_gameObjectState] call LCX_fnc_showGroup}
            ],
            [
                "HIDDEN",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _migrationState] call LCX_fnc_updateMigrationDestinationVirtual;
            [_params, _posState, _migrationState] call LCX_fnc_migrateVirtually;
            [_params, _posState, _gameObjectState] call LCX_fnc_updateGameObjectPos;
            [_params, _posState, _gameObjectState, _migrationState, _markerState] call LCX_fnc_updateMarkers;
        }
    ],
    [
        "NORMAL",
        [
            [
                "ELIMINATED",
                {[_gameObjectState] call LCX_fnc_isEliminated},
                {}
            ],
            [
                "HIDDEN",
                {[_params, _posState] call LCX_fnc_shouldHide},
                {
                    [_params, _posState, _gameObjectState] call LCX_fnc_reloadGameObjectState;
                    [_gameObjectState] call LCX_fnc_hideGroup;
                }
            ],
            [
                "NORMAL",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _gameObjectState] call LCX_fnc_reloadGameObjectState;
            [_params, _gameObjectState, _migrationState] call LCX_fnc_updateMigrationDestinationPhysical;
            [_params, _gameObjectState, _migrationState] call LCX_fnc_migratePhysically;
            [_params, _posState, _gameObjectState, _migrationState, _markerState] call LCX_fnc_updateMarkers;
        }
    ],
    [
        "ELIMINATED",
        [],
        {
            [_gameObjectState] call LCX_fnc_showGroup;
            [_params, _posState, _markerState] call LCX_fnc_finalizeMarkers;
        }
    ]
];
private _delay = _params get "_delay";
[_fsm, _delay] call LCX_fnc_execFSM;
