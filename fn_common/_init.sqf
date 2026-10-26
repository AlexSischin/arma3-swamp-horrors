// Logging.
fn_commonDebug = compile preprocessFileLineNumbers "fn_common\debug.sqf";
fn_commonError = compile preprocessFileLineNumbers "fn_common\error.sqf";

// Random.
fn_commonGenerateId = compile preprocessFileLineNumbers "fn_common\generateId.sqf";

// Array utilities.
fn_commonFlattenArray = compile preprocessFileLineNumbers "fn_common\flattenArray.sqf";
fn_commonSelectRandomWeighted = compile preprocessFileLineNumbers "fn_common\selectRandomWeighted.sqf";
fn_commonSortedInsert = compile preprocessFileLineNumbers "fn_common\sortedInsert.sqf";

// Visualization.
fn_commonVisualizePoint = compile preprocessFileLineNumbers "fn_common\visualizePoint.sqf";
fn_commonVisualizePointArray = compile preprocessFileLineNumbers "fn_common\visualizePointArray.sqf";

// Cache.
fn_commonCacheHas = compile preprocessFileLineNumbers "fn_common\cacheHas.sqf";
fn_commonCacheGet = compile preprocessFileLineNumbers "fn_common\cacheGet.sqf";
fn_commonCachePut = compile preprocessFileLineNumbers "fn_common\cachePut.sqf";

diag_log "fn_common module is initialized";
