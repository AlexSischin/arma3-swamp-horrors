
params [
    ["_mineFields", []],
    ["_mineFreeZones", []],
    ["_className", "APERSMine"],
    ["_radius", 50],
    ["_spawnRadius", 20],
    ["_nMines", 5],
    ["_passiveCheckDelay", 10],
    ["_activeCheckDelay", 1],
    ["_markersEnabled", false]
];

private _spawnedMines = [];

while {true} do {

    private _allSubjects = [] call LCX_fnc_getRenderSubjects;

    // Get subjects inside any of the specified markers
    private _activeSubjects = _allSubjects select {
        private _subject = _x;

        alive _subject
        && {
            (_mineFields findIf {_subject inArea _x} >= 0)
            && {_mineFreeZones findIf {_subject inArea _x} == -1}
        }
    };

    // Remove mines that are no longer within radius of any active subject
    private _minesToDelete = _spawnedMines select {
        private _mine = _x;

        isNull _mine ||
        {
            _activeSubjects findIf {
                _mine distance2D _x <= _radius
            } < 0
        }
    };

    {
        if (!isNull _x) then {
            deleteVehicle _x;
        };
    } forEach _minesToDelete;

    // Remove deleted mines from tracking array
    _spawnedMines = _spawnedMines - _minesToDelete;

    if (count _activeSubjects > 0) then {

        {
            private _subject = _x;

            // Count tracked mines around this subject
            private _existingMines = _spawnedMines select {
                _x distance2D _subject <= _radius
            };

            private _mineCount = count _existingMines;

            // Spawn missing mines
            if (_mineCount < _nMines) then {

                private _missingMines = _nMines - _mineCount;

                for [{private _i = 0}, {_i < _missingMines}, {_i = _i + 1}] do {

                    // Random position within the specified radius range
                    private _angle = (getDir _subject) + random [-180, 0, 180];

                    private _distance = _spawnRadius +
                        random (_radius - _spawnRadius);

                    private _subjectPos = getPosATL _subject;

                    private _spawnPos = [
                        (_subjectPos select 0) +
                            (sin _angle * _distance),

                        (_subjectPos select 1) +
                            (cos _angle * _distance),

                        0
                    ];

                    private _mine = createMine [_className, _spawnPos, [], 0];
                    _spawnedMines pushBack _mine;
                };
            };

        } forEach _activeSubjects;

        // Active monitoring
        sleep _activeCheckDelay;

    } else {

        // No subjects in any mine field
        sleep _passiveCheckDelay;
    };

    if (_markersEnabled) then {
        {[_x, "ColorRed", "loc_mine", 1] call LCX_fnc_visualizeObject} forEach _spawnedMines;
    };
};
