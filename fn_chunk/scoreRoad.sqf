params ["_pos", "_radius"];

private _nearRoads = _pos nearRoads _radius;

if (count _nearRoads > 0) then {
    1
} else {
    0
};
