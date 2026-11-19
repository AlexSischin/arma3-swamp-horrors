private _allUavs = allUnitsUAV;
private  _controlledUavs = [];
for [{private _u = 0}, {_u < count _allUavs}, {_u = _u + 1}] do {
	private _uav = _allUavs select _u;

	private _uavControl = UAVControl _uav;
	private _uavControlCount = floor((count _uavControl) / 2);
	for [{private _c = 0}, {_c < _uavControlCount}, {_c = _c + 1}] do {

		private _uavControlUnit = _uavControl select (_c * 2);
		if !(isNull _uavControlUnit) then {
			_controlledUavs pushBack _uav;
			break;
		};
	};
};
_controlledUavs;
