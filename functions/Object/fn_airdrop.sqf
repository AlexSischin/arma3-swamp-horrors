
if (missionNamespace getVariable ["airdrop_active", false]) exitWith {
    hint "Airdrop already in progress!";
};

missionNamespace setVariable ["airdrop_active", true];

[] spawn {

    // CONFIGURATION
    private _heliClass = "RHS_C130J_Cargo";

    private _spawnPos = getMarkerPos "heli_spawn";
    private _dropPos = getMarkerPos "drop_zone";

    private _flightHeight = 150;
    private _dropDistance = 250;

    // SPAWN HELICOPTER
    private _heli = createVehicle [
        _heliClass,
        [_spawnPos select 0, _spawnPos select 1, _flightHeight],
        [],
        0,
        "FLY"
    ];
    _heli setVehicleCargo supplyBox;

    // CREATE AI CREW
    createVehicleCrew _heli;

    private _group = group (driver _heli);

    _heli flyInHeight _flightHeight;
    _heli setSpeedMode "FULL";

    // WAYPOINT TO DROP ZONE
    private _wp = _group addWaypoint [_dropPos, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointCompletionRadius 75;

    hint "Airdrop helicopter dispatched!";

    // WAIT UNTIL HELICOPTER REACHES DROP ZONE
    waitUntil {
        sleep 1;

        !alive _heli ||
        (_heli distance2D _dropPos < _dropDistance)
    };

    if (!alive _heli) exitWith {
        missionNamespace setVariable ["airdrop_active", false];
    };

    // UNLOAD ALL VEHICLES USING VANILLA VIV
    hint "Unloading all vehicles!";

    private _loadedVehicles = getVehicleCargo _heli;

    if (count _loadedVehicles > 0) then {

        _heli setVehicleCargo objNull;

        hint format [
            "Unloading %1 vehicles!",
            count _loadedVehicles
        ];

    } else {

        hint "No vehicles loaded inside helicopter!";

    };

    // WAIT FOR VEHICLES TO BE RELEASED
    sleep 10;

    // HELICOPTER DEPARTURE
    private _exitPos = [
        (_dropPos select 0) + 1000,
        (_dropPos select 1) + 1000,
        _flightHeight
    ];

    private _exitWP = _group addWaypoint [_exitPos, 0];
    _exitWP setWaypointType "MOVE";

    hint "Helicopter leaving drop zone!";

    // CLEANUP
    sleep 60;

    if (!isNull _heli) then {
        {
            deleteVehicle _x;
        } forEach crew _heli;

        deleteVehicle _heli;
    };

    missionNamespace setVariable ["airdrop_active", false];

    hint "Airdrop mission completed!";
};
