# QG ESD — base de connaissances auto-hébergée

**Statut : en cours** · démarré en octobre 2026

> Le dépôt de travail de ce projet est privé, et le reste. Cette page décrit la
> démarche et la mécanique, pas le contenu : il s'agit de notes de cours, d'un
> journal d'alternance et d'un mémoire en rédaction, qui n'ont pas vocation à
> être publics. Voir [Ce qui n'est pas publié ici](#ce-qui-nest-pas-publié-ici).

## Le problème

Deux ans de mastère en cybersécurité en alternance — semaines de centre, missions en
entreprise, mémoire — ça produit des notes qui s'éparpillent entre le bloc-notes du
téléphone, les supports de l'école et trois dossiers sur le poste. Trois besoins :

- **Retrouver** une notion six mois plus tard sans se souvenir où elle est rangée.
- **Ne rien perdre** : j'ai déjà perdu le poste qui hébergeait la première version.
- **Écrire sans friction** : si publier demande une action manuelle, j'arrête au bout
  de deux semaines.

## Ce que j'ai construit

Un site de documentation statique, auto-hébergé sur mon lab, alimenté par une chaîne
de publication automatique de bout en bout : j'écris en Markdown sur mon poste, le
contenu est consultable quelques minutes plus tard, sans aucune intervention.

Trois contraintes que je me suis imposées dès le départ :

| Contrainte | Comment elle est tenue |
|---|---|
| **Aucune exposition publique** | Le service n'est joignable que depuis mon réseau privé, derrière authentification. Rien n'est atteignable depuis Internet. |
| **Sauvegarde hors site** | Le contenu est versionné dans un dépôt Git privé, qui sert aussi de sauvegarde. |
| **Zéro action manuelle** | De l'écriture à la mise en ligne, tout est déclenché par des tâches planifiées, des deux côtés de la chaîne. |

## Stack

Virtualisation **Proxmox** · site statique **MkDocs Material** · build en **CI GitHub
Actions** · service web **nginx** · automatisation **systemd timers** et **PowerShell** ·
accès distant par **VPN** · supervision **Uptime Kuma**

## Compétences mises en œuvre

- **Administration Linux et virtualisation** — VM dédiée au service, compte de service
  sans privilèges, système monté en lecture seule en dehors du répertoire du site.
- **Durcissement** — isolation du service (capacités retirées, appels système filtrés,
  élévation de privilèges interdite), en-têtes de sécurité HTTP restrictifs,
  restriction d'accès par adresse, authentification, et refus d'accès aux fichiers
  cachés du répertoire servi.
- **CI/CD** — construction du site en intégration continue, séparation entre la source
  rédigée et l'artefact publié.
- **Automatisation système** — chaîne complète par tâches planifiées, côté poste de
  travail comme côté serveur, avec délai de publication borné.
- **Supervision** — sondes de disponibilité sur le service *et* sur la chaîne de mise à
  jour, pour détecter une publication qui ne passe plus, et pas seulement un site
  tombé.
- **Hygiène de données** — règles d'exclusion strictes pour que les documents à
  diffusion restreinte, les données personnelles et les exports bureautiques non
  anonymisés ne quittent jamais le poste, même vers un dépôt privé.

## Avancement

| Lot | Statut |
|---|---|
| Site en service | Fait |
| Chaîne de publication automatique | Fait |
| Durcissement du service et de l'accès | Fait |
| Supervision de la chaîne | Fait |
| Reconstruction après perte du poste | Fait |
| Automatisation des rappels et des révisions | En cours |

## Ce que j'en retiens

**La sauvegarde hors site n'est pas une précaution théorique.** J'ai perdu le poste qui
hébergeait la première version. Ce qui a été reconstruit l'a été depuis le dépôt Git et
l'historique ; ce qui n'y était pas est perdu. La règle s'est inversée depuis : le dépôt
est la référence, le poste n'est qu'un endroit où on édite.

**Une automatisation dont personne ne vérifie l'exécution n'est pas une automatisation.**
Les tâches de rappel tournaient dans un environnement qui a disparu avec le poste. Elles
ne se sont pas relancées toutes seules, et rien ne me l'a signalé. D'où les sondes qui
surveillent la chaîne de publication elle-même, et pas seulement le site.

**Le durcissement coûte peu à l'installation, et cher après.** Restreindre un service au
moment où on le déploie prend quelques minutes ; revenir dessus une fois qu'il est en
production et que des habitudes se sont installées prend beaucoup plus.

## Ce qui n'est pas publié ici

Volontairement absents de cette page : noms d'hôtes et noms de domaine, plan
d'adressage et topologie réseau, noms des machines et des comptes de service, chemins
système, fichiers de configuration, versions logicielles précises, et l'intégralité du
contenu documentaire.

Le détail n'ajoute rien à la démonstration, et il constituerait une cartographie d'un
lab qui, lui, est bien réel. Pour un recruteur, les sections ci-dessus suffisent ; pour
une discussion technique, j'en parle de vive voix.
