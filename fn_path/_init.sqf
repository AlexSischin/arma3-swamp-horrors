fn_pathGetNeighbourPointArray = compile preprocessFile "fn_path\getNeighbourPointArray.sqf";
fn_pathFind = compile preprocessFile "fn_path\find.sqf";
fn_pathFindAll = compile preprocessFile "fn_path\findAll.sqf";
fn_pathFindBackoff = compile preprocessFile "fn_path\findBackoff.sqf";
fn_pathFindRandomNeighbourPath = compile preprocessFile "fn_path\findRandomNeighbourPath.sqf";

diag_log "fn_path module is initialized";
