# Projets

Projets personnels et side projects. Un dossier par projet, autonome, avec son `README.md`.

| Projet | Description | Stack | Statut |
|---|---|---|---|
| — | Aucun projet pour l'instant | — | — |

Statuts utilisés : `idée` · `en cours` · `pause` · `terminé` · `archivé`.

## Démarrer un projet

```bash
cp -r templates/project-python projects/mon-projet
cd projects/mon-projet
```

Templates disponibles : [`project-terraform`](../templates/project-terraform/), [`project-python`](../templates/project-python/), [`project-node`](../templates/project-node/), [`project-docker`](../templates/project-docker/).

Ensuite :

1. Remplir le `README.md` (objectif, stack, installation, commandes).
2. Copier le workflow CI voulu depuis [`templates/ci/`](../templates/ci/) vers `.github/workflows/` et adapter le filtre `paths` + le `working-directory`.
3. Ajouter la ligne dans le tableau ci-dessus et dans l'index du [README racine](../README.md).

Rappel : le dépôt est public, voir [`CONVENTIONS.md`](../CONVENTIONS.md) pour ce qui ne doit jamais y figurer.
