params ["_vehicle"];

private _damage = damage _vehicle;
private _hitPointsDamage = getAllHitPointsDamage _vehicle;
private _fuel = fuel _vehicle;
private _fuelCargo = getFuelCargo _vehicle;
private _ammoCargo = getAmmoCargo _vehicle;
private _repairCargo = getRepairCargo _vehicle;
private _weaponsCargo = weaponsItemsCargo [_vehicle, true];
private _magazinesCargo = magazinesAmmoCargo _vehicle;
private _itemsCargo = getItemCargo _vehicle;
private _backpacksCargo = getBackpackCargo _vehicle;

private _state = createHashMap;
_state set ["_damage", _damage];
_state set ["_hitPointsDamage", _hitPointsDamage];
_state set ["_fuel", _fuel];
_state set ["_fuelCargo", _fuelCargo];
_state set ["_ammoCargo", _ammoCargo];
_state set ["_repairCargo", _repairCargo];
_state set ["_weaponsCargo", _weaponsCargo];
_state set ["_magazinesCargo", _magazinesCargo];
_state set ["_itemsCargo", _itemsCargo];
_state set ["_backpacksCargo", _backpacksCargo];
_state
