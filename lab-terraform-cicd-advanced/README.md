# TP5 - Terraform CI/CD sans provider

Lab du cours AISC75. L'idée c'est de monter une pipeline CI/CD propre autour d'un projet Terraform qui ne provisionne rien. On modélise une plateforme campus (4 apps, 3 envs) et on sort une estimation logique de coût/capacité depuis les plans.

## Arbo

```
lab-terraform-cicd-advanced/
├── main.tf
├── variables.tf
├── outputs.tf
├── dev.tfvars / staging.tfvars / prod.tfvars
├── scripts/estimate.py
└── modules/
    ├── naming/
    └── compliance/
```

Le workflow est à la racine du repo (`.github/workflows/terraform-ci.yml`) parce que GitHub Actions ne lit que cet emplacement. Il est scopé sur `lab-terraform-cicd-advanced/**` via un filtre `paths`.

## Commandes

```bash
cd lab-terraform-cicd-advanced
terraform fmt -recursive
terraform init
terraform validate

terraform plan -var-file=dev.tfvars
terraform plan -var-file=staging.tfvars
terraform plan -var-file=prod.tfvars

terraform apply -var-file=dev.tfvars
terraform output
```

## Envs

- **dev** : portal, notes, presence, planning (~850 users). Ports 8080-8083, criticité majoritairement medium/low.
- **staging** : portal, notes, presence, reporting (~1330 users). `reporting` remplace `planning`.
- **prod** : mêmes apps que staging (~4700 users). Portal passe en 443, tous les backends en high. La contrainte "frontend sur 80 ou 443" ne s'applique qu'ici.

## Ce qui a coincé

Deux trucs dans l'énoncé qui passent pas en l'état :

- **TF_VERSION 1.6.6** dans le workflow : refuse les validations qui lisent une autre variable (les règles prod sur `applications` qui dépendent de `var.environment`). Ce support est arrivé en Terraform 1.9, donc bumpé à `1.9.8`.
- **`local.teams_def`** dans `modules/compliance/main.tf` : le PDF de l'énoncé tronque le nom, la déclaration est `teams_defined`. Renommé pour que la référence corresponde.

Adaptations (pas des erreurs) :

- Workflow à la racine du dépôt au lieu du sous-dossier, parce que GitHub Actions ne détecte que `.github/workflows/` à la racine.
- Bloc `terraform { required_version }` ajouté dans chaque module, sinon tflint fait tomber le job (règle `terraform_required_version`).
- `.tflint.hcl` dans le dossier du lab pour désactiver `terraform_unused_declarations` : l'énoncé déclare `local.app_map` dans `main.tf` mais ne le consomme nulle part, on accepte ce choix sans toucher au code.

## Questions de compréhension

**Pourquoi ça tourne sans provider ?**
Aucune ressource n'est déclarée, tout est fait en `locals`, `variables`, `outputs` et modules. Terraform init, validate et plan marchent quand même, le plan sera juste vide côté infra.

**`validate` vs `plan` ?**
`validate` c'est la syntaxe et les types. `plan` résout les expressions avec les tfvars, appelle les providers s'il y en a, calcule les outputs.

**Pourquoi `apply` reste utile ici ?**
Les outputs calculés ne sont écrits dans le state qu'après apply. Sans ça, `terraform output` renvoie rien.

**Le rôle des modules sans ressources ?**
Séparer la logique (nommage d'un côté, conformité de l'autre), forcer un contrat via des variables typées, pouvoir les réutiliser ailleurs.

**Pourquoi `alltrue()` ?**
Une validation Terraform prend une seule condition booléenne. Pour valider une règle sur *chaque* élément d'une liste, on combine `for` + `alltrue()` pour se ramener à un seul booléen.

**TFLint et Checkov dans un projet sans ressources ?**
TFLint chope les anti-patterns HCL indépendamment du provider. Checkov applique des règles de conformité qui seront utiles dès qu'on ajoutera des ressources cloud. Autant les brancher maintenant.

**Comment on remplace Infracost ?**
Par `scripts/estimate.py` : il lit le plan exporté en JSON et ressort coût + capacité à partir des outputs. La pondération est dans `main.tf` (high=120/3×users, medium=70/2×users, low=30/1×users).

**Pourquoi publier les plans en artefact ?**
Pour pouvoir les rejouer, les diff entre deux PRs, ou les passer à un outil externe d'analyse. Sans artefact, l'info meurt avec le job.

**Pourquoi la contrainte frontend → 80/443 seulement en prod ?**
En dev/staging on a besoin de ports libres pour faire tourner plusieurs services en parallèle. En prod c'est du HTTP/HTTPS standard, donc on bloque tout le reste.

**Prépa à un vrai pipeline cloud ?**
La structure est identique : fmt → validate → lint → sécurité → plan → artefact. Le jour où on ajoute un provider, il suffit de brancher les credentials (idéalement en OIDC via secrets GitHub) et d'ajouter un job `apply` manuel.
