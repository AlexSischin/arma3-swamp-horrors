params ["_group"];

private _vehicles = (units _group)
    select {alive _x}
    select {vehicle _x != _x}
    apply {vehicle _x};
_vehicles = _vehicles arrayIntersect _vehicles;
_vehicles
