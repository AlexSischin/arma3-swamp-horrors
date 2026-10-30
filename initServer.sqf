// Imports.
call compile preprocessFileLineNumbers "fn_common\_init.sqf";
call compile preprocessFileLineNumbers "fn_object\_init.sqf";
call compile preprocessFileLineNumbers "fn_FSM\_init.sqf";
call compile preprocessFileLineNumbers "fn_chunk\_init.sqf";
call compile preprocessFileLineNumbers "fn_path\_init.sqf";
call compile preprocessFileLineNumbers "fn_group\_init.sqf";
call compile preprocessFileLineNumbers "fn_mission\_init.sqf";

// Create monsters.
// spawn fn_missionRunMonsterBoomers;
// spawn fn_missionRunMonsterLeapers;
spawn fn_missionRunMonsterCorrupted;

// Create Russians.
// spawn fn_missionRunRussians;

// Set mission params.
setTimeMultiplier 24;
