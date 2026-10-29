call compile preprocessFileLineNumbers "fn_common\_init.sqf";
call compile preprocessFileLineNumbers "fn_object\_init.sqf";
call compile preprocessFileLineNumbers "fn_FSM\_init.sqf";
call compile preprocessFileLineNumbers "fn_chunk\_init.sqf";
call compile preprocessFileLineNumbers "fn_path\_init.sqf";
call compile preprocessFileLineNumbers "fn_group\_init.sqf";

// execVM "testLive.sqf";
execVM "testLight.sqf";

setTimeMultiplier 24;
