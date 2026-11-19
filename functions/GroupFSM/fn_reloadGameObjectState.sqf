params ["_params", "_posState", "_gameObjectState"];


private _group = _gameObjectState get "_group";

private _unitGameObjectArray = [_group] call LCX_fnc_getGroupUnits;
_gameObjectState set ["_unitGameObjectArray", _unitGameObjectArray];
private _vehicleGameObjectArray = [_group] call LCX_fnc_getGroupVehicleArray;
_gameObjectState set ["_vehicleGameObjectArray", _vehicleGameObjectArray];

private _leader = leader _group;
if (isNil "_leader") exitWith {};

private _groupWorldPos = getPos _leader;
private _chunkSize = _params get "_chunkSize";
private _groupIndexPos = [_groupWorldPos, _chunkSize] call LCX_fnc_getIndexForPos;
_posState set ["_groupIndexPos", _groupIndexPos];
