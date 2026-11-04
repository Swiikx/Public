# ISO 22301 — Continuité d'activité

**Version en vigueur : ISO 22301:2019.** Norme certifiable, qui définit les
exigences d'un **système de management de la continuité d'activité** (SMCA).
ISO 22313 en est le guide de mise en œuvre.

## De quoi on parle

La continuité d'activité ne traite pas de la sécurité de l'information mais de la
**capacité à continuer à fournir ses activités essentielles** après une
perturbation, quelle qu'en soit la cause : cyberattaque, incendie, panne
fournisseur, pandémie, indisponibilité du personnel.

Le recoupement avec la sécurité est réel : la disponibilité est l'un des trois
piliers du CID, et ISO/IEC 27001 contient une mesure dédiée à la continuité des
TIC. Mais 22301 raisonne **activités métier**, pas systèmes.

## Le bilan d'impact sur l'activité

Le **BIA** (*Business Impact Analysis*) est le cœur de la démarche. Il répond à une
seule question : si cette activité s'arrête, à partir de quand et à quel point
est-ce grave ?

Il produit la hiérarchisation des activités, et c'est elle qui justifie les budgets.
Sans BIA, un plan de continuité est une liste d'intentions.

## Les quatre durées à ne jamais confondre

C'est le point d'examen le plus fréquent de cette norme.

| Sigle | Nom | Définition | Mesure quoi |
|---|---|---|---|
| **RTO** | *Recovery Time Objective* | Durée cible de rétablissement d'une activité | Le **temps** acceptable d'indisponibilité |
| **RPO** | *Recovery Point Objective* | Perte de données maximale admissible | Le **volume de données** qu'on accepte de perdre |
| **MTPD** | *Maximum Tolerable Period of Disruption* | Durée au-delà de laquelle les effets deviennent inacceptables | La **limite absolue**, que le RTO doit respecter |
| **MBCO** | *Minimum Business Continuity Objective* | Niveau de service minimal à maintenir pendant la perturbation | Le **niveau dégradé** acceptable |

Deux règles qui tombent souvent :

- **Le RTO doit toujours être inférieur au MTPD.** Un RTO supérieur signifie que le
  plan garantit l'inacceptable.
- **RTO et RPO sont indépendants.** Un RPO de 15 minutes impose une réplication
  fréquente ; un RTO de 15 minutes impose une bascule rapide. On peut avoir l'un
  sans l'autre, et ils ne coûtent pas la même chose.

Exemple concret : une sauvegarde nocturne donne un RPO d'environ 24 heures, quelle
que soit la vitesse de restauration. Si le métier exige un RPO d'une heure, aucun
gain de RTO ne corrigera cela — il faut changer la stratégie de sauvegarde.

## PCA et PRA

| Plan | Portée | Question |
|---|---|---|
| **PCA** — plan de continuité d'activité | Organisation entière, activités métier | Comment continue-t-on à travailler, même en mode dégradé ? |
| **PRA** — plan de reprise d'activité | Systèmes d'information | Comment remet-on les systèmes en service, et dans quel ordre ? |

Le PRA est un **composant** du PCA, pas un synonyme. Un PRA qui restaure tous les
serveurs sans savoir lesquels portent les activités critiques restaure dans le
mauvais ordre.

## Structure du SMCA

Même ossature de haut niveau que les autres normes de management, donc intégrable
avec un SMSI ISO/IEC 27001 :

| Clause | Intitulé |
|---|---|
| 4 | Contexte de l'organisation |
| 5 | Leadership |
| 6 | Planification |
| 7 | Support |
| 8 | Fonctionnement — **BIA, appréciation du risque, stratégies, plans, exercices** |
| 9 | Évaluation des performances |
| 10 | Amélioration |

## Tester, sinon rien

Un plan non testé est une hypothèse. La norme exige un programme d'exercices, et
les niveaux se distinguent nettement :

| Type d'exercice | Ce qu'il valide | Coût et risque |
|---|---|---|
| Revue documentaire | Cohérence, contacts à jour | Faible |
| Exercice sur table | Compréhension des rôles, prise de décision | Faible |
| Test technique partiel | Restauration d'un système, bascule d'un service | Moyen |
| Bascule complète | Le plan en conditions réelles | Élevé, à préparer sérieusement |

Le test de restauration est le plus négligé : **une sauvegarde dont la restauration
n'a jamais été vérifiée ne compte pas comme une sauvegarde.** Les incidents par
rançongiciel l'ont démontré de façon répétée, y compris dans des organisations qui
sauvegardaient consciencieusement.

## Sauvegardes : la règle 3-2-1

Trois copies des données, sur deux supports différents, dont une hors site. Les
variantes modernes ajoutent une copie **immuable ou déconnectée**, précisément
parce qu'un rançongiciel cherche d'abord à détruire les sauvegardes accessibles
depuis le réseau.

## Points d'examen fréquents

**Différence RTO / RPO ?** Le RTO est une durée d'indisponibilité, le RPO un volume
de données perdues. Les confondre est l'erreur la plus classique.

**Pourquoi le BIA avant l'appréciation du risque ?** Parce qu'il faut savoir ce qui
est critique avant d'évaluer ce qui le menace. L'inverse conduit à protéger
uniformément.

**Le PRA suffit-il ?** Non. Il traite les systèmes. Si les locaux sont inaccessibles
ou le personnel indisponible, le PRA n'y répond pas — c'est l'objet du PCA.

## Sources

- ISO 22301:2019 — *Sécurité et résilience, systèmes de management de la continuité d'activité, exigences*
- ISO 22313:2020 — lignes directrices pour l'utilisation d'ISO 22301
- ISO/IEC 27031 — continuité des technologies de l'information et de la communication
