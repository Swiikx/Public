# Templates

Squelettes à copier pour démarrer un lab ou un projet, et workflows CI prêts à brancher.

```bash
cp -r templates/project-python projects/mon-projet
```

## Squelettes de projet

| Template | Pour quoi | Contient |
|---|---|---|
| [`project-terraform/`](project-terraform/) | Infra as code | `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars.example`, `.tflint.hcl`, `Makefile` |
| [`project-python/`](project-python/) | Scripts, CLI, API | `pyproject.toml` (ruff + pytest), `src/`, `tests/`, `Makefile`, `.env.example` |
| [`project-node/`](project-node/) | Outils JS/TS, API Node | `package.json`, `src/index.js`, `.env.example` |
| [`project-docker/`](project-docker/) | Service conteneurisé, homelab | `Dockerfile`, `compose.yaml`, `.env.example` |

## Squelettes de document

| Template | Pour quoi |
|---|---|
| [`compte-rendu-tp/`](compte-rendu-tp/) | Compte rendu de TP — objectif, démarche, résultat, ce qui a coincé |
| [`writeup-securite/`](writeup-securite/) | Write-up de lab ou CTF — reconnaissance, exploitation, remédiation |

## Workflows CI

Les fichiers de [`ci/`](ci/) ne tournent **pas** depuis `templates/` : GitHub Actions ne lit que `.github/workflows/` à la racine.

```bash
cp templates/ci/python.yml .github/workflows/mon-projet-ci.yml
```

Puis remplacer les trois occurrences de `CHEMIN/DU/PROJET` dans le fichier copié (filtre `paths`, `working-directory`, nom du workflow). Sans ce filtre, le workflow se déclenche à chaque commit du dépôt, y compris sur des fichiers qui ne le concernent pas.

| Workflow | Fait quoi |
|---|---|
| [`terraform.yml`](ci/terraform.yml) | `fmt` → `validate` → TFLint → Checkov → `plan` + artefact |
| [`python.yml`](ci/python.yml) | Ruff (lint + format) → pytest, sur 3.11 et 3.12 |
| [`node.yml`](ci/node.yml) | `npm ci` → lint → test → build |
| [`docker.yml`](ci/docker.yml) | Build de l'image, Hadolint, scan Trivy, `compose config` |

La vérification des liens Markdown, elle, est **déjà active** pour tout le dépôt : [`.github/workflows/docs-links.yml`](../.github/workflows/docs-links.yml) + [`scripts/check_links.py`](../scripts/check_links.py). Rien à copier.

## Adapter un template

À faire systématiquement après une copie :

1. `README.md` — remplacer les `<placeholders>`.
2. Nom du projet dans `pyproject.toml` / `package.json` / le `Makefile`.
3. `.env.example` — lister les variables attendues, **sans valeur réelle**.
4. Vérifier que le `.gitignore` racine couvre les artefacts du projet (`.terraform/`, `node_modules/`, `.venv/`… c'est déjà le cas pour les stacks ci-dessus).
