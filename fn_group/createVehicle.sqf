params ["_pos", "_class"];

private _vehicle = createVehicle [_class, _pos, [], 0, "NONE"];
_vehicle hideObject true;
_vehicle enableSimulationGlobal false;
_vehicle
