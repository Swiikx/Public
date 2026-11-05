# Python — développement sécurisé

Fiche orientée pratiques de codage et outillage. Les exemples sont volontairement
courts : ce qui compte est le réflexe, pas la bibliothèque.

## Les pièges structurels du langage

| Piège | Pourquoi c'est dangereux | Ce qu'on fait |
|---|---|---|
| `eval`, `exec`, `pickle` | Exécution de code arbitraire à partir de données | `json` pour les données, `ast.literal_eval` pour un littéral |
| `subprocess(..., shell=True)` | La chaîne passe par un interpréteur de commandes | Liste d'arguments, `shell=False` (le défaut) |
| Chaînes SQL concaténées | Injection | Requêtes paramétrées |
| `yaml.load` | Peut instancier des objets arbitraires | `yaml.safe_load` |
| Arguments par défaut mutables | État partagé entre appels | `None` puis création dans le corps |
| `assert` pour valider une entrée | Supprimé avec l'option `-O` | Une vraie vérification qui lève |
| `random` pour un secret | Générateur prédictible | `secrets` |
| `==` sur un jeton ou une empreinte | Comparaison à temps variable | `hmac.compare_digest` |

### Commandes système

```python
import subprocess

# Non : la chaîne est interprétée par le shell.
# subprocess.run(f"ping -c 1 {hote}", shell=True)

# Oui : liste d'arguments, pas de shell, délai borné.
resultat = subprocess.run(
    ["ping", "-c", "1", hote],
    capture_output=True,
    text=True,
    timeout=5,
    check=False,
)
```

Même en liste d'arguments, `hote` doit être validé : on ne veut pas qu'une valeur
arbitraire devienne une option de la commande. La règle générale est de valider
par **liste d'autorisation**, jamais par liste d'interdiction.

### Requêtes SQL

```python
# Non : interpolation.
# curseur.execute(f"SELECT * FROM comptes WHERE id = {identifiant}")

# Oui : paramètre lié, l'échappement est fait par le pilote.
curseur.execute("SELECT * FROM comptes WHERE id = %s", (identifiant,))
```

Le nom d'une table ou d'une colonne ne peut pas être un paramètre lié. S'il doit
être dynamique, il se valide contre une **liste fermée** de valeurs permises.

### Chemins de fichiers

```python
from pathlib import Path

RACINE = Path("/var/app/documents").resolve()

def chemin_sur(nom_demande: str) -> Path:
    """Resout un chemin et verifie qu'il reste sous RACINE."""
    cible = (RACINE / nom_demande).resolve()
    if not cible.is_relative_to(RACINE):      # Python 3.9+
        raise ValueError("chemin hors du repertoire autorise")
    return cible
```

Le `resolve()` est essentiel : il normalise les `..` et les liens symboliques
**avant** la vérification. Vérifier la chaîne brute ne protège de rien.

### Aléa et comparaisons

```python
import hmac
import secrets

jeton = secrets.token_urlsafe(32)        # pour un secret
# random.random()                        # jamais pour un secret

def jeton_valide(fourni: str, attendu: str) -> bool:
    return hmac.compare_digest(fourni, attendu)
```

`compare_digest` compare en temps constant. Un `==` s'arrête au premier octet
différent, ce qui laisse fuiter de l'information par la mesure du temps de réponse.

## Mots de passe

```python
from argon2 import PasswordHasher          # argon2-cffi
from argon2.exceptions import VerifyMismatchError

hacheur = PasswordHasher()

empreinte = hacheur.hash(mot_de_passe)     # sel genere automatiquement

try:
    hacheur.verify(empreinte, saisie)
except VerifyMismatchError:
    ...                                    # echec d'authentification
```

**Argon2id** est le choix de référence ; `bcrypt` et `scrypt` restent acceptables.
Ne jamais utiliser SHA-256 seul : il est conçu pour être rapide, ce qui est
exactement le défaut à éviter ici. Le sel est unique par mot de passe et n'a pas
besoin d'être secret.

## Secrets et configuration

Trois règles, dans cet ordre d'importance :

1. **Aucun secret dans le code**, et donc aucun dans l'historique Git.
2. **Configuration par l'environnement**, pas par un fichier versionné. Un
   `.env.example` sans valeur réelle documente les variables attendues.
3. **Échec explicite** si un secret manque, plutôt qu'un repli silencieux sur une
   valeur par défaut.

```python
import os

def secret_obligatoire(nom: str) -> str:
    valeur = os.environ.get(nom)
    if not valeur:
        raise RuntimeError(f"variable d'environnement manquante : {nom}")
    return valeur
```

Un défaut du type `os.environ.get("API_TOKEN", "dev")` finit toujours en
production.

## Journalisation

```python
import logging

logger = logging.getLogger(__name__)

# Non : le secret part dans les journaux.
# logger.info("connexion avec le jeton %s", jeton)

# Oui : on trace l'evenement, pas la valeur.
logger.info("connexion refusee pour l'utilisateur %s", identifiant_utilisateur)
```

