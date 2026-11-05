# Conventions du dépôt

## Règle n°1 : rien de sensible

Le dépôt est public. Ne jamais commiter :

- identifiants, tokens, clés d'API, mots de passe ;
- clés privées, certificats, fichiers `.pem` / `.key` / `.ppk` ;
- configs VPN/WireGuard réelles, `known_hosts`, `.ssh/` ;
- états Terraform (`*.tfstate`), `terraform.tfvars` renseignés ;
- IP publiques, noms d'hôtes internes, URLs d'admin d'une infra réelle ;
- captures d'écran non floutées contenant un de ces éléments.

Le [`.gitignore`](.gitignore) couvre déjà la majorité de ces cas, mais il ne remplace pas une relecture du diff avant commit.

Depuis, un hook `pre-commit` applique cette règle automatiquement : il refuse les
formats de secrets connus, le matériel de clé, les fichiers volumineux et les
termes d'une liste locale « ne pas publier ». Mise en place et limites dans
[`.githooks/README.md`](.githooks/README.md). Il ne dispense pas de relire le
diff : il attrape ce qu'on peut décrire par un motif, pas ce qu'on n'aurait pas
dû écrire.

Pour les valeurs d'exemple, utiliser des fichiers `*.example` versionnés et laisser le vrai fichier ignoré :

```
.env.example            → versionné
.env                    → ignoré
terraform.tfvars.example → versionné
terraform.tfvars        → ignoré
```

En cas de fuite, changer le secret côté fournisseur **d'abord** : réécrire l'historique ne suffit pas, la valeur a pu être récupérée.

## Nommage des dossiers

En minuscules, mots séparés par des tirets, sans accents.

| Type | Forme | Exemple |
|---|---|---|
| Lab de cours | `labs/lab-<sujet>` | `labs/lab-terraform-cicd-advanced` |
| Projet perso | `projects/<nom>` | `projects/homelab-monitoring` |
| Fiche / note | `docs/<categorie>/<sujet>.md` | `docs/fiches/reseau-vlan.md` |
| Write-up sécu | `docs/comptes-rendus/<date>-<cible>.md` | `docs/comptes-rendus/2026-01-15-htb-devvortex.md` |

## Chaque dossier a un README

Au minimum : objectif, stack, commandes pour reproduire. Les templates dans [`templates/`](templates/) partent déjà avec cette structure.

## Branches

| Branche | Rôle |
|---|---|
| `main` | État stable, publiable |
| `feat/<sujet>` | Nouveau lab, projet ou fonctionnalité |
| `fix/<sujet>` | Correction |
| `docs/<sujet>` | Notes, fiches, README |

On ne pousse pas directement sur `main` quand le changement mérite une relecture — passer par une PR, ça laisse aussi tourner la CI.

## Commits

Format [Conventional Commits](https://www.conventionalcommits.org/), en français ou en anglais mais de façon cohérente dans un même projet :

```
<type>(<scope>): <description à l'impératif>
```

Types utilisés : `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`.

```
feat(lab-terraform): ajoute le module compliance
fix(ci): corrige le filtre paths du workflow terraform
docs(fiches): fiche révision sur les VLAN
chore: deplace les labs dans labs/
```

## CI

Les workflows actifs vivent dans `.github/workflows/` — GitHub Actions ne lit que cet emplacement, même pour un projet rangé dans un sous-dossier.

Conséquence : chaque workflow doit être **scopé** sur le dossier concerné, sinon il tourne à chaque commit du dépôt.

```yaml
on:
  push:
    paths:
      - 'projects/mon-projet/**'
      - '.github/workflows/mon-projet-ci.yml'

defaults:
  run:
    working-directory: projects/mon-projet
```

Des workflows prêts à copier (Terraform, Python, Node, Docker, lint Markdown) sont dans [`templates/ci/`](templates/ci/).

## Épingler les versions

Dans la CI comme dans les projets : versions d'actions (`actions/checkout@v4`), de runtime (`TF_VERSION`, `python-version`) et de linters explicites. Un `latest` qui bouge transforme un pipeline vert en pipeline rouge sans qu'une ligne de code ait changé.
