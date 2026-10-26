params ["_params", "_posState", "_gameObjectState", "_migrationState"];

private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _nHops = _migrationState get "_nHops";

if (_nHops <= 0) exitWith {};

private _chunkSize = _params get "_chunkSize";

private _groupIndexPos = _posState get "_groupIndexPos";
private _group = _gameObjectState get "_group";

private _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
private _unitGameObjectArray = units _group;
private _nUnits = count _unitGameObjectArray;
for [{private _u = 0}, {_u < _nUnits}, {_u = _u + 1}] do {
    private _unitGameObject = _unitGameObjectArray select _u;

    private _unitPos = [_groupWorldPos, _nUnits, 0] call fn_groupFindSafePos;
    _unitGameObject setPos _unitPos;
};
