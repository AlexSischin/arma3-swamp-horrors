params ["_vehicle", "_state"];

private _damage = _state get "_damage";
private _hitPointsDamage = _state get "_hitPointsDamage";
private _fuel = _state get "_fuel";
private _fuelCargo = _state get "_fuelCargo";
private _ammoCargo = _state get "_ammoCargo";
private _repairCargo = _state get "_repairCargo";
private _weaponsCargo = _state get "_weaponsCargo";
private _magazinesCargo = _state get "_magazinesCargo";
private _itemsCargo = _state get "_itemsCargo";
private _backpacksCargo = _state get "_backpacksCargo";

_vehicle setDamage _damage;

if (count _hitPointsDamage >= 3) then {
	private _hitpointNames = _hitPointsDamage select 0;
	private _selectionNames = _hitPointsDamage select 1;
	private _damageValues = _hitPointsDamage select 2;

	for [{private _d = 0}, {_d < count _damageValues}, {_d = _d + 1}] do {
		private _hitpointName = _hitpointNames select _d;
		private _selectionName = _selectionNames select _d;
		private _damageValue = _damageValues select _d;
		if (_hitpointName != "") then {
			_vehicle setHitPointDamage [_hitpointName, _damageValue];
		};
		if (_selectionName != "") then {
			_vehicle setHit [_selectionName, _damageValue];
		};
	};
};

_vehicle setFuel _fuel;

_vehicle setFuelCargo _fuelCargo;

_vehicle setAmmoCargo _ammoCargo;

_vehicle setRepairCargo _repairCargo;

clearWeaponCargoGlobal _vehicle;
for [{private _c = 0}, {_c < count _weaponsCargo}, {_c = _c + 1}] do {
	private _weaponsCargoElem = _weaponsCargo select _c;
	_vehicle addWeaponWithAttachmentsCargoGlobal [_weaponsCargoElem, 1];
};

clearMagazineCargoGlobal _vehicle;
for [{private _c = 0}, {_c < count _magazinesCargo}, {_c = _c + 1}] do {
	private _magazinesCargoElem = _magazinesCargo select _c;
	private _magazinesCargoElemClass = _magazinesCargoElem select 0;
	private _magazinesCargoElemAmmo = _magazinesCargoElem select 1;
    _vehicle addMagazineAmmoCargo [_magazinesCargoElemClass, 1, _magazinesCargoElemAmmo];
};

clearItemCargoGlobal _vehicle;
private _itemsCargoClasses = _itemsCargo select 0;
private _itemsCargoCounts = _itemsCargo select 1;
for [{private _c = 0}, {_c < count _itemsCargoClasses}, {_c = _c + 1}] do {
	private _itemsCargoClass = _itemsCargoClasses select _c;
	private _itemsCargoCount = _itemsCargoCounts select _c;
	_vehicle addItemCargoGlobal [_itemsCargoClass, _itemsCargoCount];
};

clearBackpackCargoGlobal _vehicle;
private _backpacksCargoClasses = _backpacksCargo select 0;
private _backpacksCargoCounts = _backpacksCargo select 1;
for [{private _c = 0}, {_c < count _backpacksCargoClasses}, {_c = _c + 1}] do {
	private _backpacksCargoClass = _backpacksCargoClasses select _c;
	private _backpacksCargoCount = _backpacksCargoCounts select _c;
	_vehicle addBackpackCargoGlobal [_backpacksCargoClass, _backpacksCargoCount];
};
