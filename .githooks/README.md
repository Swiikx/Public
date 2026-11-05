# Hooks Git du dépôt

Ce dépôt est **public**. Un secret poussé ici est immédiatement indexable, et le
retirer de l'historique ne le rend pas pour autant non compromis. Le hook existe
pour que l'erreur soit bloquée avant le commit, pas constatée après.

## Activation

`core.hooksPath` vit dans `.git/config`, donc **hors du dépôt** : un nouveau clone
n'a pas le hook actif.

```bash
git config core.hooksPath .githooks
```

Vérifier :

```bash
git config --get core.hooksPath
```

## Liste « ne pas publier »

Le hook sait reconnaître les formats de secrets connus. Il ne peut pas devenir
qu'un nom d'hôte, un nom de machine ou une raison sociale ne doit pas sortir des
dépôts privés — ça, il faut le lui dire.

```bash
cp .githooks/ne-pas-publier.local.example .githooks/ne-pas-publier.local.txt
```

Puis renseigner : nom de domaine du lab, noms d'hôtes et de machines virtuelles,
plages d'adresses réelles, employeur, comptes de service, identifiants scolaires.

**Ce fichier n'est pas versionné**, et c'est le point central : une liste qui
énumère ce qu'il faut cacher ne peut pas vivre dans le dépôt public qu'elle
protège. Elle est donc à recréer sur chaque poste. Tant qu'elle manque, le hook le
signale sans bloquer — sinon un clone neuf ne pourrait rien committer.

Le hook n'affiche jamais le terme trouvé, seulement sa longueur : le message peut
finir dans un journal, une capture d'écran ou une session partagée.

## Les deux niveaux

| Niveau | Effet | Contenu |
|---|---|---|
| **REFUS** | Commit bloqué | Clés privées, formats de clés fournisseurs (GitHub, AWS, Slack, Google, Anthropic/OpenAI, Terraform Cloud), clés WireGuard, URL avec identifiants, matériel de clé (`.pem`, `.key`, `.p12`…), fichiers > 20 Mo, termes de la liste « ne pas publier » |
| **ATTENTION** | Affiché, commit accepté | Mots de passe en clair, tokens génériques, adresses IP publiques, chaînes à haute entropie, exports bureautiques (`.pdf`, `.docx`, `.xlsx`, `.csv`…) |

Ce partage est la condition pour que le hook survive. Les fiches de ce dépôt
parlent **légitimement** de mots de passe, d'adresses et de hachages — c'est leur
sujet. Un hook qui bloque là-dessus se fait désactiver au bout de deux jours, et
ne protège alors plus rien.

Les exports bureautiques sont en avertissement et non en refus parce qu'un
portfolio peut légitimement en contenir — mais c'est le premier vecteur de données
non expurgées, d'où le rappel à chaque fois.

Seules les **lignes ajoutées** sont examinées en mode hook : le contenu déjà
présent n'est pas re-signalé à chaque commit.

## Les deux modes

```bash
python .githooks/check-secrets.py          # lignes ajoutées et indexées
python .githooks/check-secrets.py --all    # tous les fichiers suivis
```

Le mode `--all` est celui de la CI, dans
[`.github/workflows/secrets-scan.yml`](../.github/workflows/secrets-scan.yml). Il
protège même si personne n'a positionné `core.hooksPath` sur son poste.

Une limite assumée : **le contrôle de fuite ne tourne pas en CI**, puisque sa
liste est volontairement hors du dépôt et donc indisponible pour le *runner*. Ce
filet-là reste local. C'est le prix de ne pas versionner la liste, et c'est le bon
arbitrage : une liste versionnée publierait exactement ce qu'elle protège.

## Contournement

```bash
git commit --no-verify
```

À réserver aux faux positifs. Si un secret est **déjà parti** : le révoquer chez
le fournisseur **d'abord**. Réécrire l'historique ensuite ne change rien au fait
que la valeur a pu être récupérée, clonée ou indexée.

## Si Python manque

Le hook échoue **fermé** : pas de Python, pas de commit. Sur un dépôt public, un
commit refusé se rattrape, un secret publié se révoque.
