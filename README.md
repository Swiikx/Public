# Public

Dépôt public : travaux pratiques, projets personnels, notes et ressources réutilisables.
Tout ce qui est ici est volontairement ouvert — aucun secret, aucune donnée sensible (voir [`CONVENTIONS.md`](CONVENTIONS.md)).

## Organisation

| Dossier | Contenu |
|---|---|
| [`labs/`](labs/) | TP et labs de cours, un dossier par TP |
| [`projects/`](projects/) | Projets personnels et side projects |
| [`docs/`](docs/) | Fiches de révision, cheatsheets, veille, comptes rendus |
| [`templates/`](templates/) | Squelettes de démarrage (Terraform, Python, Node, Docker, write-up, compte rendu) et workflows CI prêts à copier |
| [`scripts/`](scripts/) | Outillage du dépôt (vérification des liens Markdown) |
| [`.github/workflows/`](.github/workflows/) | Workflows GitHub Actions actifs (GitHub ne lit que cet emplacement) |

```
.
├── labs/
│   └── lab-terraform-cicd-advanced/   # TP5 AISC75 — Terraform CI/CD sans provider
├── projects/
├── docs/
│   ├── fiches/
│   ├── cheatsheets/
│   ├── veille/
│   └── comptes-rendus/
├── templates/
│   ├── ci/
│   ├── project-terraform/
│   ├── project-python/
│   ├── project-node/
│   ├── project-docker/
│   ├── writeup-securite/
│   └── compte-rendu-tp/
├── scripts/
│   └── check_links.py
├── CONVENTIONS.md
└── README.md
```

## CI active

| Workflow | Déclencheur | Fait quoi |
|---|---|---|
| [`terraform-ci.yml`](.github/workflows/terraform-ci.yml) | Changement dans `labs/lab-terraform-cicd-advanced/**` | `fmt` → `validate` → TFLint → Checkov → `plan` 3 envs + artefacts |
| [`docs-links.yml`](.github/workflows/docs-links.yml) | Changement dans un `.md` | Vérifie que les liens relatifs pointent sur un fichier existant |

Vérification des liens en local :

```bash
python3 scripts/check_links.py .
```

## Index

### Labs

| TP | Sujet | Stack |
|---|---|---|
| [TP5](labs/lab-terraform-cicd-advanced/) | Pipeline CI/CD autour d'un Terraform sans provider, estimation logique coût/capacité | Terraform, GitHub Actions, TFLint, Checkov, Python |

### Projets

Aucun pour l'instant — voir [`projects/README.md`](projects/README.md).

## Démarrer un nouveau projet

```bash
cp -r templates/project-terraform projects/mon-projet
```

Puis :

1. Renseigner le `README.md` du projet (objectif, stack, commandes).
2. Si besoin de CI, copier le workflow correspondant depuis `templates/ci/` vers `.github/workflows/`, et **adapter le filtre `paths`** au dossier du projet.
3. Ajouter une ligne dans l'index ci-dessus.

Les conventions de nommage, de branches et de commits sont dans [`CONVENTIONS.md`](CONVENTIONS.md).
