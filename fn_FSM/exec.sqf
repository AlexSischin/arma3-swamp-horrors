params ["_fsm", "_delay"];

// Initial state is always the first state in the FSM.
private _currentState = _fsm select 0;

// Variables for logging.
private _id = call fn_commonGenerateId;
private _currentStateName = _currentState select 0;
private _descriptor = format ["[FSM][%1][%2]", _id, _currentStateName];

// Execute initial state entry code
private _entryCode = _currentState select 2;
try {
    [] call _entryCode;
} catch {
    private _message = format ["%1: failed to execute entry code for the initial state; error:", _descriptor, str _exception];
    _message call fn_commonError;
    throw _message;
};
format ["%1: executed entry code for the initial state", _descriptor] call fn_commonDebug;

// Run FSM loop until a terminal state is reached.
// State is considered terminal when it has no links.
while {true} do {

    // Update variables for logging.
    _currentStateName = _currentState select 0;
    _descriptor = format ["[FSM][%1][%2]", _id, _currentStateName];

    // Check termination.
    private _linkArray = _currentState select 1;
    if (count _linkArray == 0) exitWith {
        format ["%1: reached terminal state; exiting", _descriptor] call fn_commonDebug;
    };

    // Evaluate the next state link.
    private _nextStateLink = nil;
    for [{private _l = 0}, {_l < count _linkArray}, {_l = _l + 1}] do {
        private _link = _linkArray select _l;

        private _transitionCondition = _link select 1;
        private _transitionConditionValue = nil;
        try {
            _transitionConditionValue = [] call _transitionCondition;
        } catch {
            format ["%1: failed to execute transition code; error:", _descriptor, str _exception] call fn_commonError;
        };
        if (isNil "_transitionConditionValue") then {
            format ["%1: transition condition value is nil", _descriptor] call fn_commonError;
            continue;
        };
        if !(_transitionConditionValue isEqualType true) then {
            format ["%1: transition condition value is not boolean: %2", _descriptor, _transitionConditionValue] call fn_commonError;
            continue;
        };
        if (_transitionConditionValue) exitWith {
            _nextStateLink = _link;
        };
    };
    if (isNil "_nextStateLink") then {
        format ["%1: failed to evaluate the next state", _descriptor] call fn_commonError;
        continue;
    };

    // Resolve the next state by name reference from the link.
    private _nextStateName = _nextStateLink select 0;
    private _nextState = nil;
    for [{private _s = 0}, {_s < count _fsm}, {_s = _s + 1}] do {
        private _state = _fsm select _s;

        private _stateName = _state select 0;
        if (_stateName == _nextStateName) exitWith {
            _nextState = _state;
        };
    };

    // Perform state transition.
    private _transitionCode = _nextStateLink select 2;
    try {
        [] call _transitionCode;
    } catch {
        format ["%1: failed to execute transition code; error:", _descriptor, str _exception] call fn_commonError;
    };
    private _nextStateEntryCode = _nextState select 2;
    try {
        [] call _nextStateEntryCode;
    } catch {
        format ["%1: failed to execute next state entry code; error:", _descriptor, str _exception] call fn_commonError;
    };
    format ["%1: switched to state: %2", _descriptor, _nextStateName] call fn_commonDebug;

    // Reiterate.
    _currentState = _nextState;
    _currentStateName = _currentState select 0;
    sleep _delay;
};
