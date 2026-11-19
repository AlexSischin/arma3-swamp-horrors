params ["_gameObjectState"];

private _unitStateArray = _gameObjectState get "_unitStateArray";
for [{private _u = 0}, {_u < count _unitStateArray}, {_u = _u + 1}] do {
    private _unitState = _unitStateArray select _u;

    private _unitAlive = _unitState select 1;
    if (_unitAlive) then {
        private _unitGameObject = _unitState select 0;
        deleteVehicle _unitGameObject;
        _unitState set [0, nil];
    };
};

private _group = _gameObjectState get "_group";
deleteGroup _group;
_gameObjectState set ["_group", nil];