Ce qui ne doit jamais être journalisé : mots de passe, jetons, clés, numéros de
carte, contenu de corps de requête non filtré. Attention aussi aux **traces
d'exception**, qui embarquent les variables locales dans certains gestionnaires
d'erreur, et aux journaux qui contiennent des données personnelles — ils relèvent
du RGPD, avec une durée de conservation à définir.

Utiliser `logger.info("... %s", valeur)` et non une f-chaîne : le formatage est
différé, ce qui évite le coût quand le niveau est désactivé.

## Requêtes HTTP sortantes

```python
import requests

reponse = requests.get(
    url,
    timeout=10,            # jamais d'appel sans delai : sinon blocage indefini
    verify=True,           # le defaut, a ne jamais passer a False
    allow_redirects=False, # a activer en connaissance de cause
)
reponse.raise_for_status()
```

`verify=False` désactive la vérification du certificat et annule la protection de
TLS. Si un certificat interne pose problème, on ajoute l'autorité au magasin de
confiance — on ne désactive pas la vérification.

Si l'URL vient d'une entrée utilisateur, il faut aussi se préoccuper des requêtes
vers des adresses internes : validation du schéma, résolution du nom, et liste
d'autorisation des destinations.

## Désérialisation et données externes

Toute donnée venant de l'extérieur est non fiable, y compris un fichier
téléchargé ou une réponse d'API. Deux réflexes :

- **Valider la structure** avant d'utiliser, avec `pydantic` ou des
  vérifications explicites. Une clé absente ou d'un type inattendu ne doit pas
  provoquer une erreur à cinquante lignes de là.
- **Ne pas désérialiser du code.** `pickle`, `marshal` et `yaml.load` peuvent
  instancier des objets arbitraires : un fichier malveillant devient une exécution.

Dans un dépôt, un fichier téléchargé se place dans un répertoire dédié, et les
scripts qui le lisent vivent ailleurs — un interpréteur charge les modules depuis
le répertoire du script et le répertoire courant, donc un `json.py` déposé à côté
s'exécute à l'`import json`.

## Dépendances et chaîne logicielle

| Pratique | Pourquoi |
|---|---|
| **Versions épinglées** et verrou committé | Reproductibilité ; un `latest` qui bouge change le code sans commit |
| `pip-audit` ou équivalent en CI | Détecte les dépendances vulnérables connues |
| Vérifier le nom avant d'installer | Les paquets au nom proche d'un paquet populaire sont un vecteur courant |
| Limiter le nombre de dépendances | Chaque dépendance est une surface d'attaque et une dette |
| **SBOM** | Inventaire des composants, exigé dans un nombre croissant de contextes |

## Outillage à brancher en intégration continue

| Outil | Rôle |
|---|---|
| **ruff** | Lint et format, très rapide ; remplace flake8, isort et une partie de pylint |
| **mypy** ou **pyright** | Typage statique ; attrape les erreurs de contrat avant l'exécution |
| **bandit** | Analyse statique orientée sécurité, repère les motifs de la première section |
| **pip-audit** | Vulnérabilités connues des dépendances |
| **pytest** | Tests, dont les cas limites et les entrées malformées |
| **detect-secrets** ou un hook maison | Empêche un secret de partir dans un commit |

Le pari gagnant est de les mettre en **hook pre-commit** autant qu'en CI : la CI
dit ce qui est cassé, le hook empêche de le casser.

## Typage et contrats

```python
from collections.abc import Sequence

def moyenne(valeurs: Sequence[float]) -> float:
    if not valeurs:
        raise ValueError("sequence vide")
    return sum(valeurs) / len(valeurs)
```

Le typage n'est pas une contrainte de style : il documente le contrat et permet à
`mypy` de détecter les appels incohérents. Combiné à une levée explicite sur les
cas limites, il évite la classe d'erreurs la plus fréquente — une valeur `None`
qui traverse trois couches avant de provoquer une exception illisible.

## Points d'examen fréquents

**Pourquoi `shell=True` est-il dangereux ?** Parce que la chaîne est interprétée
par un interpréteur de commandes, qui y voit des séparateurs, des redirections et
des substitutions. La liste d'arguments supprime cet interpréteur.

**Pourquoi pas SHA-256 pour un mot de passe ?** Parce qu'il est rapide par
conception. Il faut une fonction de dérivation lente et salée — Argon2id, bcrypt,
scrypt.

**`random` ou `secrets` ?** `secrets` pour tout ce qui doit être imprévisible.
`random` est un générateur pseudo-aléatoire déterministe, prévu pour la simulation.

**Pourquoi `hmac.compare_digest` ?** Pour comparer en temps constant et ne pas
laisser fuiter d'information par le temps de réponse.

**Pourquoi `resolve()` avant de vérifier un chemin ?** Parce que la normalisation
des `..` et des liens symboliques doit précéder le contrôle, sinon le contrôle
porte sur une chaîne et pas sur la cible réelle.

## Sources

- OWASP — *Cheat Sheet Series* : *Password Storage*, *Input Validation*, *Logging*
- Python Software Foundation — documentation des modules `secrets`, `hmac`, `subprocess`, `pathlib`
- PyCQA — documentation de `bandit`
- OpenSSF — bonnes pratiques de sécurité de la chaîne logicielle
