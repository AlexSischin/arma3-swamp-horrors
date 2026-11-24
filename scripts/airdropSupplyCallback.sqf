params ["_caller", "_pos", "_target", "_is3D", "_id"];

if !(_pos inArea "airdrop_zone") exitWith {
    "Target point is out of boundary. Choose a target closer to the map center." remoteExec ["hint", _caller];
};

if (LCX_airdropUavUsed) exitWith {};
LCX_airdropUavUsed = true;
publicVariable "LCX_airdropUavUsed";

private _flyHeight = 300;
private _startPos = [1024, -1000, _flyHeight];
private _targetPos = _pos;
_targetPos set [2, _flyHeight];
private _finishPos = [1024, 3000, _flyHeight];
private _vehicleClass = "rhsusf_CH53e_USMC_cargo";

supplyBox enableSimulationGlobal true;
supplyBox hideObject false;
private _cargoArray = [supplyBox];

[_startPos, _targetPos, _finishPos, _vehicleClass, _cargoArray] call LCX_fnc_airdrop;
