private _mineFields = [
    "side_right",
    "side_left",
    "side_top",
    "side_bottom"
];
private _mineFreeZones = [
    "mine_free_zone"
];
private _className = "APERSBoundingMine";
private _radius = 50;
private _spawnRadius = 20;
private _nMines = 10;

[_mineFields, _mineFreeZones, _className, _radius, _spawnRadius, _nMines] call fn_objectMinefield;
