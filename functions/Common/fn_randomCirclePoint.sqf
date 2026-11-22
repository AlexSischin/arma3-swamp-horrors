params [
    ["_radius", 1],
    ["_center", [0, 0]]
];

private _r = sqrt random 1;
private _a = random 360;

[
    (_center # 0) + _radius * (_r * sin _a),
    (_center # 1) + _radius * (_r * cos _a)
]
