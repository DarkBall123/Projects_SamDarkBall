if (!hasInterface) exitWith {};

private _duration = 1.4;
missionNamespace setVariable ["kvn_noImageUntil", time + _duration];

private _bg = uiNamespace getVariable ["kvn_NoImage_BG", controlNull];
if (!isNull _bg) then {
	_bg ctrlShow true;
	_bg ctrlCommit 0;
};

private _text = uiNamespace getVariable ["kvn_NoImage_Text", controlNull];
if (!isNull _text) then {
	_text ctrlShow true;
	_text ctrlCommit 0;
};

private _linkText = uiNamespace getVariable ["kvn_BL_Link", controlNull];
if (!isNull _linkText) then {
	_linkText ctrlSetText "no-link";
};

private _rxText = uiNamespace getVariable ["kvn_BL_Rx", controlNull];
if (!isNull _rxText) then {
	_rxText ctrlSetText "RXg: 0";
};

private _txText = uiNamespace getVariable ["kvn_BL_Tx", controlNull];
if (!isNull _txText) then {
	_txText ctrlSetText "TXg: 0";
};

private _percentText = uiNamespace getVariable ["kvn_RB_Percent", controlNull];
if (!isNull _percentText) then {
	_percentText ctrlSetText "0 %";
};

private _oldFilm = missionNamespace getVariable ["kvn_noImageFilmGrain", -1];
if (_oldFilm >= 0) then {
	ppEffectDestroy _oldFilm;
	missionNamespace setVariable ["kvn_noImageFilmGrain", -1];
};

private _film = ppEffectCreate ["FilmGrain", 2000];
if (_film >= 0) then {
	_film ppEffectAdjust [1,0,0,1.03,1.05,true];
	_film ppEffectCommit 0;
	_film ppEffectEnable true;
	missionNamespace setVariable ["kvn_noImageFilmGrain", _film];

	[_film, time + _duration] spawn {
		params ["_film", "_endTime"];

		sleep ((_endTime - time) max 0);

		if (_film == (missionNamespace getVariable ["kvn_noImageFilmGrain", -1])) then {
			ppEffectDestroy _film;
			missionNamespace setVariable ["kvn_noImageFilmGrain", -1];
		};
	};
};
