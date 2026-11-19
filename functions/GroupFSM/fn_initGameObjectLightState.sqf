params ["_params"];

private _gameObjectState = createHashMap;
_gameObjectState set ["_group", nil];

private _unitArray = _params get "_unitArray";
private _unitInitState = [nil, true];
private _unitStateArray = [];
_unitStateArray resize [count _unitArray, _unitInitState];
_unitStateArray = + _unitStateArray;
_gameObjectState set ["_unitStateArray", _unitStateArray];

_gameObjectState
