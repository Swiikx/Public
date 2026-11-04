# Glossaire cybersécurité

Sigles et termes qui reviennent en cours, en examen et en entretien. L'anglais est
donné quand c'est la forme usuelle dans les référentiels.

## Gouvernance, risque et conformité

| Sigle | Développé | Ce que c'est |
|---|---|---|
| **AIPD** | Analyse d'impact relative à la protection des données (*DPIA*) | Étude obligatoire avant un traitement à risque élevé, article 35 du RGPD |
| **BIA** | *Business Impact Analysis* | Bilan d'impact sur l'activité : quelles activités sont critiques, et à partir de quand |
| **CID** | Confidentialité, intégrité, disponibilité (*CIA*) | Les trois propriétés fondamentales à préserver |
| **DPO** | *Data Protection Officer* | Délégué à la protection des données |
| **GRC** | *Governance, Risk, Compliance* | La filière gouvernance, risque et conformité |
| **MBCO** | *Minimum Business Continuity Objective* | Niveau de service minimal à tenir pendant une perturbation |
| **MTPD** | *Maximum Tolerable Period of Disruption* | Durée au-delà de laquelle l'interruption devient inacceptable |
| **PCA / PRA** | Plan de continuité / de reprise d'activité | Le premier couvre le métier, le second les systèmes |
| **RPO** | *Recovery Point Objective* | Perte de **données** maximale admissible |
| **RTO** | *Recovery Time Objective* | **Durée** de rétablissement cible |
| **RSSI** | Responsable de la sécurité des systèmes d'information (*CISO*) | Porte la sécurité au niveau de la direction |
| **SMSI** | Système de management de la sécurité de l'information (*ISMS*) | L'objet d'ISO/IEC 27001 |
| **SoA** | *Statement of Applicability* | Déclaration d'applicabilité : quelles mesures sont retenues, et pourquoi |

## Réglementaire

| Sigle | Développé | Portée |
|---|---|---|
| **ANSSI** | Agence nationale de la sécurité des systèmes d'information | Autorité nationale française de cybersécurité |
| **CERT-FR** | *Computer Emergency Response Team* France | Centre gouvernemental de veille et de réponse, rattaché à l'ANSSI |
| **CNIL** | Commission nationale de l'informatique et des libertés | Autorité française de protection des données |
| **DORA** | *Digital Operational Resilience Act* | Résilience opérationnelle du secteur financier |
| **ENISA** | *European Union Agency for Cybersecurity* | Agence européenne de cybersécurité |
| **LPM** | Loi de programmation militaire | Régime français des opérateurs d'importance vitale |
| **NIS2** | Directive (UE) 2022/2555 | Sécurité des réseaux et systèmes, environ 15 000 entités en France |
| **OIV / OSE** | Opérateur d'importance vitale / de services essentiels | Régimes antérieurs, LPM et NIS1 |
| **REC** | Résilience des entités critiques | Directive sur la résilience physique |
| **RGPD** | Règlement général sur la protection des données (*GDPR*) | Règlement (UE) 2016/679 |

## Détection et réponse

| Sigle | Développé | Fonction |
|---|---|---|
| **CSIRT** | *Computer Security Incident Response Team* | Équipe de réponse aux incidents |
| **EDR** | *Endpoint Detection and Response* | Détection et réponse sur les postes et serveurs |
| **IDS / IPS** | *Intrusion Detection / Prevention System* | Détection, ou blocage, des intrusions réseau |
| **IOC** | *Indicator of Compromise* | Indicateur de compromission : empreinte, domaine, adresse |
| **MTTD / MTTR** | *Mean Time To Detect / Respond* | Délais moyens de détection et de réaction |
| **NDR** | *Network Detection and Response* | Détection sur les flux réseau |
| **SIEM** | *Security Information and Event Management* | Collecte, corrèle et alerte sur les journaux |
| **SOAR** | *Security Orchestration, Automation and Response* | Automatisation de la réponse |
| **SOC** | *Security Operations Center* | L'équipe qui surveille, détecte et réagit |
| **TTP** | *Tactics, Techniques and Procedures* | Façons de faire d'un attaquant, vocabulaire d'ATT&CK |
| **XDR** | *Extended Detection and Response* | Corrélation multi-périmètres ; terme commercial au contenu variable |

