// Possible y range: [0, 1).
// y tends to 1.
// k affects how fast y tends.
// h sets the x for the central point.
// v sets the y for the central point.
params [
    ["_x_", 0],
    ["_k", 1],
    ["_h", 0],
    ["_v", 0]
];

// y=\max\left(\min\left(\frac{2-2v}{1+e^{\left(k\cdot\left(h-x\right)\right)}}-\left(1-2v\right),\ 1\right),0\right)
(1 min (0 max (2 / (1 + exp(_k * (_h - _x_))) - 1)))
