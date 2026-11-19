params [
    ["_cargo", objNull, [objNull]],
    ["_actionRadius", 10, 0],
    ["_vehicleRaius", 10, 0]
];

if (isNull _cargo) exitWith {};

_cargo addAction [
    "Load into vehicle",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _arguments params ["_vehicleRaius"];

        private _allVehicles = nearestObjects [
            _target,
            ["LandVehicle", "Air", "Ship"],
            _vehicleRaius,
            true
        ];

        private _cargoVehicles = _allVehicles
            select {_x != _target}
            select {alive _x}
            select {vehicleCargoEnabled _x};
        if (_cargoVehicles isEqualTo []) exitWith {
            hint "No suitable vehicle nearby";
        };

        private _fittingCargoVehicles = _cargoVehicles
            select {(_x canVehicleCargo _target) # 1};
        if (_fittingCargoVehicles isEqualTo []) exitWith {
            hint "Vehicle has too small cargo space";
        };

        private _availableCargoVehicles = _fittingCargoVehicles
            select {(_x canVehicleCargo _target) # 0};
        if (_availableCargoVehicles isEqualTo []) exitWith {
            hint "Vehicle has another cargo and has not enough space left";
        };

        private _vehicle = _availableCargoVehicles select 0;
        _vehicle setVehicleCargo _target;
    },
    [_vehicleRaius],
    6,
    true,
    true,
    "",
    "isNull isVehicleCargo _target",
    _actionRadius
];
