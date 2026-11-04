# NIS2 — Directive sur la sécurité des réseaux et des systèmes d'information

**Directive (UE) 2022/2555** du 14 décembre 2022, qui remplace la directive NIS de
2016. Échéance de transposition par les États membres : **17 octobre 2024**.

> **État de la transposition française au 4 novembre 2026 : non achevée.**
> Voir la section dédiée plus bas — c'est un point à vérifier avant tout examen,
> parce qu'il évolue.

Une directive, contrairement à un règlement comme le RGPD, doit être **transposée**
en droit national. Tant que la loi, les décrets et les arrêtés ne sont pas publiés,
les obligations ne sont pas opposables en France.

## Ce que NIS2 change par rapport à NIS1

| Aspect | NIS1 (2016) | NIS2 (2022) |
|---|---|---|
| Périmètre | Opérateurs désignés par l'État, quelques centaines en France | Entités définies par secteur et par taille, environ **15 000** estimées en France |
| Désignation | Par décision administrative individuelle | **Auto-identification** par l'entité au regard des critères |
| Secteurs | 7 secteurs | 18 secteurs, répartis en « hautement critiques » et « critiques » |
| Chaîne d'approvisionnement | Peu traitée | Obligation explicite de prise en compte |
| Direction | Peu impliquée | **Responsabilité des organes de direction**, et formation obligatoire |
| Sanctions | Variables selon les États | Plafonds harmonisés, voir plus bas |

Le changement de nature le plus important est l'auto-identification : il
n'appartient plus à l'État de dire à une entreprise qu'elle est concernée, c'est à
elle de le déterminer. Ne pas s'être identifié n'est pas une excuse.

## Deux catégories d'entités

| Catégorie | Qui | Régime de contrôle |
|---|---|---|
| **Entités essentielles** (EE) | Grandes entités des secteurs hautement critiques, et certaines entités quelle que soit leur taille | Supervision **proactive** : contrôles possibles sans incident préalable |
| **Entités importantes** (EI) | Les autres entités dans le champ | Supervision **réactive** : contrôle déclenché par un manquement ou un incident |

Les seuils de taille reprennent la définition européenne : moyenne entreprise à
partir de 50 salariés ou 10 M€ de chiffre d'affaires, grande entreprise à partir de
250 salariés ou 50 M€. Certaines entités sont concernées indépendamment de leur
taille, notamment les fournisseurs de services de communications électroniques, les
prestataires de services de confiance et les administrations.

## Les secteurs couverts

**Hautement critiques** : énergie, transports, banque, infrastructures de marchés
financiers, santé, eau potable, eaux usées, infrastructure numérique, gestion des
services TIC interentreprises, administration publique, espace.

**Critiques** : services postaux et d'expédition, gestion des déchets, fabrication
et distribution de produits chimiques, production et distribution de denrées
alimentaires, fabrication (dispositifs médicaux, informatique, électronique,
machines, véhicules), fournisseurs numériques, recherche.

## Les obligations : les dix mesures de l'article 21

L'article 21 impose des mesures « appropriées et proportionnées », et en énumère
dix, qu'il faut savoir citer :

1. Politiques d'analyse des risques et de sécurité des systèmes d'information.
2. Gestion des incidents.
3. Continuité des activités, gestion des sauvegardes, reprise après sinistre, gestion de crise.
4. **Sécurité de la chaîne d'approvisionnement**, y compris les relations avec les fournisseurs directs.
5. Sécurité de l'acquisition, du développement et de la maintenance, dont la gestion et la divulgation des vulnérabilités.
6. Politiques d'évaluation de l'efficacité des mesures.
7. Pratiques d'**hygiène informatique de base** et formation à la cybersécurité.
8. Politiques relatives à l'usage de la **cryptographie** et, le cas échéant, du chiffrement.
9. Sécurité des ressources humaines, politique de contrôle d'accès, gestion des actifs.
10. **Authentification multifacteur**, communications sécurisées (voix, vidéo, texte), communications d'urgence sécurisées.

## Notification d'incident : les trois échéances (article 23)

Le découpage en trois temps est un point d'examen quasi systématique.

