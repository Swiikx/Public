# AISC75 — Jour 5 : Terraform CI/CD, Sécurité & Bonnes Pratiques

Rendu couvrant les huit chapitres du cours Jour 5 (niveau B3 DevOps).

Le module pédagogique utilisé est un générateur de configuration Nginx (`local_file`) — volontairement sans provider cloud pour que l'ensemble tourne gratuitement dans GitHub Actions et GitLab CI sans secret AWS.

## Structure

```
AISC75-Jour5-CICD-Securite/
├── modules/nginx-config/        Module Terraform (local_file)
│   ├── main.tf, variables.tf, outputs.tf, vhost.tpl
│   └── tests/nginx.tftest.hcl   Tests natifs `terraform test`
├── environments/
│   ├── dev/                     Env dev : 2 workers, HTTP, log debug
│   └── prod/                    Env prod : 4 workers forcés, SSL, log warn
├── security-demo/               Exemples AWS volontairement vulnérables (démo checkov/tfsec)
└── terragrunt-demo/             Structure DRY multi-env avec Terragrunt
    ├── terragrunt.hcl           Config racine (backend, inputs communs)
    ├── modules/nginx/
    └── environments/{dev,prod}/
```

## Chapitres du cours couverts

| Chapitre | Couvert par |
|----------|-------------|
| 1. Testing Terraform (terraform test, terratest) | `modules/nginx-config/tests/nginx.tftest.hcl` (3 tests unitaires) |
| 2. Sécurité (checkov, tfsec) | `security-demo/` + jobs CI `checkov` et `tfsec` |
| 3. CI/CD GitHub Actions | `.github/workflows/terraform-jour5.yml` |
| 4. CI/CD GitLab CI | `.gitlab-ci.yml` (racine du repo) |
| 5. Terragrunt | `terragrunt-demo/` avec `run --all apply` |
| 6. Bonnes pratiques | Variables typées avec `validation`, modules réutilisables, CI obligatoire avant merge, pas de state commité |

## Reproduire en local

### Prérequis
- Terraform >= 1.6 (tests natifs)
- tflint, checkov (via pipx), tfsec, terragrunt v1.x

### Exercice 1 : lint & validate
```bash
cd AISC75-Jour5-CICD-Securite
terraform fmt -check -recursive -diff

cd modules/nginx-config
terraform init -backend=false
terraform validate
tflint --init && tflint --recursive
```

### Exercice 2 : tests unitaires Terraform
```bash
cd modules/nginx-config
terraform test
# Success! 3 passed, 0 failed.
```

### Exercice 3 : scan sécurité
```bash
# Module propre : 0 règle déclenchée (pas de ressource cloud)
checkov -d modules/nginx-config --framework terraform

# Exemple vulnérable AWS : S3 sans chiffrement + SG 0.0.0.0/0 port 22
checkov -d security-demo --framework terraform --compact
tfsec security-demo
# 1 critique, 6 high, 2 medium, 3 low
```

### Exercice 4 : Terragrunt multi-env
```bash
cd terragrunt-demo/environments/dev
terragrunt plan                         # un module

cd ../..
terragrunt run --all --non-interactive apply   # tous les env
```

## Tests couverts par `terraform test`

- `validation_env_dev` — en dev, `log_level == "debug"` et `worker_processes` non forcé.
- `validation_env_prod_force_4_workers` — en prod, `effective_workers` forcé à 4 minimum, `log_level == "warn"`, SSL forcé à `true` sur les vhosts.
- `validation_environnement_invalide` — la validation de `var.environment` rejette `"qualif"`.

## Pipelines CI

- **GitHub Actions** (`.github/workflows/terraform-jour5.yml`) : fmt → validate → tflint → checkov → tfsec → `terraform test` → plan dev + plan prod.
- **GitLab CI** (`.gitlab-ci.yml`) : mêmes stages, image `hashicorp/terraform` pour les jobs Terraform, images `bridgecrew/checkov` et `aquasec/tfsec` pour la sécurité.

Les deux pipelines sont déclenchés uniquement sur les changements dans `AISC75-Jour5-CICD-Securite/**` pour ne pas interférer avec les autres rendus du dépôt.
