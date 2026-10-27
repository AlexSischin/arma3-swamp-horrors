params ["_params", "_posState", "_gameObjectState"];

private _chunkSize = _params get "_chunkSize";

private _group = _gameObjectState get "_group";

private _groupWorldPos = getPos (leader _group);
private _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
private _unitGameObjectArray = [_group] call fn_objectGetGroupUnits;
private _vehicleGameObjectArray = [_group] call fn_objectGetGroupVehicleArray;

_posState set ["_groupIndexPos", _groupIndexPos];
_gameObjectState set ["_unitGameObjectArray", _unitGameObjectArray];
_gameObjectState set ["_vehicleGameObjectArray", _vehicleGameObjectArray];
