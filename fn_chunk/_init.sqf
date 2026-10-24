fn_chunkPositiveSigmoid = compile preprocessFile "fn_chunk\positiveSigmoid.sqf";
fn_chunkSquareArea = compile preprocessFile "fn_chunk\squareArea.sqf";
fn_chunkBuildMap = compile preprocessFile "fn_chunk\buildMap.sqf";

fn_chunkGetIndexForPos = compile preprocessFile "fn_chunk\getIndexForPos.sqf";
fn_chunkGetPosForIndex = compile preprocessFile "fn_chunk\getPosForIndex.sqf";
fn_chunkGetPosForIndexArray = compile preprocessFile "fn_chunk\getPosForIndexArray.sqf";
fn_chunkSelectRandomWorldPos = compile preprocessFile "fn_chunk\selectRandomWorldPos.sqf";
fn_chunkVisualizeMap = compile preprocessFile "fn_chunk\visualizeMap.sqf";

fn_chunkScoreHouse = compile preprocessFile "fn_chunk\scoreHouse.sqf";
fn_chunkScoreRoad = compile preprocessFile "fn_chunk\scoreRoad.sqf";
fn_chunkScoreWater = compile preprocessFile "fn_chunk\scoreWater.sqf";
fn_chunkScoreHeight = compile preprocessFile "fn_chunk\scoreHeight.sqf";
fn_chunkScoreMarker = compile preprocessFile "fn_chunk\scoreMarker.sqf";

diag_log "fn_chunk module is initialized";
