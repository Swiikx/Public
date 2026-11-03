# <nom-du-projet>

<Une ou deux phrases : ce que fait le projet et pour qui.>

## Stack

- Python `>= 3.11`
- Ruff (lint + format), pytest
- Packaging : hatchling, layout `src/`

## Arbo

```
<nom-du-projet>/
├── pyproject.toml          # deps, config ruff et pytest
├── src/mon_projet/
│   ├── __init__.py
│   └── cli.py              # point d'entrée CLI
├── tests/
│   └── test_cli.py
├── .env.example
└── Makefile
```

## Démarrage

```bash
make install        # crée .venv et installe le projet en editable
make check          # lint + tests
.venv/bin/mon-projet Ada
```

## Commandes

| Commande | Effet |
|---|---|
| `make install` | Crée `.venv` et installe `-e ".[dev]"` |
| `make lint` | `ruff check` + `ruff format --check` |
| `make fmt` | Formate et corrige ce qui est auto-corrigeable |
| `make test` | pytest |
| `make check` | lint + tests (ce que fait la CI) |
| `make clean` | Supprime venv, caches et artefacts de build |

## Configuration

Les variables d'environnement attendues sont listées dans `.env.example`. Copier en `.env` (ignoré par git) et renseigner.

| Variable | Défaut | Description |
|---|---|---|
| `LOG_LEVEL` | `INFO` | Niveau de log |

## À renommer après copie du template

- `name` et `[project.scripts]` dans `pyproject.toml`
- le dossier `src/mon_projet/` et les imports correspondants
- `packages` dans `[tool.hatch.build.targets.wheel]`
