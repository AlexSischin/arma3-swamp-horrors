params ["_group"];

_units = (units _group)
    select {alive _x};
_units
