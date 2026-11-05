# Rapport de test d'intrusion et communication du risque

Le livrable est la mission. Une mission techniquement excellente dont le rapport
n'est pas lu, ou dont les constats ne sont pas corrigés, n'a produit aucune valeur.

C'est la compétence la plus évaluée chez un *lead*, et la moins travaillée par les
étudiants.

## Deux lecteurs, deux besoins

| Lecteur | Ce qu'il cherche | Ce qui le fait décrocher |
|---|---|---|
| **Direction** | Suis-je exposé, à quoi, combien ça coûte de corriger, dans quel ordre | Du jargon, des listes d'outils, l'absence de hiérarchie |
| **Équipes techniques** | Où exactement, comment reproduire, quoi changer | Des constats vagues, une recommandation générique du type « durcir la configuration » |

D'où la structure en deux niveaux : une **synthèse** autoportante, et un **détail**
exploitable. Pas un document hybride qui ne sert ni l'un ni l'autre.

## Structure attendue

| Section | Contenu | Longueur indicative |
|---|---|---|
| **Synthèse** | Contexte, périmètre, nombre de constats par gravité, les 3 à 5 risques majeurs, tendance générale | 1 à 2 pages, sans jargon |
| **Périmètre et limites** | Ce qui a été testé, ce qui ne l'a pas été, et **pourquoi** | 1 page |
| **Méthodologie** | Approche retenue, référentiel suivi, type de test et niveau d'information | ½ page |
| **Synthèse des constats** | Tableau : identifiant, intitulé, gravité, actif concerné, effort de correction | 1 à 2 pages |
| **Constats détaillés** | Une fiche par constat | Le corps du rapport |
| **Plan de remédiation** | Priorisé, avec échéances proposées | 1 à 2 pages |
| **Annexes** | Éléments de preuve, chronologie, références | Variable |

### La section « limites » n'est pas une excuse

C'est une protection pour les deux parties, et un signe de sérieux. Elle consigne
ce qui a empêché une couverture complète : fenêtre trop courte, environnement de
recette non représentatif, système indisponible pendant la mission, périmètre
restreint par le client, authentification non fournie.

Un rapport sans limites déclarées laisse entendre une exhaustivité qui n'existe
jamais. **Un test d'intrusion ne démontre pas l'absence de vulnérabilité** — il
constate ce qui a été trouvé, dans un périmètre et une durée donnés.

## Une fiche de constat

Chaque constat est autoportant, parce qu'il sera lu seul, extrait du rapport et
collé dans un ticket.

| Champ | Contenu |
|---|---|
| **Identifiant** | Stable, référençable dans les échanges et les tickets |
| **Intitulé** | Factuel et précis, en une ligne |
| **Gravité** | Avec la justification du niveau retenu |
| **Actif concerné** | Système, application, composant |
| **Constat** | Ce qui a été observé, objectivement |
| **Impact** | Conséquence **métier** si exploité, pas la conséquence technique |
| **Conditions d'exploitation** | Prérequis d'accès, de privilèges, de position réseau |
| **Preuve** | Élément probant, **expurgé** des données réelles |
| **Recommandation** | Actionnable, et chiffrée en effort |
| **Référence** | CWE, mesure ISO/IEC 27001, OWASP |

### Impact technique et impact métier

C'est la distinction qui fait la différence entre un rapport lu et un rapport
classé.

| Formulation technique | Formulation métier |
|---|---|
| « Contrôle d'accès insuffisant sur un point d'entrée » | « Un utilisateur authentifié peut consulter les dossiers des autres clients, ce qui constitue une violation de données au sens du RGPD » |
| « Chiffrement du transport obsolète » | « Les échanges peuvent être interceptés sur un réseau partagé, exposant les identifiants de connexion » |
| « Absence de journalisation » | « Une intrusion ne serait pas détectée, et son périmètre ne pourrait pas être établi après coup » |

La colonne de droite déclenche un budget. Celle de gauche déclenche un « on
verra ».

### Les preuves : ce qu'on n'y met pas

- **Pas de données personnelles réelles.** Masquer, tronquer, remplacer.
- **Pas de secrets en clair** — identifiants, jetons, clés. On atteste de leur
  exposition, on ne les reproduit pas.
- **Pas plus que nécessaire** pour établir le constat.

Le rapport circule, est transmis à des tiers, parfois à un assureur ou à un
auditeur. Tout ce qu'il contient doit pouvoir circuler.

## Coter la gravité sans se tromper

Deux approches, et il faut dire laquelle on utilise :

- **CVSS**, utile pour les vulnérabilités de composants identifiés. Sa limite est
  connue : il mesure une gravité technique intrinsèque, pas un risque contextuel.
  Si on l'emploie, renseigner les métriques **environnementales**, sinon le score
  ignore l'exposition réelle et la criticité de l'actif.
