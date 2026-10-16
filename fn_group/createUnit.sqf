params ["_group", "_pos", "_class"];

_unit = _group createUnit [_class, _pos, [], 0, "NONE"];
_unit hideObject true;
_unit enableSimulationGlobal false;
[_unit, "ALL"] remoteExec ["disableAI", 0, true];
_unit
