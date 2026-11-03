# <nom-du-projet>

<Une ou deux phrases : ce que fait le projet et pour qui.>

## Stack

- Node `>= 20` (modules ES)
- ESLint 9 (config plate)
- Tests : `node:test`, aucune dépendance de test externe

## Arbo

```
<nom-du-projet>/
├── package.json
├── eslint.config.js
├── src/
│   ├── index.js
│   └── index.test.js
└── .env.example
```

## Démarrage

```bash
npm install
npm test
npm start -- Ada
```

## Commandes

| Commande | Effet |
|---|---|
| `npm start` | Lance `src/index.js` |
| `npm run lint` | ESLint sur `src/` |
| `npm test` | Lance le runner de tests intégré de Node |
| `npm run build` | No-op par défaut, à remplacer si bundling |

## Configuration

Variables attendues dans `.env.example`. Copier en `.env` (ignoré par git) et renseigner.

| Variable | Défaut | Description |
|---|---|---|
| `NODE_ENV` | `development` | Environnement d'exécution |
| `PORT` | `3000` | Port d'écoute si service HTTP |

## À renommer après copie du template

- `name` et `description` dans `package.json`
- `license` : `UNLICENSED` par défaut, à changer si le projet est publié
