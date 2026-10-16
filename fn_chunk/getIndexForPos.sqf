params ["_pos", "_chunkSize"];

[
    floor ((_pos select 0) / _chunkSize),
    floor ((_pos select 1) / _chunkSize)
]
