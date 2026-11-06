params ["_hashMap", "_weightFn"];

private _weighted = [];
{
    _weighted pushBack _y;
    _weighted pushBack (_y call _weightFn);
} forEach _hashMap;
selectRandomWeighted _weighted;
