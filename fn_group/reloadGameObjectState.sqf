params ["_params", "_posState", "_gameObjectState"];


private _group = _gameObjectState get "_group";

private _unitGameObjectArray = [_group] call fn_objectGetGroupUnits;
_gameObjectState set ["_unitGameObjectArray", _unitGameObjectArray];
private _vehicleGameObjectArray = [_group] call fn_objectGetGroupVehicleArray;
_gameObjectState set ["_vehicleGameObjectArray", _vehicleGameObjectArray];

private _leader = leader _group;
if (isNil "_leader") exitWith {};

if (!(alive _leader) && (count _unitGameObjectArray > 0)) then {
    _leader = _unitGameObjectArray select 0;
};
private _groupWorldPos = getPos _leader;
private _chunkSize = _params get "_chunkSize";
private _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
_posState set ["_groupIndexPos", _groupIndexPos];
