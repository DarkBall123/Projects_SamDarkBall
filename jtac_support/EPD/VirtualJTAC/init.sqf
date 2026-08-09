if (missionNamespace getVariable ["DB_JTAC_RuntimeInitialized", false]) exitWith {
    if (!isDedicated and !(isNil "DB_fnc_jtacRefreshState")) then {
        [] call DB_fnc_jtacRefreshState;
    };
};

missionNamespace setVariable ["DB_JTAC_RuntimeInitialized", true];

call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacsettings.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Projectiles.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\EvenSpread.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Mines.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Bombs.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Rockets.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\GuidedMissile.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\StrafingRun.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\Attacks\Oreshnik.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacattackparser.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacfirecontrol.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacreload.sqf";
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtacmapcontrol.sqf";

// Новый UI
call compile preprocessFileLineNumbers "\jtac_support\EPD\VirtualJTAC\jtac_ui.sqf";

call PARSE_AVAILABLE_JTAC_ATTACKS;

if (isNil "DB_fnc_jtacRegisterSettings") then {
    DB_fnc_jtacRegisterSettings = {
        if (missionNamespace getVariable ["DB_JTAC_SettingsRegistered", false]) exitWith {};

        missionNamespace setVariable ["DB_JTAC_SettingsRegistered", true];

        [
            "EPDJtacAquisitionFixedTime",
            "SLIDER",
            ["Global Lock Time Override", "0 keeps each strike's own acquiring time. Any value above 0 forces the same lock time for every JTAC strike."],
            "JTAC Support",
            [0, 60, 0, 0],
            1,
            {
                missionNamespace setVariable ["EPDJtacAquisitionFixedTime", EPDJtacAquisitionFixedTime, true];
            }
        ] call CBA_fnc_addSetting;

        [
            "EPDJtacAquisitionGlobalModifier",
            "SLIDER",
            ["Global Lock Time Multiplier", "Applies when the override above is set to 0. 1.00 = original timing from jtacsettings.sqf."],
            "JTAC Support",
            [0.1, 10, 1, 2],
            1,
            {
                missionNamespace setVariable ["EPDJtacAquisitionGlobalModifier", EPDJtacAquisitionGlobalModifier, true];
            }
        ] call CBA_fnc_addSetting;

        private _patternCategory = ["JTAC Support", "Орешник: поле поражения"];
        {
            _x call CBA_fnc_addSetting;
        } forEach [
            [
                "DB_JTAC_OreshnikClusterCount",
                "SLIDER",
                ["Количество групп", "Число последовательных групп боевых элементов."],
                _patternCategory,
                [1, 8, 6, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikElementsMin",
                "SLIDER",
                ["Элементов в группе: минимум", "Минимальное число следов и попаданий в одной группе."],
                _patternCategory,
                [1, 10, 4, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikElementsMax",
                "SLIDER",
                ["Элементов в группе: максимум", "Максимальное число следов и попаданий в одной группе."],
                _patternCategory,
                [1, 10, 6, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikPatternLength",
                "SLIDER",
                ["Длина поля", "Продольный размер поля попаданий вдоль направления захода, м."],
                _patternCategory,
                [40, 600, 320, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikPatternWidth",
                "SLIDER",
                ["Ширина поля", "Поперечный размер поля попаданий, м."],
                _patternCategory,
                [0, 300, 80, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikLongitudinalScatter",
                "SLIDER",
                ["Продольный разброс", "Случайное отклонение каждого элемента вдоль поля, м."],
                _patternCategory,
                [0, 40, 8, 1],
                1
            ],
            [
                "DB_JTAC_OreshnikLateralScatter",
                "SLIDER",
                ["Поперечный разброс", "Случайное боковое отклонение каждого элемента, м."],
                _patternCategory,
                [0, 40, 5, 1],
                1
            ],
            [
                "DB_JTAC_OreshnikWaveDelay",
                "SLIDER",
                ["Интервал между группами", "Время между последовательными группами, с."],
                _patternCategory,
                [0, 5, 1.1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikElementDelay",
                "SLIDER",
                ["Интервал внутри группы", "Задержка между соседними элементами одной группы, с."],
                _patternCategory,
                [0, 0.25, 0.015, 3],
                1
            ],
            [
                "DB_JTAC_OreshnikTimingJitter",
                "SLIDER",
                ["Случайная задержка", "Дополнительная случайная задержка каждого элемента, с."],
                _patternCategory,
                [0, 0.5, 0.04, 3],
                1
            ]
        ];

        private _streakCategory = ["JTAC Support", "Орешник: вход и след"];
        {
            _x call CBA_fnc_addSetting;
        } forEach [
            [
                "DB_JTAC_OreshnikEntryAngle",
                "SLIDER",
                ["Угол входа", "Угол траектории к горизонту, градусы."],
                _streakCategory,
                [45, 89, 82, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikStartAltitude",
                "SLIDER",
                ["Расчётная высота старта", "Высота начала полной траектории, м."],
                _streakCategory,
                [500, 20000, 15000, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikFlightDuration",
                "SLIDER",
                ["Расчётное время полёта", "Время полной траектории до обрезки видимого участка, с."],
                _streakCategory,
                [0.5, 10, 4.2, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikDurationJitter",
                "SLIDER",
                ["Разброс времени полёта", "Случайное отклонение времени полёта, с."],
                _streakCategory,
                [0, 1, 0.08, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikVisibleAltitude",
                "SLIDER",
                ["Высота появления", "Высота, с которой след становится видимым, м."],
                _streakCategory,
                [300, 5000, 2200, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikVisibleDuration",
                "SLIDER",
                ["Минимальное время видимого входа", "Нижний предел времени от появления следа до удара, с."],
                _streakCategory,
                [0.5, 5, 0.85, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikStreakScale",
                "SLIDER",
                ["Толщина следа", "Общий масштаб белого ядра, плазмы и световой точки."],
                _streakCategory,
                [0.25, 3, 1.35, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikStreakVariation",
                "SLIDER",
                ["Разброс толщины", "Случайная разница толщины между элементами."],
                _streakCategory,
                [0, 0.5, 0.12, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikTrailLength",
                "SLIDER",
                ["Длина плазменного хвоста", "Приблизительная длина видимого хвоста, м."],
                _streakCategory,
                [40, 500, 260, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikTrailDensity",
                "SLIDER",
                ["Плотность частиц следа", "Множитель количества частиц. Высокие значения сильнее нагружают клиент."],
                _streakCategory,
                [0.25, 2, 1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikLightScale",
                "SLIDER",
                ["Яркость следа", "Множитель света и блика вокруг элемента. 0 отключает источник света."],
                _streakCategory,
                [0, 3, 1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikTracerEnabled",
                "CHECKBOX",
                ["Белый трассер", "Показывать толстое белое ядро класса CfgAmmo."],
                _streakCategory,
                true,
                1
            ],
            [
                "DB_JTAC_OreshnikTrailEnabled",
                "CHECKBOX",
                ["Плазменный след", "Показывать белое ядро частиц и тёплый внешний ореол."],
                _streakCategory,
                true,
                1
            ]
        ];

        private _impactCategory = ["JTAC Support", "Орешник: эффект удара"];
        {
            _x call CBA_fnc_addSetting;
        } forEach [
            [
                "DB_JTAC_OreshnikImpactFlashScale",
                "SLIDER",
                ["Вспышка и осколки", "Масштаб белой вспышки, преломления воздуха и раскалённых частиц."],
                _impactCategory,
                [0, 3, 1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikImpactDustScale",
                "SLIDER",
                ["Пыль", "Масштаб вертикального выброса и приземной пылевой волны."],
                _impactCategory,
                [0, 3, 1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikImpactDustDuration",
                "SLIDER",
                ["Длительность выброса пыли", "Время работы источников пыли после попадания, с."],
                _impactCategory,
                [0.5, 8, 3, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikImpactSparkCount",
                "SLIDER",
                ["Раскалённые частицы", "Количество искр и фрагментов на одно попадание."],
                _impactCategory,
                [0, 60, 20, 0],
                1
            ],
            [
                "DB_JTAC_OreshnikCameraShakeScale",
                "SLIDER",
                ["Сила тряски камеры", "Множитель тряски камеры от кинетического удара."],
                _impactCategory,
                [0, 3, 1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikCameraShakeRadius",
                "SLIDER",
                ["Радиус тряски камеры", "Максимальная дистанция воздействия на камеру, м."],
                _impactCategory,
                [50, 2000, 650, 0],
                1
            ]
        ];

        private _damageCategory = ["JTAC Support", "Орешник: звук и урон"];
        {
            _x call CBA_fnc_addSetting;
        } forEach [
            [
                "DB_JTAC_OreshnikDamageEnabled",
                "CHECKBOX",
                ["Кинетический урон", "Наносить урон объектам рядом с каждым попаданием."],
                _damageCategory,
                true,
                1
            ],
            [
                "DB_JTAC_OreshnikDamageRadius",
                "SLIDER",
                ["Радиус урона", "Радиус урона одного элемента, м."],
                _damageCategory,
                [1, 50, 14, 1],
                1
            ],
            [
                "DB_JTAC_OreshnikMaxDamage",
                "SLIDER",
                ["Максимальный урон", "Добавляемый урон в центре попадания."],
                _damageCategory,
                [0, 0.9, 0.7, 2, true],
                1
            ],
            [
                "DB_JTAC_OreshnikSoundEnabled",
                "CHECKBOX",
                ["Звук", "Включить звук входа и попаданий."],
                _damageCategory,
                true,
                1
            ],
            [
                "DB_JTAC_OreshnikSoundScale",
                "SLIDER",
                ["Громкость попаданий", "Множитель громкости ударов."],
                _damageCategory,
                [0, 3, 1, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikSimulateSoundDelay",
                "CHECKBOX",
                ["Задержка звука", "Задерживать звук попадания с учётом расстояния до игрока."],
                _damageCategory,
                true,
                1
            ],
            [
                "DB_JTAC_OreshnikSoundDelayMax",
                "SLIDER",
                ["Максимальная задержка звука", "Ограничение задержки звука попадания, с."],
                _damageCategory,
                [0, 15, 8, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikFlybyProgress",
                "SLIDER",
                ["Момент пролётного звука", "Доля видимой траектории, после которой звучит пролёт."],
                _damageCategory,
                [0.2, 0.95, 0.7, 2, true],
                1
            ],
            [
                "DB_JTAC_OreshnikFlybyVolume",
                "SLIDER",
                ["Громкость пролёта", "Множитель громкости звука пролёта."],
                _damageCategory,
                [0, 3, 1.25, 2],
                1
            ],
            [
                "DB_JTAC_OreshnikFlybyDistance",
                "SLIDER",
                ["Дальность пролётного звука", "Максимальная дистанция слышимости пролёта, м."],
                _damageCategory,
                [500, 8000, 4500, 0],
                1
            ]
        ];
    };
};

call DB_fnc_jtacRegisterSettings;

// ====================== ИНИЦИАЛИЗАЦИЯ ПЕРЕМЕННОЙ КЛАВИШИ ======================
if (isNil "JTAC_KeyCode") then {
    JTAC_KeyCode = 35; // H по умолчанию
};

if (!isDedicated) then {
    JtacAvailable = true;
    JtacIncomingAngle = "RANDOM";
    JtacTargetingMethod = "LASER";

    waitUntil {sleep 0.5; !(isNull player)};
    [] call DB_fnc_jtacRefreshState;

    // ====================== CBA KEYBIND (с переменной) ======================
    if !(missionNamespace getVariable ["DB_JTAC_KeybindRegistered", false]) then {
        missionNamespace setVariable ["DB_JTAC_KeybindRegistered", true];

        [
            "JTAC Support",
            "JTAC_OpenMenu",
            ["Open JTAC Support Menu", "Открыть меню запроса поддержки JTAC"],
            {
                if (([] call DB_fnc_jtacRefreshState) && {JtacAvailable}) then {
                    [] call JTAC_OpenMainUI;
                };
            },
            {},
            [JTAC_KeyCode, [false, false, false]],
            (false)
        ] call CBA_fnc_addKeybind;
    };

    // ====================== Respawn ======================
    if !(missionNamespace getVariable ["DB_JTAC_RespawnHandlerRegistered", false]) then {
        missionNamespace setVariable ["DB_JTAC_RespawnHandlerRegistered", true];

        player addEventHandler ["Respawn", {
            params ["_unit"];
            [_unit] call DB_fnc_jtacRefreshState;
            JtacAvailable = true;
        }];
    };
};
