if (!hasInterface) exitWith { false };

if (missionNamespace getVariable ["DZ_ambientSoundStarted", false]) exitWith { true };
missionNamespace setVariable ["DZ_ambientSoundStarted", true];

[] spawn
{
    waitUntil { time > 0 };

    while { hasInterface } do
    {
        private _soundSource = playSound "DZ_SoundAmbience";

        if (_soundSource isEqualType objNull) then
        {
            private _timeoutAt = time + 260;
            waitUntil
            {
                sleep 0.5;
                !hasInterface || { isNull _soundSource } || { time >= _timeoutAt }
            };
        }
        else
        {
            sleep 255;
        };
    };
};

true
