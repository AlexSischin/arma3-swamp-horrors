// Logging.
fn_commonDebug = compile preprocessFile "fn_common\debug.sqf";
fn_commonError = compile preprocessFile "fn_common\error.sqf";

// Random.
fn_commonGenerateId = compile preprocessFile "fn_common\generateId.sqf";

// Array utilities.
fn_commonFlattenArray = compile preprocessFile "fn_common\flattenArray.sqf";
fn_commonSelectRandomWeighted = compile preprocessFile "fn_common\selectRandomWeighted.sqf";
fn_commonSortedInsert = compile preprocessFile "fn_common\sortedInsert.sqf";

// Visualization.
fn_commonVisualizePoint = compile preprocessFile "fn_common\visualizePoint.sqf";
fn_commonVisualizePointArray = compile preprocessFile "fn_common\visualizePointArray.sqf";

// Cache.
fn_commonCacheHas = compile preprocessFile "fn_common\cacheHas.sqf";
fn_commonCacheGet = compile preprocessFile "fn_common\cacheGet.sqf";
fn_commonCachePut = compile preprocessFile "fn_common\cachePut.sqf";

diag_log "fn_common module is initialized";
