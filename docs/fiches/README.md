# Fiches

Fiches de révision sur la sécurité des systèmes d'information. Un fichier par sujet,
pensé pour la relecture rapide : définitions, tableaux, points d'examen.

## Périmètre

Ces fiches couvrent la **défense, la gouvernance et la conformité** : normes,
cadres réglementaires, détection, réponse à incident, gestion des vulnérabilités,
cryptographie appliquée.

Elles couvrent aussi la **pratique professionnelle du test d'intrusion** : ce qui
rend une mission licite, et ce qui en fait un livrable utile.

Elles ne contiennent **pas** de méthodologie offensive opérationnelle — ni
procédures d'exploitation, ni charges utiles. Ce n'est pas une lacune : un dépôt
public n'est pas l'endroit pour cela, et sur une mission réelle, ce qui sépare un
intervenant d'un technicien n'est pas le catalogue de techniques, c'est le cadre
juridique, l'arbitrage et la restitution.

## Index

### Gouvernance et conformité

| Fiche | Sujet |
|---|---|
| [ISO/IEC 27001 — SMSI](iso-27001-smsi.md) | Système de management de la sécurité de l'information, structure, Annexe A, certification |
| [ISO/IEC 27005 — gestion du risque](iso-27005-gestion-du-risque.md) | Appréciation et traitement du risque, articulation avec 27001 et 31000 |
| [ISO 22301 — continuité d'activité](iso-22301-continuite.md) | SMCA, bilan d'impact, RTO et RPO, plans de continuité et de reprise |
| [RGPD](rgpd.md) | Principes, bases légales, droits, violations de données, AIPD, sanctions |
| [NIS2](nis2.md) | Directive, entités concernées, obligations, état de la transposition française |

### Pratique professionnelle du test d'intrusion

| Fiche | Sujet |
|---|---|
| [Cadre légal et contractuel](cadre-legal-test-intrusion.md) | Articles 323-1 et suivants, mandat d'autorisation, périmètre, règles d'engagement, responsabilité |
| [Rapport et communication du risque](rapport-test-intrusion.md) | Structure du livrable, fiche de constat, cotation, plan de remédiation, restitution |
| [Python — développement sécurisé](python-developpement-securise.md) | Pièges du langage, secrets, journalisation, dépendances, outillage CI |

### Défense et opérations

| Fiche | Sujet |
|---|---|
| [Réponse à incident](reponse-a-incident.md) | Cycle de vie, qualification, confinement, éradication, retour d'expérience |
| [SOC, journalisation et détection](soc-journalisation-detection.md) | Rôle du SOC, sources de journaux, SIEM, cas d'usage, couverture ATT&CK |
| [Vulnérabilités : CVE, CWE, CVSS](vulnerabilites-cve-cvss.md) | Identifier, classer, prioriser, et les limites du score |
| [Cryptographie appliquée](cryptographie-appliquee.md) | Primitives, choix d'algorithmes, TLS, PKI, post-quantique |

Voir aussi le [glossaire](../cheatsheets/glossaire-cyber.md) pour les sigles.

## Conventions

Chaque fiche indique ses sources normatives. Les versions des normes et les
références réglementaires sont datées : en conformité, une fiche sans date est une
fiche périmée sans qu'on le sache.

Dernière revue d'ensemble : **novembre 2026**.