## Vulnérabilités

| Sigle | Développé | Rôle |
|---|---|---|
| **CNA** | *CVE Numbering Authority* | Organisme habilité à attribuer des identifiants CVE |
| **CVE** | *Common Vulnerabilities and Exposures* | Identifiant d'une vulnérabilité précise |
| **CVSS** | *Common Vulnerability Scoring System* | Score de gravité technique, de 0 à 10 |
| **CWE** | *Common Weakness Enumeration* | Catégorie de faiblesse de conception ou de codage |
| **EPSS** | *Exploit Prediction Scoring System* | Probabilité d'exploitation à 30 jours |
| **KEV** | *Known Exploited Vulnerabilities* | Catalogue CISA des vulnérabilités réellement exploitées |
| **SBOM** | *Software Bill of Materials* | Inventaire des composants d'un logiciel |

## Identité et accès

| Sigle | Développé | Principe |
|---|---|---|
| **IAM** | *Identity and Access Management* | Gestion des identités et des droits |
| **MFA** | *Multi-Factor Authentication* | Plusieurs facteurs : ce que l'on sait, possède, est |
| **PAM** | *Privileged Access Management* | Gestion des comptes à privilèges |
| **RBAC / ABAC** | Contrôle d'accès par rôle / par attribut | Deux modèles d'attribution des droits |
| **SSO** | *Single Sign-On* | Authentification unique pour plusieurs services |
| **ZTNA** | *Zero Trust Network Access* | Accès sans confiance implicite dans le réseau |

## Cryptographie

| Sigle | Développé | Usage |
|---|---|---|
| **AEAD** | *Authenticated Encryption with Associated Data* | Chiffrement et intégrité ensemble |
| **HSM** | *Hardware Security Module* | Module matériel de protection des clés |
| **KDF** | *Key Derivation Function* | Dérivation de clé ; Argon2id pour les mots de passe |
| **MAC** | *Message Authentication Code* | Intégrité et authenticité, **sans** non-répudiation |
| **PKI** | *Public Key Infrastructure* | Infrastructure à clés publiques |
| **PQC** | *Post-Quantum Cryptography* | Algorithmes résistants au calcul quantique |
| **TLS** | *Transport Layer Security* | Chiffrement du transport ; version courante 1.3 |

## Principes à savoir énoncer

| Principe | Énoncé |
|---|---|
| **Moindre privilège** | Chaque compte ne dispose que des droits nécessaires à sa fonction, et rien de plus |
| **Défense en profondeur** | Plusieurs barrières successives ; la défaillance de l'une ne suffit pas |
| **Séparation des tâches** | Une action sensible exige deux personnes distinctes |
| **Besoin d'en connaître** | L'accès à l'information est limité à ceux dont la mission l'exige |
| **Sécurité dès la conception** | La sécurité est intégrée au départ, pas ajoutée ensuite (article 25 du RGPD) |
| **Échec sécurisé** | En cas de panne, le système se place dans un état sûr, pas ouvert |
| **Confiance zéro** | Aucune confiance implicite accordée à un réseau ou à une position ; on vérifie à chaque accès |
| **Surface d'attaque** | On réduit ce qui est exposé : services, ports, droits, dépendances |

## Faux amis et confusions courantes

| On confond | Distinction |
|---|---|
| Menace / vulnérabilité | La menace est externe, la vulnérabilité interne au système |
| Risque / menace | Le risque combine vraisemblance et impact ; la menace n'en est qu'une composante |
| RTO / RPO | Durée d'indisponibilité contre volume de données perdues |
| Authentification / autorisation | Prouver qui l'on est, contre avoir le droit de faire |
| Chiffrement / codage / hachage | Réversible avec clé, réversible sans clé, à sens unique |
| Gravité / risque | CVSS mesure une gravité technique, pas un risque contextuel |
| PCA / PRA | Le métier contre les systèmes |
| SOC / CERT | Surveillance opérationnelle contre coordination de la réponse |
| Directive / règlement | La directive se transpose, le règlement s'applique directement |

Le dernier explique à lui seul pourquoi le RGPD s'est appliqué partout le 25 mai
2018, alors que NIS2 attend toujours sa loi de transposition en France.
