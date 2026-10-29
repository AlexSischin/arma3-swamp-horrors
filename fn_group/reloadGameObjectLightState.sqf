params ["_params", "_posState", "_gameObjectState"];

private _unitStateArray = _gameObjectState get "_unitStateArray";
for [{private _u = 0}, {_u < count _unitStateArray}, {_u = _u + 1}] do {
    private _unitState = _unitStateArray select _u;

    private _unitAlive = _unitState select 1;
    if (_unitAlive) then {
        private _unitGameObject = _unitState select 0;
        if !(alive _unitGameObject) then {
            _unitState set [1, false];
        };
    };
};

private _group = _gameObjectState get "_group";
private _leader = leader _group;
if (isNil "_leader") exitWith {};

private _groupWorldPos = getPos _leader;
private _chunkSize = _params get "_chunkSize";
private _groupIndexPos = [_groupWorldPos, _chunkSize] call fn_chunkGetIndexForPos;
_posState set ["_groupIndexPos", _groupIndexPos];
