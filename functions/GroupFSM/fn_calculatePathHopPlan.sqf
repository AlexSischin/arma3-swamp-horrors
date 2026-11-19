params ["_time", "_speedKmH", "_chunkSize"];

private _speedMpS = _speedKmH / 3.6;
private _timePerHop = _chunkSize / _speedMpS;
private _nHops = floor (_time / _timePerHop);
private _timeRemaining = _time - (_timePerHop * _nHops);
[_nHops, _timeRemaining]
