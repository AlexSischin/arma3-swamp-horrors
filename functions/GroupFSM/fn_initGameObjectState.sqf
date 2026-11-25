params ["_params"];

private _group = _params get "_group";

private _gameObjectState = createHashMap;
_gameObjectState set ["_group", _group];

private _unitGameObjectArray = [_group] call LCX_fnc_getGroupUnits;
_gameObjectState set ["_unitGameObjectArray", _unitGameObjectArray];

private _vehicleGameObjectArray = [_group] call LCX_fnc_getGroupVehicleArray;
_gameObjectState set ["_vehicleGameObjectArray", _vehicleGameObjectArray];

_gameObjectState
