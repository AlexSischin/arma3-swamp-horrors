params ["_chunkIndex", "_chunkSize"];

[
    ((_chunkIndex # 0) * _chunkSize) + (_chunkSize / 2),
    ((_chunkIndex # 1) * _chunkSize) + (_chunkSize / 2)
]
