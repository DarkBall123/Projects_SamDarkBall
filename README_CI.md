# CI (SQF + Config validation)

## Local run
```bash
python3 tools/sqf_validator.py --config tools/ci_config.json
python3 tools/config_style_checker.py --config tools/ci_config.json
python3 tools/sqf_cba_patterns_test.py --root . --addon vnd_main
```

Tuning
- Edit tools/ci_config.json:
- include paths
- exclude_globs
- enable/disable semicolon heuristic

---

## 9) Acceptance Criteria (критерии готовности)
1) После мержа файлов, GitHub Actions автоматически стартует на push/PR.
2) При наличии `\t` в `.sqf/.hpp/.cpp` CI падает.
3) При явном дисбалансе `{}` / `()` / `[]` CI падает.
4) В логах есть строки вида `ERROR path/to/file:LINE: message`.
5) Скрипты запускаются локально без зависимостей (кроме Python3).
