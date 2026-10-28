// FSM & chunks.
fn_groupExecFSM = compile preprocessFileLineNumbers "fn_group\execFSM.sqf";
fn_groupChunkGridToInverseWeightGrid = compile preprocessFileLineNumbers "fn_group\chunkGridToInverseWeightGrid.sqf";

// Positioning.
fn_groupInitPositionState = compile preprocessFileLineNumbers "fn_group\initPositionState.sqf";
fn_groupFindSafePos = compile preprocessFileLineNumbers "fn_group\findSafePos.sqf";

// Migration.
fn_groupInitMigrationState = compile preprocessFileLineNumbers "fn_group\initMigrationState.sqf";
fn_groupWeightPathGrid = compile preprocessFileLineNumbers "fn_group\weightPathGrid.sqf";
fn_groupCalculatePathHopPlan = compile preprocessFileLineNumbers "fn_group\calculatePathHopPlan.sqf";
fn_groupChoosePathToTarget = compile preprocessFileLineNumbers "fn_group\choosePathToTarget.sqf";
fn_groupChooseRandomPath = compile preprocessFileLineNumbers "fn_group\chooseRandomPath.sqf";
fn_groupChooseBackoffPath = compile preprocessFileLineNumbers "fn_group\chooseBackoffPath.sqf";
fn_groupChooseRandomNeighbourPath = compile preprocessFileLineNumbers "fn_group\chooseRandomNeighbourPath.sqf";
fn_groupUpdatePath = compile preprocessFileLineNumbers "fn_group\updatePath.sqf";
fn_groupMigrateVirtually = compile preprocessFileLineNumbers "fn_group\migrateVirtually.sqf";
fn_groupMigratePhysically = compile preprocessFileLineNumbers "fn_group\migratePhysically.sqf";

// Game objects.
fn_groupCreateUnit = compile preprocessFileLineNumbers "fn_group\createUnit.sqf";
fn_groupCreateVehicle = compile preprocessFileLineNumbers "fn_group\createVehicle.sqf";
fn_groupInitGameObjectState = compile preprocessFileLineNumbers "fn_group\initGameObjectState.sqf";
fn_groupReloadGameObjectState = compile preprocessFileLineNumbers "fn_group\reloadGameObjectState.sqf";
fn_groupIsEliminated = compile preprocessFileLineNumbers "fn_group\isEliminated.sqf";

// Visibility.
fn_groupGetControlledUavs = compile preprocessFileLineNumbers "fn_group\getControlledUavs.sqf";
fn_groupGetRenderSubjects = compile preprocessFileLineNumbers "fn_group\getRenderSubjects.sqf";
fn_groupShouldShow = compile preprocessFileLineNumbers "fn_group\shouldShow.sqf";
fn_groupShouldHide = compile preprocessFileLineNumbers "fn_group\shouldHide.sqf";
fn_groupFSMShow = compile preprocessFileLineNumbers "fn_group\show.sqf";
fn_groupFSMHide = compile preprocessFileLineNumbers "fn_group\hide.sqf";

// Markers.
fn_groupVisualizeIndexPos = compile preprocessFileLineNumbers "fn_group\visualizeIndexPos.sqf";
fn_groupVisualizeIndexPath = compile preprocessFileLineNumbers "fn_group\visualizeIndexPath.sqf";
fn_groupInitMarkerState = compile preprocessFileLineNumbers "fn_group\initMarkerState.sqf";
fn_groupUpdateMarkers = compile preprocessFileLineNumbers "fn_group\updateMarkers.sqf";
fn_groupFinalizeMarkers = compile preprocessFileLineNumbers "fn_group\finalizeMarkers.sqf";

diag_log "fn_group module is initialized";
