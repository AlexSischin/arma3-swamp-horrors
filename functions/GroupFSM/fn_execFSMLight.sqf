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
            _posState = [_params] call LCX_fnc_initPositionState;
            _gameObjectLightState = [_params, _posState] call LCX_fnc_initGameObjectLightState;
            _migrationState = [] call LCX_fnc_initMigrationState;
            _markerState = [_params, _posState] call LCX_fnc_initMarkerState;
        }
    ],
    [
        "HIDDEN",
        [
            [
                "NORMAL",
                {[_params, _posState] call LCX_fnc_shouldShow},
                {[_params, _posState, _gameObjectLightState] call LCX_fnc_createGroup}
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
            [_params, _posState, _gameObjectLightState, _migrationState, _markerState] call LCX_fnc_updateMarkers;
        }
    ],
    [
        "NORMAL",
        [
            [
                "ELIMINATED",
                {[_gameObjectLightState] call LCX_fnc_isEliminated},
                {}
            ],
            [
                "HIDDEN",
                {[_params, _posState] call LCX_fnc_shouldHide},
                {
                    [_params, _posState, _gameObjectLightState] call LCX_fnc_reloadGameObjectLightState;
                    [_gameObjectLightState] call LCX_fnc_deleteGroup;
                }
            ],
            [
                "NORMAL",
                {true},
                {}
            ]
        ],
        {
            [_params, _posState, _gameObjectLightState] call LCX_fnc_reloadGameObjectLightState;
            [_params, _gameObjectLightState, _migrationState] call LCX_fnc_updateMigrationDestinationPhysical;
            [_params, _gameObjectLightState, _migrationState] call LCX_fnc_migratePhysically;
            [_params, _posState, _gameObjectLightState, _migrationState, _markerState] call LCX_fnc_updateMarkers;
        }
    ],
    [
        "ELIMINATED",
        [],
        {
            [_params, _posState, _markerState] call LCX_fnc_finalizeMarkers;
        }
    ]
];
private _delay = _params get "_delay";
[_fsm, _delay] call LCX_fnc_execFSM;
