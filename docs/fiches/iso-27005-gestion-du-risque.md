# ISO/IEC 27005 — Gestion du risque de sécurité de l'information

**Version en vigueur : ISO/IEC 27005:2022.** Guide, non certifiable. Elle explique
comment satisfaire les clauses 6.1.2 et 6.1.3 d'ISO/IEC 27001, qui exigent
d'apprécier et de traiter le risque sans dire comment.

## Articulation des trois normes

| Norme | Rôle |
|---|---|
| **ISO 31000** | Principes et cadre généraux du management du risque, tous risques confondus |
| **ISO/IEC 27005** | Déclinaison au risque de sécurité de l'information |
| **ISO/IEC 27001** | Exige une gestion du risque, sans imposer de méthode |

Conséquence pratique : **27001 n'impose aucune méthode**. On peut utiliser 27005,
EBIOS Risk Manager, FAIR ou une méthode interne, à condition que la démarche soit
reproductible, documentée et cohérente d'une itération à l'autre.

## Vocabulaire, et les confusions à éviter

| Terme | Définition | Confusion fréquente |
|---|---|---|
| **Actif** | Ce qui a de la valeur pour l'organisation | Un actif n'est pas qu'un serveur : un processus, une donnée, une réputation en sont |
| **Menace** | Cause potentielle d'un incident non désiré | La menace est externe au système, la vulnérabilité y est interne |
| **Vulnérabilité** | Faiblesse exploitable par une menace | Une vulnérabilité sans menace associée ne produit pas de risque |
| **Risque** | Effet de l'incertitude sur les objectifs | Pas un synonyme de menace ni de vulnérabilité |
| **Impact** | Conséquence si le risque se réalise | À exprimer en termes métier, pas techniques |
| **Vraisemblance** | Probabilité de réalisation | En français, préférée à « probabilité » qui suppose un calcul |
| **Risque résiduel** | Risque subsistant après traitement | Il n'est jamais nul, et doit être **accepté formellement** |

La formule mentale : **risque = vraisemblance × impact**, une menace exploitant une
vulnérabilité sur un actif. Utile pour comprendre, insuffisante pour décider.

## Le processus

### 1. Établissement du contexte

Périmètre, critères de risque, échelles. C'est l'étape la plus souvent bâclée, et
elle détermine tout le reste : des échelles mal construites rendent l'appréciation
inexploitable.

On fixe notamment les **critères d'acceptation** : à partir de quel niveau un
risque doit-il être traité, et qui a autorité pour l'accepter.

### 2. Appréciation du risque

Trois sous-étapes, dans cet ordre :

| Étape | Question |
|---|---|
| **Identification** | Quels risques pèsent sur quels actifs, par quelles menaces et vulnérabilités ? |
| **Analyse** | Quelle vraisemblance, quel impact, donc quel niveau ? |
| **Évaluation** | Ce niveau est-il acceptable au regard des critères, et comment se classe-t-il ? |

Deux approches, à ne pas confondre :

- **Par les actifs** — on part de l'inventaire. Exhaustif, mais vite ingérable.
- **Par les scénarios** (ou par les événements) — on part des événements redoutés
  métier, puis on remonte aux actifs concernés. Approche privilégiée par
  l'édition 2022 et par EBIOS RM, parce qu'elle reste lisible par la direction.

### 3. Traitement du risque

Quatre options, et les retenir par leur nom exact est un classique d'examen :

| Option | Principe | Exemple |
|---|---|---|
| **Réduire** (ou modifier) | Agir sur la vraisemblance ou l'impact | Durcir une configuration, segmenter, sauvegarder |
| **Partager** (ou transférer) | Faire porter une partie par un tiers | Assurance cyber, externalisation contractuelle |
| **Éviter** (ou refuser) | Supprimer la source du risque | Arrêter le service, ne pas collecter la donnée |
| **Accepter** (ou conserver) | Assumer le risque en connaissance de cause | Risque résiduel faible, décision tracée |

Le transfert a une limite qu'on oublie : **la responsabilité juridique ne se
transfère pas**. Un sous-traitant peut héberger, le responsable de traitement reste
responsable au sens du RGPD.

### 4. Acceptation, communication, surveillance

L'acceptation du risque résiduel est une **décision de la direction**, pas de
l'équipe sécurité. Elle se trace nommément. La surveillance est continue, car le
contexte, les menaces et les actifs changent.

## Quantitatif ou qualitatif

| Approche | Avantages | Limites |
|---|---|---|
| **Qualitative** (échelles faible/moyen/élevé) | Rapide, lisible, ne demande pas de données historiques | Subjective, comparaisons fragiles, additions interdites |
| **Quantitative** (pertes en euros, fréquences) | Permet l'arbitrage budgétaire et le calcul de retour sur investissement | Exige des données rarement disponibles, fausse précision |
| **Semi-quantitative** | Compromis courant : échelles ordonnées avec bornes chiffrées | Hérite d'une partie des défauts des deux |

En pratique la majorité des organisations travaillent en qualitatif ou
semi-quantitatif. Le piège est de faire de l'arithmétique sur des échelles
qualitatives : un « 3 » sur une échelle ordinale ne vaut pas trois fois un « 1 ».

## EBIOS Risk Manager, en un mot

Méthode de l'ANSSI, articulée en cinq ateliers, orientée scénarios et intentions
des attaquants. Elle est compatible avec ISO/IEC 27005 et reconnue comme méthode
d'appréciation du risque dans un SMSI. C'est la référence usuelle en France,
notamment dans le secteur public.

## Points d'examen fréquents

**Pourquoi l'édition 2022 privilégie-t-elle les scénarios ?** Parce qu'une
appréciation partant de l'inventaire des actifs produit des centaines de lignes
illisibles, là où une dizaine d'événements redoutés métier se discutent en comité
de direction.

**Le risque résiduel peut-il être nul ?** Non. Prétendre l'annuler signale une
appréciation mal faite, ou un périmètre tronqué.

**Qui accepte un risque ?** La direction, formellement et nominativement. Si c'est
l'équipe sécurité qui accepte, la gouvernance est défaillante.

## Sources

- ISO/IEC 27005:2022 — *Préconisations pour la gestion des risques liés à la sécurité de l'information*
- ISO 31000:2018 — *Management du risque, lignes directrices*
- ANSSI — méthode EBIOS Risk Manager
