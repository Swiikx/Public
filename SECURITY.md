# Politique de sécurité

## Ce que contient ce dépôt

Des notes, des fiches de révision et des squelettes de projet. **Rien ici n'est un
service en production**, et rien n'est destiné à être déployé tel quel.

Les templates de [`templates/`](templates/) sont des points de départ pédagogiques.
Ils appliquent des réglages de durcissement par défaut — utilisateur non-root,
système de fichiers en lecture seule, en-têtes de sécurité, capacités retirées —
mais ils n'ont **pas** été audités, et leurs valeurs d'exemple
(`HEALTHCHECK` factice, périmètre réseau, versions épinglées) doivent être
adaptées avant tout usage réel. Les reprendre sans relecture serait une erreur.

## Signaler un problème

| Nature | Où |
|---|---|
| Erreur factuelle dans une fiche, lien mort, coquille | Ouvrir une *issue* |
| Mauvaise pratique de sécurité dans un template | Ouvrir une *issue*, ou une *pull request* |
| **Donnée sensible qui aurait fuité** dans ce dépôt | Ne pas ouvrir d'issue publique, voir ci-dessous |

### Fuite de donnée

Si vous constatez dans ce dépôt une information qui ne devrait pas y être — nom
d'hôte interne, adresse réelle, identifiant, secret — **merci de ne pas la
reproduire dans une issue publique**, ce qui ne ferait que l'amplifier.

Passez par un signalement privé : l'onglet *Security* de GitHub, fonction
**Report a vulnerability**, ou un contact direct via le profil GitHub.

Je révoquerai, retirerai et corrigerai la cause. Si vous avez déjà cloné le dépôt,
merci de supprimer votre copie.

## Ce qui est en place

| Mesure | Où |
|---|---|
| Hook `pre-commit` : secrets, matériel de clé, fichiers volumineux, liste « ne pas publier » | [`.githooks/`](.githooks/) |
| Contrôle en intégration continue sur tous les fichiers suivis | [`.github/workflows/secrets-scan.yml`](.github/workflows/secrets-scan.yml) |
| Exclusions larges côté `.gitignore` : clés, certificats, états Terraform, `.env`, exports bureautiques | [`.gitignore`](.gitignore) |
| Règles de contribution sur ce qui ne doit jamais être commité | [`CONVENTIONS.md`](CONVENTIONS.md) |

Le détail du fonctionnement et des limites du hook est dans
[`.githooks/README.md`](.githooks/README.md) — notamment le fait que le contrôle de
fuite ne tourne qu'en local, par construction.

## Pas de programme de récompense

Ce dépôt est un travail personnel d'étudiant. Il n'y a ni périmètre de test, ni
récompense, et **aucune autorisation de tester** quoi que ce soit : les systèmes
mentionnés dans les fiches ou les pages de projet ne font pas partie d'un
périmètre d'engagement. Se référer à
[la fiche sur le cadre légal](docs/fiches/cadre-legal-test-intrusion.md) pour ce
que cela implique.
