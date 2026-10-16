// Expected x range: [0, +inf); otherwise y = 0.
// Expected k range: (0, +inf); otherwise y = 0.
// Possible y range: [0, 1).
// y tends to 1. k affects how fast y tends.
// dy/dx is monotonically decreasing.
params ["_x_", "_k"];

if (_x_ < 0) exitWith {0};
if (_k <= 0) exitWith {0};

// y=\frac{2}{1+e^{\left(c\cdot-x\right)}}-1
2 / (1 + exp(_k * -_x_)) - 1
