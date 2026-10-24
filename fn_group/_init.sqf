fn_groupInitPositionState = compile preprocessFile "fn_group\initPositionState.sqf";
fn_groupInitGameObjectState = compile preprocessFile "fn_group\initGameObjectState.sqf";
fn_groupInitMigrationState = compile preprocessFile "fn_group\initMigrationState.sqf";
fn_groupInitMarkerState = compile preprocessFile "fn_group\initMarkerState.sqf";

fn_groupReloadGameObjectState = compile preprocessFile "fn_group\reloadGameObjectState.sqf";
fn_groupPersistGameObjectState = compile preprocessFile "fn_group\persistGameObjectState.sqf";

fn_groupUpdateMarkers = compile preprocessFile "fn_group\updateMarkers.sqf";

fn_groupCreateUnit = compile preprocessFile "fn_group\createUnit.sqf";

fn_groupGetControlledUavs = compile preprocessFile "fn_group\getControlledUavs.sqf";
fn_groupGetRenderSubjects = compile preprocessFile "fn_group\getRenderSubjects.sqf";
fn_groupShouldShow = compile preprocessFile "fn_group\shouldShow.sqf";
fn_groupShouldHide = compile preprocessFile "fn_group\shouldHide.sqf";

fn_groupFSMShow = compile preprocessFile "fn_group\show.sqf";
fn_groupFSMHide = compile preprocessFile "fn_group\hide.sqf";

fn_groupFSMIsEliminated = compile preprocessFile "fn_group\isEliminated.sqf";

fn_groupChunkGridToInverseWeightGrid = compile preprocessFile "fn_group\chunkGridToInverseWeightGrid.sqf";
fn_groupWeightPathGrid = compile preprocessFile "fn_group\weightPathGrid.sqf";
fn_groupUpdatePath = compile preprocessFile "fn_group\updatePath.sqf";
fn_groupChoosePathToTarget = compile preprocessFile "fn_group\choosePathToTarget.sqf";
fn_groupChooseRandomPath = compile preprocessFile "fn_group\chooseRandomPath.sqf";
fn_groupChooseBackoffPath = compile preprocessFile "fn_group\chooseBackoffPath.sqf";
fn_groupChooseRandomNeighbourPath = compile preprocessFile "fn_group\chooseRandomNeighbourPath.sqf";
fn_groupCalculatePathHopPlan = compile preprocessFile "fn_group\calculatePathHopPlan.sqf";
fn_groupMigrateVirtually = compile preprocessFile "fn_group\migrateVirtually.sqf";
fn_groupMigratePhysically = compile preprocessFile "fn_group\migratePhysically.sqf";

fn_groupVisualizeIndexPath = compile preprocessFile "fn_group\visualizeIndexPath.sqf";

fn_groupExecFSM = compile preprocessFile "fn_group\execFSM.sqf";

diag_log "fn_group module is initialized";
