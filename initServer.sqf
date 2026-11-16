// Imports.
call compile preprocessFileLineNumbers "fn_common\_init.sqf";
call compile preprocessFileLineNumbers "fn_object\_init.sqf";
call compile preprocessFileLineNumbers "fn_FSM\_init.sqf";
call compile preprocessFileLineNumbers "fn_chunk\_init.sqf";
call compile preprocessFileLineNumbers "fn_path\_init.sqf";
call compile preprocessFileLineNumbers "fn_group\_init.sqf";
call compile preprocessFileLineNumbers "fn_mission\_init.sqf";

// Global variables
blackZoneArray = ["side_right", "side_left", "side_top", "side_bottom"];
islandArray = ["island_1", "island_2"];

// Spawn objects.
spawn fn_missionBossDevice;
spawn fn_missionBigTruck;
spawn fn_missionMinefield;

// Spawn monsters.
// spawn fn_missionRunMonsterBoomers;
// spawn fn_missionRunMonsterLeapers;
// spawn fn_missionRunMonsterCorrupted;
// spawn fn_missionRunMonsterBosses;

// Spawn Russians.
// spawn fn_missionRunRussians;

// Set mission params.
setTimeMultiplier 24;
