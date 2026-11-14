fn_pathManhattanDistance = compile preprocessFileLineNumbers "fn_path\manhattanDistance.sqf";
fn_pathFindNearestPoint = compile preprocessFileLineNumbers "fn_path\findNearestPoint.sqf";
fn_pathGetNeighbourPointArray = compile preprocessFileLineNumbers "fn_path\getNeighbourPointArray.sqf";
fn_pathFind = compile preprocessFileLineNumbers "fn_path\find.sqf";
fn_pathFindAll = compile preprocessFileLineNumbers "fn_path\findAll.sqf";
fn_pathFindBackoff = compile preprocessFileLineNumbers "fn_path\findBackoff.sqf";
fn_pathFindRandomNeighbourPath = compile preprocessFileLineNumbers "fn_path\findRandomNeighbourPath.sqf";
fn_pathConcat = compile preprocessFileLineNumbers "fn_path\concat.sqf";

diag_log "fn_path module is initialized";
