// Global variables
blackZoneArray = ["side_right", "side_left", "side_top", "side_bottom"];
islandArray = ["island_1", "island_2"];

// Spawn objects.
execVM "scripts\lure.sqf";
execVM "scripts\bigTruck.sqf";
execVM "scripts\minefield.sqf";

// Communication.
execVM "scripts\airdropSupply.sqf";

// Spawn monsters.
// execVM "scripts\runMonsterBoomers.sqf";
// execVM "scripts\runMonsterLeapers.sqf";
// execVM "scripts\runMonsterCorrupted.sqf";
execVM "scripts\runMonsterBosses.sqf";

// Spawn Russians.
// execVM "scripts\runRussians.sqf";

// Set mission params.
setTimeMultiplier 24;
