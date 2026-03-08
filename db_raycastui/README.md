# DB Raycast UI

Мини-игра для Arma 3, которая рендерит псевдо-3D сцену полностью через fullscreen `createDialog` и заранее созданные UI-колонки.

## Запуск

После упаковки addon вызывай:

```sqf
["demo_01", "MEDIUM", false] call DB_fnc_rui_startGame;
```

Аргументы:

- `mapId`: `"demo_01"` или `"demo_02"`
- `quality`: `"LOW"`, `"MEDIUM"`, `"HIGH"`
- `debug`: `true/false`

Управление в мини-игре:

- `W/S` или `Up/Down`: движение
- `A/D` или `Left/Right`: поворот
- `Space` или `LMB`: огонь
- `R`: рестарт уровня
- `F1`: debug overlay
- `X` или `Esc`: выход

## Ассеты

SVG-исходники лежат прямо в addon:

- `data/walls/*/source.svg`
- `data/ui/weapon/blaster.svg`
- `data/ui/logo/doomcard.svg`

Сборка промежуточных ассетов:

```bash
python3 db_raycastui/tools/build_assets.py
```

Что делает скрипт:

- рендерит `SVG -> PNG`
- делает source/runtime `JPG`
- режет стены на `64` вертикальных runtime-слайса

Текущий runtime addon уже настроен на `.paa`.

`JPG` и `PNG` в репозитории остаются как исходники и промежуточные файлы для пересборки.

Если у тебя установлен Arma 3 Tools, можно отдельно прогнать helper:

```bash
IMAGE_TO_PAA=/path/to/ImageToPAA.exe ./db_raycastui/tools/build_paa.sh
```

Скрипт положит `.paa` прямо рядом с runtime-ассетами addon:

- `data/ui/**/*.paa`
- `data/walls/<type>/<type>.paa`
- `data/walls/<type>/jpg/slice_XX.paa`
