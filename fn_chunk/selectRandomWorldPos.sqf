params [
	["_chunkIndex", nil],
	["_chunkSize", nil],
	["_housePosWeight", 0],
	["_roadPosWeight", 0],
	["_otherPosWeight", 0]
];

private _chunkCenter = [_chunkIndex, _chunkSize] call fn_chunkGetPosForIndex;
if (_housePosWeight > 0 || _roadPosWeight > 0 || _otherPosWeight > 0) then {
	private _housePosType = "house";
	private _roadPosType = "road";
	private _otherPosType = "other";
	private _posType = selectRandomWeighted [
		_housePosType, _housePosWeight,
		_roadPosType, _roadPosWeight,
		_otherPosType, _otherPosWeight
	];
	private _chunkCcr = _chunkSize * sqrt(2) / 2;

	private _pos = nil;

	if (_posType == _housePosType) then {
		private _nearHouses = nearestObjects [_chunkCenter, ["house"], _chunkCcr, true];
		if (count _nearHouses > 0) then {
			private _nearHouse = selectRandom _nearHouses;
			private _nearHousePositions = [_nearHouse] call BIS_fnc_buildingPositions;
			if (count _nearHousePositions > 0) then {
				_pos = selectRandom _nearHousePositions;
			};
		};
	};
	if !(isNil "_pos") exitWith {_pos};

	if (_posType == _roadPosType) then {
		private _nearRoads = _chunkCenter nearRoads _chunkCcr;
		if (count _nearRoads > 0) then {
			private _nearRoad = selectRandom _nearRoads;
			_pos = getPos _nearRoad;
		};
	};
	if !(isNil "_pos") exitWith {_pos};
};

_pos = [
    (_chunkCenter select 0) + ((random _chunkSize) - (_chunkSize / 2)),
    (_chunkCenter select 1) + ((random _chunkSize) - (_chunkSize / 2)),
    0
];
_pos
