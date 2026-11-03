# Git — mémo

## État et historique

| Commande | Effet |
|---|---|
| `git status -sb` | État court + branche et écart avec le remote |
| `git log --oneline --graph --decorate -20` | 20 derniers commits, graphe des branches |
| `git diff` | Modifs non indexées |
| `git diff --staged` | Modifs indexées (ce qui partira au commit) |
| `git show <sha>` | Contenu complet d'un commit |
| `git blame <fichier>` | Qui a touché quelle ligne, et dans quel commit |

**Réflexe avant chaque commit sur un dépôt public** : `git diff --staged` et relire. C'est là qu'on attrape le token collé par erreur.

## Branches

| Commande | Effet |
|---|---|
| `git switch -c feat/sujet` | Crée une branche et bascule dessus |
| `git switch main` | Bascule sur une branche existante |
| `git branch -vv` | Branches locales + remote suivi |
| `git branch -d feat/sujet` | Supprime une branche fusionnée |
| `git push -u origin feat/sujet` | Pousse et met en place le suivi |

## Commit

| Commande | Effet |
|---|---|
| `git add -p` | Indexe morceau par morceau, en relisant le diff |
| `git commit -m "feat: ..."` | Commit |
| `git commit --amend` | Modifie le dernier commit (message ou contenu) |
| `git commit --amend --no-edit` | Ajoute l'index au dernier commit sans toucher au message |

`--amend` réécrit l'historique : à éviter sur un commit déjà poussé et partagé.

## Mettre à jour depuis le remote

| Commande | Effet |
|---|---|
| `git fetch origin` | Récupère sans toucher au travail local |
| `git pull --rebase origin main` | Récupère et rejoue les commits locaux par-dessus |
| `git rebase origin/main` | Rejoue la branche courante sur `main` à jour |
| `git rebase --abort` | Annule un rebase en cours qui part mal |

## Sorties de secours

| Situation | Commande |
|---|---|
| Annuler des modifs non commitées sur un fichier | `git restore <fichier>` |
| Désindexer sans perdre les modifs | `git restore --staged <fichier>` |
| Annuler le dernier commit, garder les modifs | `git reset --soft HEAD~1` |
| Annuler le dernier commit et les modifs | `git reset --hard HEAD~1` ⚠️ destructif |
| Annuler un commit déjà poussé | `git revert <sha>` (crée un commit inverse, sûr) |
| Mettre de côté le travail en cours | `git stash push -m "wip"` puis `git stash pop` |
| Retrouver un commit « perdu » après un reset | `git reflog` puis `git reset --hard <sha>` |

`git reflog` garde la trace des `HEAD` précédents pendant ~90 jours : presque rien n'est vraiment perdu tant que le commit existait.

## Fichier commité par erreur

```bash
git rm --cached <fichier>          # sort du suivi, garde le fichier sur le disque
echo "<fichier>" >> .gitignore
git commit -m "chore: retire <fichier> du suivi"
```

Si le fichier contenait un secret : **changer le secret chez le fournisseur en premier**. Il reste dans l'historique et dans les clones déjà faits, même après un `git rm`.

## Divers

| Commande | Effet |
|---|---|
| `git clean -nd` | Liste les fichiers non suivis qui seraient supprimés |
| `git clean -fd` | Les supprime ⚠️ destructif |
| `git check-ignore -v <fichier>` | Dit quelle règle de `.gitignore` ignore un fichier |
| `git grep "motif"` | Cherche dans les fichiers suivis seulement |
| `git log -S"motif"` | Cherche les commits qui ajoutent/retirent un motif |
