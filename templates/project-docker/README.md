# <nom-du-projet>

<Une ou deux phrases : le service conteneurisé et son rôle.>

## Stack

- Docker + Compose (spec v2, fichier `compose.yaml`)
- Image multi-étapes, exécution en utilisateur non-root
- Base de données optionnelle (bloc `db` commenté dans `compose.yaml`)

## Arbo

```
<nom-du-projet>/
├── Dockerfile          # build multi-étapes
├── compose.yaml        # service app (+ db en option)
├── .dockerignore
└── .env.example
```

## Démarrage

```bash
cp .env.example .env     # puis renseigner
docker compose build
docker compose up -d
docker compose logs -f app
```

## Commandes

| Commande | Effet |
|---|---|
| `docker compose up -d --build` | Rebuild + démarre en arrière-plan |
| `docker compose ps` | État des services et healthchecks |
| `docker compose logs -f app` | Suit les logs du service |
| `docker compose exec app sh` | Shell dans le conteneur |
| `docker compose down` | Arrête et supprime les conteneurs |
| `docker compose down -v` | Idem + supprime les volumes ⚠️ perte de données |

## Configuration

| Variable | Défaut | Description |
|---|---|---|
| `PORT` | `8000` | Port exposé sur l'hôte |

Les secrets passent par `.env` (ignoré par git) ou par des secrets Docker — jamais en dur dans le `Dockerfile` ou le `compose.yaml`, qui sont versionnés.

## Choix de durcissement

| Réglage | Pourquoi |
|---|---|
| `USER app` (uid 10001) | Une évasion de process ne donne pas root sur l'hôte |
| `read_only: true` + `tmpfs: /tmp` | Le conteneur ne peut pas écrire hors de `/tmp` |
| `no-new-privileges:true` | Bloque l'escalade via les binaires setuid |
| `HEALTHCHECK` | Compose et l'orchestrateur savent si le service répond vraiment |
| Tags d'image épinglés (`python:3.12-slim`) | Un `latest` qui bouge change l'image sans changement de code |

Le healthcheck par défaut est un placeholder (`sys.exit(0)`) : le remplacer par un vrai appel à l'endpoint de santé du service.

## À adapter après copie du template

- `image:` et le nom du service dans `compose.yaml`
- le `CMD` du `Dockerfile` (module ou binaire à lancer)
- l'image de base si le projet n'est pas en Python
- le `HEALTHCHECK` (Dockerfile **et** compose.yaml)