- **Grille propre** croisant impact métier et facilité d'exploitation. Plus adaptée
  aux défauts logiques et aux problèmes d'architecture, que CVSS cote mal.

Dans les deux cas, la gravité doit être **justifiée en une phrase**. Une cotation
non argumentée est le premier point que le client contestera, et il aura raison de
le faire.

| Niveau | Lecture attendue par la direction |
|---|---|
| Critique | À traiter sans attendre la fin du projet en cours |
| Élevé | À planifier dans les semaines qui viennent |
| Moyen | À intégrer au cycle de correction normal |
| Faible | À traiter si l'occasion se présente |
| Information | Pas un défaut, mais à connaître |

Si tout est critique, rien ne l'est : l'inflation de gravité détruit la crédibilité
du rapport et la capacité du client à prioriser.

## Le plan de remédiation

C'est la partie que le client utilisera réellement. Elle croise la gravité avec
l'effort :

| | Effort faible | Effort élevé |
|---|---|---|
| **Gravité élevée** | À faire immédiatement | À planifier, avec mesure compensatoire en attendant |
| **Gravité faible** | À faire au passage | À documenter comme risque accepté |

La case la plus utile est « gravité élevée, effort élevé » : c'est là qu'on propose
une **mesure compensatoire** — segmentation, restriction d'accès, règle de
détection — en attendant la correction de fond. Un prestataire qui ne propose que
la correction idéale laisse le client sans solution à court terme.

## Référentiels méthodologiques

À citer dans la section méthodologie, parce qu'ils rendent la démarche opposable
et comparable d'une année sur l'autre :

| Référentiel | Objet |
|---|---|
| **PTES** | Cadre général d'un test d'intrusion, du cadrage au rapport |
| **OWASP WSTG** | Guide de test des applications web |
| **OWASP ASVS** | Niveaux d'exigence de sécurité applicative, utile en référentiel de conformité |
| **NIST SP 800-115** | Guide d'évaluation technique de la sécurité de l'information |
| **OSSTMM** | Méthodologie de test, approche par métriques |
| **PASSI** | Qualification ANSSI des prestataires d'audit de la sécurité des systèmes d'information |

La **qualification PASSI** est le cadre français de référence pour les prestataires
d'audit, et elle structure fortement les attentes de livrable dans le secteur
public et chez les opérateurs régulés.

## Niveaux d'information et types d'évaluation

Vocabulaire à employer correctement, parce que le client ne comprend pas toujours
ce qu'il achète :

| Terme | Ce que c'est |
|---|---|
| **Boîte noire** | Sans information préalable |
| **Boîte grise** | Avec un accès ou une documentation partielle |
| **Boîte blanche** | Avec accès complet, documentation et code |
| **Scan de vulnérabilités** | Automatisé, large, peu profond ; ce n'est **pas** un test d'intrusion |
| **Test d'intrusion** | Évaluation ciblée avec validation manuelle, sur un périmètre et une durée définis |
| **Audit de configuration** | Comparaison d'une configuration à un référentiel |
| **Audit de code** | Revue du code source |
| **Red team** | Simulation d'adversaire sur objectifs, dans la durée, sans périmètre technique étroit |

Confondre scan et test d'intrusion est l'erreur commerciale classique. Le premier
produit une liste, le second produit un avis argumenté.

## La restitution orale

Souvent plus déterminante que le document. Trois règles :

1. **Commencer par la conclusion.** Le niveau d'exposition global, puis les deux ou
   trois choses à retenir.
2. **Ne pas humilier les équipes.** Un rapport reçu comme une accusation ne sera
   pas appliqué. On parle de défauts de système, pas de fautes de personnes.
3. **Finir par ce qui fonctionne.** Les mesures qui ont effectivement résisté
   méritent d'être citées : c'est factuel, et ça permet de ne pas démonter ce qui
   protège réellement lors de la prochaine réorganisation.

## Points d'examen fréquents

**Pourquoi une synthèse séparée du détail ?** Parce que les deux lecteurs ont des
besoins incompatibles. La synthèse doit être compréhensible sans le détail.

**Un test d'intrusion prouve-t-il qu'un système est sûr ?** Non, jamais. Il constate
ce qui a été trouvé dans un périmètre et une durée donnés. C'est pour cela que la
section « limites » est obligatoire.

**Scan ou test d'intrusion ?** Le scan est automatisé et large, le test ajoute la
validation manuelle, le contexte et l'argumentation. Les vendre pour équivalents
est une faute professionnelle.

**Impact technique ou impact métier ?** Les deux, mais c'est le second qui déclenche
la correction et le budget.

## Sources

- PTES — *Penetration Testing Execution Standard*
- OWASP — *Web Security Testing Guide* et *Application Security Verification Standard*
- NIST SP 800-115 — *Technical Guide to Information Security Testing and Assessment*
- ANSSI — référentiel d'exigences **PASSI**
- FIRST — spécification CVSS 4.0, pour la cotation et ses limites
