# Labs

TP et travaux pratiques de cours. Un dossier par TP, chacun autonome avec son propre `README.md`.

| TP | Sujet | Stack | Dossier |
|---|---|---|---|
| TP5 | Pipeline CI/CD autour d'un Terraform sans provider, estimation logique coût/capacité | Terraform, GitHub Actions, TFLint, Checkov, Python | [`lab-terraform-cicd-advanced/`](lab-terraform-cicd-advanced/) |

## Ajouter un lab

```bash
cp -r templates/project-terraform labs/lab-<sujet>     # ou un autre template
```

Le `README.md` du lab devrait couvrir :

- **Objectif** — ce que l'énoncé demande, en une ou deux phrases.
- **Arbo** — les fichiers et à quoi ils servent.
- **Commandes** — de quoi reproduire le résultat de zéro.
- **Ce qui a coincé** — écarts par rapport à l'énoncé, bugs rencontrés, et pourquoi tel choix a été fait. C'est la partie qui sert le plus en relecture six mois plus tard.
- **Questions de compréhension** — si l'énoncé en pose.

Le template [`templates/compte-rendu-tp/`](../templates/compte-rendu-tp/) reprend ce plan.
