params ["_params", "_posState", "_gameObjectState"];

private _chunkSize = _params get "_chunkSize";
private _side = _params get "_side";
private _housePosWeight = _params get "_housePosWeight";
private _roadPosWeight = _params get "_roadPosWeight";
private _otherPosWeight = _params get "_otherPosWeight";
private _unitArray = _params get "_unitArray";
private _groupIndexPos = _posState get "_groupIndexPos";
private _unitStateArray = _gameObjectState get "_unitStateArray";

private _group = createGroup [_side, true];
_gameObjectState set ["_group", _group];
private _groupDir = random 360;
_group setFormDir _groupDir;

private _groupWorldPos = [_groupIndexPos, _chunkSize, _housePosWeight, _roadPosWeight, _otherPosWeight] call fn_chunkSelectRandomWorldPos;
private _nUnits = count _unitArray;
for [{private _u = 0}, {_u < _nUnits}, {_u = _u + 1}] do {
    private _unit = _unitArray select _u;
    private _unitState = _unitStateArray select _u;

    private _unitAlive = _unitState select 1;
    if (_unitAlive) then {
        private _unitPos = [_groupWorldPos, _nUnits, 0] call fn_groupFindSafePos;
        private _unitGameObject = _group createUnit [_unit, _unitPos, [], 0, "NONE"];
        _unitGameObject setDir _groupDir;
        _unitState set [0, _unitGameObject];
    };
};
