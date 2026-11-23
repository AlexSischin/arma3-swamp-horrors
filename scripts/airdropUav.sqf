private _delay = 1;

LCX_airdropUavUsed = false;
publicVariable "LCX_airdropUavUsed";

private _subject = objNull;
private _itemId = -1;
while {!LCX_airdropUavUsed} do {
    sleep _delay;

    private _newSubject = leader playerGroup;
    if !(_newSubject isEqualTo _subject) then {
        if !(isNull _subject) then {
            [_subject, _itemId] call BIS_fnc_removeCommMenuItem;
            _itemId = -1;
        };
        _subject = _newSubject;
    };

    if (isNull _subject) then {};

    if (_itemId == -1) then {
        _itemId = [_subject, "LCX_RequestSupport", nil, nil, ""]
            call BIS_fnc_addCommMenuItem;
    };
};

if (!(isNull _subject) && (_itemId != -1)) then {
    [_subject, _itemId] call BIS_fnc_removeCommMenuItem;
};
