# Docs

Notes, fiches et ressources. Tout en Markdown, un fichier par sujet.

| Dossier | Contenu | Format attendu |
|---|---|---|
| [`fiches/`](fiches/) | Fiches de révision par sujet | Synthèse structurée : définitions, schémas, points d'examen |
| [`cheatsheets/`](cheatsheets/) | Mémos de commandes | Tableaux commande → effet, orientés copier-coller |
| [`veille/`](veille/) | Veille technique | Daté, avec la source en lien et ce qui change concrètement |
| [`comptes-rendus/`](comptes-rendus/) | Comptes rendus de TP, write-ups, labs sécu | Contexte → démarche → résultat → ce qui a coincé |

## Index

### Fiches

Index détaillé et périmètre dans [`fiches/README.md`](fiches/README.md).

**Gouvernance et conformité**

- [ISO/IEC 27001 — SMSI](fiches/iso-27001-smsi.md) — structure, Annexe A, déclaration d'applicabilité, certification.
- [ISO/IEC 27005 — gestion du risque](fiches/iso-27005-gestion-du-risque.md) — appréciation, traitement, risque résiduel.
- [ISO 22301 — continuité d'activité](fiches/iso-22301-continuite.md) — BIA, RTO, RPO, PCA et PRA.
- [RGPD](fiches/rgpd.md) — principes, bases légales, droits, violations, AIPD, sanctions.
- [NIS2](fiches/nis2.md) — entités concernées, obligations, délais de notification, transposition française.

**Défense et opérations**

- [Réponse à incident](fiches/reponse-a-incident.md) — cycle de vie, confinement, éradication, retour d'expérience.
- [SOC, journalisation et détection](fiches/soc-journalisation-detection.md) — sources de journaux, SIEM, cas d'usage, couverture ATT&CK.
- [Vulnérabilités : CVE, CWE, CVSS](fiches/vulnerabilites-cve-cvss.md) — identifier, classer, prioriser.
- [Cryptographie appliquée](fiches/cryptographie-appliquee.md) — primitives, choix d'algorithmes, TLS, PKI, post-quantique.

### Cheatsheets

- [Glossaire cybersécurité](cheatsheets/glossaire-cyber.md) — sigles, principes, et les confusions courantes.
- [Git](cheatsheets/git.md) — commandes du quotidien et sorties de secours.

### Veille

_À venir._

### Comptes rendus

_À venir._

## Conventions

- Nom de fichier en minuscules sans accents : `reseau-vlan.md`, pas `Réseau VLAN.md`.
- Un titre `#` en haut du fichier, qui correspond au sujet.
- Les comptes rendus sont préfixés par la date : `2026-01-15-htb-devvortex.md`.
- Pour les write-ups sécu : uniquement des cibles pour lesquelles on est autorisé (labs, CTF, plateformes d'entraînement, périmètre d'un engagement). Pas d'IP ni de credentials réels, même « expirés » — voir [`CONVENTIONS.md`](../CONVENTIONS.md).
- Mettre à jour l'index ci-dessus en ajoutant un fichier.
