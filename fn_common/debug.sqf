params ["_message"];

if (isNil "FSMDebugEnabled") exitWith {};
if (!FSMDebugEnabled) exitWith {};

diag_log format ["DEBUG %1", _message];