| Échéance | Délai | Contenu |
|---|---|---|
| **Alerte précoce** | **24 heures** | Signalement initial : suspicion d'acte illicite ou d'effet transfrontalier |
| **Notification d'incident** | **72 heures** | Évaluation initiale : gravité, impact, indicateurs de compromission |
| **Rapport final** | **1 mois** après la notification | Description détaillée, cause, mesures d'atténuation, impacts transfrontaliers |

Un **rapport intermédiaire** peut être demandé si l'incident est toujours en cours
au bout d'un mois. Le déclencheur est l'**incident important**, c'est-à-dire celui
qui cause une perturbation opérationnelle grave ou des pertes financières, ou qui
affecte d'autres personnes par des dommages considérables.

Ne pas confondre avec le RGPD : 72 heures pour notifier la CNIL d'une violation de
données personnelles, sans alerte à 24 heures. Un même incident peut relever des
deux régimes, avec deux destinataires et deux calendriers.

## Sanctions

| Catégorie | Plafond |
|---|---|
| Entités **essentielles** | 10 M€ ou **2 %** du chiffre d'affaires annuel mondial, le montant le plus élevé |
| Entités **importantes** | 7 M€ ou **1,4 %** du chiffre d'affaires annuel mondial, le montant le plus élevé |

La directive prévoit en outre la possibilité d'engager la **responsabilité des
dirigeants**, et de suspendre temporairement un dirigeant de ses fonctions dans les
cas les plus graves pour les entités essentielles. C'est une rupture : la
cybersécurité devient un sujet de responsabilité personnelle au niveau de la
direction.

## La transposition française

Le véhicule législatif est le **projet de loi relatif à la résilience des
infrastructures critiques et au renforcement de la cybersécurité**, qui transpose
simultanément trois textes européens du 14 décembre 2022 : NIS2 (titre II), **DORA**
pour le secteur financier, et la directive **REC** sur la résilience des entités
critiques.

Chronologie, au 4 novembre 2026 :

| Date | Étape |
|---|---|
| 17 octobre 2024 | Échéance européenne de transposition, non respectée |
| 12 mars 2025 | Adoption du projet de loi par le **Sénat** |
| 17 mars 2026 | Publication par l'ANSSI du **Référentiel Cyber France (ReCyF)** |
| 8 juillet 2026 | Saisine de la **CJUE** par la Commission contre la France, avec demande de sanctions financières |
| Automne 2026 | Examen à l'Assemblée nationale, repoussé ; texte toujours en première lecture |

Le **ReCyF** traduit les obligations NIS2 en objectifs de sécurité — 20 pour les
entités essentielles, 15 pour les entités importantes. Il n'est pas obligatoire à ce
stade, mais permet aux futurs assujettis de se préparer et de s'en prévaloir.

L'ANSSI rappelle que NIS2 n'entrera en vigueur en France qu'une fois **l'ensemble**
des textes promulgué : la loi, puis les décrets et arrêtés d'application.

> Attention aux sources sur ce sujet : plusieurs guides commerciaux français
> affirment que la loi est adoptée et les décrets publiés. Ce n'est pas le cas.
> Vérifier sur **Légifrance** et sur le site de l'**Assemblée nationale**.

## Points d'examen fréquents

**Directive ou règlement ?** Directive, donc transposition nécessaire — c'est
exactement ce qui explique le retard français, alors que le RGPD s'est appliqué
partout le même jour.

**Qui désigne les entités concernées ?** Personne : elles s'auto-identifient selon
les critères de secteur et de taille.

**Les trois délais de notification ?** 24 heures pour l'alerte précoce, 72 heures
pour la notification, un mois pour le rapport final.

**Différence EE / EI ?** Le régime de supervision avant tout : proactif pour les
entités essentielles, réactif pour les importantes. Et des plafonds de sanction
distincts.

## Sources

- Directive (UE) 2022/2555 du 14 décembre 2022 (NIS2)
- ANSSI — dossier NIS2 et Référentiel Cyber France (ReCyF), mars 2026
- Projet de loi relatif à la résilience des infrastructures critiques et au renforcement de la cybersécurité
- Légifrance et Assemblée nationale, pour l'état d'avancement à jour
