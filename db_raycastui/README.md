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
- делает runtime `JPG`
- режет стены на `64` вертикальных runtime-слайса

`ImageToPAA` в текущем окружении не найден, поэтому репозиторий держит рабочий `SVG -> PNG -> JPG/slices` пайплайн.

Если у тебя установлен Arma 3 Tools, можно отдельно прогнать helper:

```bash
IMAGE_TO_PAA=/path/to/ImageToPAA.exe ./db_raycastui/tools/build_paa.sh
```

Скрипт сложит `.paa`-версии в `data/**/paa/`.
