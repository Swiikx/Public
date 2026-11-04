# ISO/IEC 27001 — Système de management de la sécurité de l'information

**Version en vigueur : ISO/IEC 27001:2022.** Norme certifiable, et la seule de la
famille 270xx qui le soit. Les autres sont des guides.

## Ce que la norme demande vraiment

Un SMSI n'est pas un catalogue de mesures techniques. C'est un **système de
management** : on démontre qu'on pilote la sécurité, qu'on sait pourquoi on a
choisi telles mesures, et qu'on vérifie qu'elles fonctionnent.

Le point d'examen classique : la certification porte sur le **processus**, pas sur
un niveau de sécurité absolu. Une organisation peu mature peut être certifiée si
elle a correctement identifié ses risques et assumé ses choix.

## Structure : les clauses 4 à 10

Les clauses 1 à 3 sont le domaine, les références et les termes. Les exigences
auditables commencent à 4.

| Clause | Intitulé | Ce qu'on doit produire |
|---|---|---|
| 4 | Contexte de l'organisation | Périmètre du SMSI, parties intéressées et leurs exigences |
| 5 | Leadership | Politique de sécurité, engagement de la direction, rôles et responsabilités |
| 6 | Planification | Appréciation et traitement du risque, **déclaration d'applicabilité**, objectifs |
| 7 | Support | Ressources, compétences, sensibilisation, communication, informations documentées |
| 8 | Fonctionnement | Mise en œuvre du traitement du risque, maîtrise des processus |
| 9 | Évaluation des performances | Surveillance et mesure, **audit interne**, revue de direction |
| 10 | Amélioration | Non-conformités, actions correctives, amélioration continue |

Le cycle **PDCA** (Planifier, Déployer, Contrôler, Agir) structure l'ensemble :
4-6 planifient, 7-8 déploient, 9 contrôle, 10 agit.

## La déclaration d'applicabilité

En anglais *Statement of Applicability*, souvent abrégée **SoA**. Document central
de l'audit : pour chacune des mesures de l'Annexe A, on indique si elle est
retenue, et **on justifie**. Une exclusion n'est pas une faute, une exclusion non
justifiée en est une.

C'est le lien entre l'appréciation du risque et les mesures : on ne retient pas une
mesure parce qu'elle figure dans la norme, mais parce qu'un risque identifié la
rend nécessaire.

## Annexe A : 93 mesures, 4 thèmes

La révision 2022 a réorganisé les 114 mesures de l'édition 2013 en **93 mesures**
regroupées en 4 thèmes au lieu de 14 domaines.

| Thème | Nombre | Exemples |
|---|---|---|
| Organisationnelles | 37 | Politiques, rôles, gestion des actifs, relations fournisseurs, continuité |
| Liées aux personnes | 8 | Filtrage avant embauche, sensibilisation, discipline, fin de contrat |
| Physiques | 14 | Périmètres sécurisés, protection contre les menaces physiques, mise au rebut |
| Technologiques | 34 | Gestion des accès, cryptographie, journalisation, sécurité du développement |

**Onze mesures nouvelles** en 2022, qui reflètent l'évolution des pratiques :
veille sur les menaces, sécurité du cloud, continuité des TIC, surveillance
physique, gestion de la configuration, effacement et masquage des données,
prévention de la fuite de données, filtrage web, et codage sécurisé.

Chaque mesure porte cinq **attributs** pour permettre des vues transverses : type
de mesure (préventive, détective, corrective), propriété de sécurité (CID),
concept de cybersécurité, capacité opérationnelle, domaine de sécurité.

## La famille 270xx, et qui sert à quoi

| Norme | Rôle | Certifiable |
|---|---|---|
| **27001** | Exigences du SMSI | **Oui** |
| 27002 | Guide de mise en œuvre des mesures de l'Annexe A | Non |
| 27005 | Guide de gestion du risque de sécurité de l'information | Non |
| 27017 | Mesures pour les services en nuage | Non |
| 27018 | Protection des données personnelles dans le nuage public | Non |
| 27701 | Extension « vie privée » du SMSI, vers un SMIP | Oui, en extension de 27001 |
| 27035 | Gestion des incidents de sécurité | Non |

## CID, le socle

Trois propriétés à préserver, et c'est la grille d'analyse de tout incident :

- **Confidentialité** — l'information n'est accessible qu'aux personnes autorisées.
- **Intégrité** — l'information est exacte et complète, et n'a pas été altérée.
- **Disponibilité** — l'information est accessible quand elle est nécessaire.

On y ajoute souvent la **traçabilité** (ou imputabilité), nécessaire pour prouver
qui a fait quoi, et sans laquelle la réponse à incident est aveugle.

## Le parcours de certification

1. **Cadrage** — définition du périmètre, engagement de la direction.
2. **Appréciation du risque** et plan de traitement, puis rédaction de la SoA.
3. **Mise en œuvre** des mesures retenues, et production des preuves.
4. **Audit interne** et revue de direction : exigences des clauses 9.2 et 9.3, à
   réaliser **avant** l'audit externe.
5. **Audit de certification** en deux étapes : étape 1 sur la documentation,
   étape 2 sur la mise en œuvre réelle.
6. **Cycle de trois ans** : audits de surveillance annuels, recertification à
   l'échéance.

Les écarts constatés se classent en non-conformité **majeure** (bloquante) ou
**mineure** (à corriger avec un plan d'action), et en **opportunité
d'amélioration**, qui n'est pas un écart.

## Points d'examen fréquents

**Pourquoi la SoA est-elle le document le plus regardé ?** Parce qu'elle prouve le
raisonnement : elle relie chaque mesure à un risque, et chaque exclusion à une
justification. C'est là qu'on voit si le SMSI est vécu ou s'il est de façade.

**Différence entre 27001 et 27002 ?** La 27001 dit *ce qu'il faut faire* et est
auditable ; la 27002 explique *comment* et ne l'est pas. On se certifie 27001, on
s'appuie sur 27002.

**L'Annexe A est-elle obligatoire dans son intégralité ?** Non. Il faut la
*considérer* intégralement, et justifier ce qu'on ne retient pas. La nuance est
exactement ce que vérifie l'auditeur.

## Sources

- ISO/IEC 27001:2022 — *Sécurité de l'information, cybersécurité et protection de la vie privée : systèmes de management de la sécurité de l'information, exigences*
- ISO/IEC 27002:2022 — mesures de sécurité de l'information
