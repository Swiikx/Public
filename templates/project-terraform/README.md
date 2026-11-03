# <nom-du-projet>

<Une ou deux phrases : ce que cette stack provisionne et pourquoi.>

## Stack

- Terraform `>= 1.9`
- Provider : `<provider>` (ou aucun si projet logique)
- Linting : TFLint, Checkov

## Arbo

```
<nom-du-projet>/
├── versions.tf        # required_version + required_providers
├── main.tf            # locals et ressources
├── variables.tf       # entrées typées et validées
├── outputs.tf         # sorties
├── terraform.tfvars.example
├── .tflint.hcl
└── Makefile
```

## Démarrage

```bash
cp terraform.tfvars.example terraform.tfvars   # puis renseigner les valeurs
make init
make validate
make plan
```

`terraform.tfvars` est ignoré par git — seul le `.example` est versionné.

## Commandes

| Commande | Effet |
|---|---|
| `make fmt` | Formate le HCL de façon récursive |
| `make validate` | `init` + `validate` |
| `make lint` | TFLint récursif |
| `make plan` | Plan avec `terraform.tfvars` |
| `make apply` | Applique (demande confirmation) |
| `make clean` | Supprime `.terraform/` et les plans locaux |

## Variables

| Variable | Type | Défaut | Description |
|---|---|---|---|
| `project_name` | `string` | — | Préfixe de nommage des ressources |
| `environment` | `string` | — | `dev`, `staging` ou `prod` |
| `tags` | `map(string)` | `{}` | Tags additionnels |

## Notes

<Décisions d'implémentation, écarts, pièges rencontrés.>
