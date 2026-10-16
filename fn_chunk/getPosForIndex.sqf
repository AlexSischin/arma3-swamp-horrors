params ["_chunkIndex", "_chunkSize"];

[
    ((_chunkIndex select 0) * _chunkSize) + (_chunkSize / 2),
    ((_chunkIndex select 1) * _chunkSize) + (_chunkSize / 2)
]
