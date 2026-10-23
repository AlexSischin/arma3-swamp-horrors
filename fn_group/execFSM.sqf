params ["_params"];

private _state = createHashMap;
// Position.
_state set ["_groupIndexPos", nil];
_state set ["_groupWorldPos", nil];
// Game objects.
_state set ["_group", nil];
_state set ["_unit", nil];
// Migration
_state set ["_path", nil];
_state set ["_untraveledTime", nil];
_state set ["_nHops", nil];
// Markers
_state set ["_groupMarker", nil];
_state set ["_pathMarkerArray", nil];

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
            [_params] call fn_groupInitPosition;
            [_params, _state] call fn_groupInitGameObjects;
            [] call fn_groupInitPath;
            [_params, _state] call fn_groupInitMarkers;
        }
    ],
    [
        "HIDDEN",
        [
            [
                "NORMAL",
                {[_params, _state] call fn_groupShouldShow},
                {[_state] call fn_groupFSMShow}
            ],
            [
                "HIDDEN",
                {true},
                {}
            ]
        ],
        {
            [_params, _state] call fn_groupMigrateVirtually;
            [_state] call fn_groupPersistGameObjectState;
            [_params, _state] call fn_groupUpdateMarkers;
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
                {[_params, _state] call fn_groupShouldHide},
                {
                    [_params, _state] call fn_groupReloadGameObjectState;
                    [_state] call fn_groupFSMHide;
                }
            ],
            [
                "NORMAL",
                {true},
                {}
            ]
        ],
        {
            [_params, _state] call fn_groupReloadGameObjectState;
            [_params, _state] call fn_groupMigratePhysically;
            [_params, _state] call fn_groupUpdateMarkers;
        }
    ],
    [
        "ELIMINATED",
        [],
        {}
    ]
];
private _delay = _params get "_delay";
[_fsm, _delay] call fn_FSMExec;
