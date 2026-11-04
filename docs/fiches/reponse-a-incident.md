# Réponse à incident

Cadres de référence : **NIST SP 800-61**, **ISO/IEC 27035**, et les guides de
l'**ANSSI** sur la gestion de crise cyber.

## Événement, alerte, incident

Trois mots qu'on emploie souvent indifféremment, et qu'un jury distingue :

| Terme | Définition |
|---|---|
| **Événement** | Tout fait observable sur un système. Une authentification réussie en est un. |
| **Alerte** | Un événement, ou une corrélation d'événements, qui déclenche un signalement. |
| **Incident** | Un événement qui porte effectivement atteinte à la confidentialité, l'intégrité ou la disponibilité, ou qui viole la politique de sécurité. |

Conséquence : **toute alerte n'est pas un incident**. Le travail de qualification
consiste précisément à trancher, et le taux de faux positifs d'un SOC se mesure là.

## Le cycle de vie

Le modèle du NIST en quatre phases, le plus cité :

| Phase | Contenu |
|---|---|
| **1. Préparation** | Procédures, outillage, journalisation, contacts, exercices, sauvegardes testées |
| **2. Détection et analyse** | Collecte des signaux, qualification, périmètre de la compromission |
| **3. Confinement, éradication, rétablissement** | Arrêter la progression, supprimer la cause, remettre en service |
| **4. Activité post-incident** | Retour d'expérience, correction des causes profondes, mise à jour des procédures |

Le modèle **SANS** découpe la même chose en six étapes : préparation,
identification, confinement, éradication, rétablissement, leçons apprises. Les deux
sont équivalents ; le découpage en six sépare juste plus finement la phase 3.

La révision 3 de SP 800-61, publiée en 2025, réaligne la démarche sur les fonctions
du **NIST Cybersecurity Framework 2.0** (Gouverner, Identifier, Protéger, Détecter,
Répondre, Rétablir) plutôt que sur un cycle en phases. Citer la version qu'on
utilise est préférable à mélanger les deux.

## Préparation : ce qui se joue avant

C'est la phase la plus déterminante, et la seule qu'on puisse mener sereinement.

- **Journalisation effective** et conservée assez longtemps. Sans journaux, on ne
  peut pas établir le périmètre : on ne sait ni depuis quand, ni jusqu'où.
- **Sauvegardes testées**, dont une copie hors ligne ou immuable.
- **Annuaire de crise** : qui appelle qui, en dehors des heures ouvrées, et par quel
  canal si la messagerie est compromise.
- **Canal de communication de secours**, indépendant du système d'information.
- **Procédures écrites** pour les scénarios les plus probables.
- **Exercices** réguliers, au minimum sur table.

## Qualification : les questions à poser

| Question | Pourquoi |
|---|---|
| Quels systèmes, quelles données ? | Détermine la gravité et les obligations réglementaires |
| Depuis quand ? | Conditionne le périmètre et la fenêtre de journaux à examiner |
| L'accès est-il toujours actif ? | Change l'urgence du confinement |
| Des données personnelles sont-elles concernées ? | Déclenche l'horloge RGPD de 72 heures |
| L'entité est-elle assujettie à NIS2 ? | Déclenche l'alerte précoce à 24 heures, une fois la transposition en vigueur |
| Y a-t-il un risque de propagation à des tiers ? | Obligation d'information, et responsabilité |

## Confinement : l'arbitrage central

Confiner vite limite les dégâts, mais détruit des preuves et alerte l'attaquant.
C'est une **décision de direction**, pas un réflexe technique.

| Option | Avantage | Inconvénient |
|---|---|---|
| Isolement réseau d'un système | Rapide, arrête la propagation | L'attaquant sait qu'il est détecté |
| Désactivation de comptes | Coupe l'accès identifié | Insuffisant si des accès persistants existent |
| Surveillance prolongée avant action | Permet de cartographier l'ensemble de l'intrusion | Le risque continue pendant ce temps |
| Extinction d'une machine | Arrêt immédiat | **Détruit la mémoire vive**, donc des preuves |

Règle de préservation : **collecter avant d'agir** quand c'est possible. L'ordre de
volatilité va du plus fragile au plus durable — mémoire vive, connexions réseau
actives, processus en cours, système de fichiers, puis journaux centralisés et
sauvegardes.

## Éradication et rétablissement

L'éradication traite la **cause**, pas le symptôme. Remettre en service un système
sans avoir corrigé le point d'entrée garantit la récidive.

Deux règles qui reviennent en retour d'expérience :

- **Réinstaller plutôt que nettoyer**, à partir d'une source saine, dès que la
  compromission est sérieuse. On ne prouve pas l'absence d'une porte dérobée.
- **Renouveler les secrets** : mots de passe, clés, jetons, certificats, secrets
  d'application. Tout ce qui a pu être lu doit être considéré comme compromis.

Le rétablissement se fait par ordre de criticité métier, ce qui suppose de connaître
cet ordre — c'est le lien direct avec le BIA de la continuité d'activité.

## Post-incident : la seule phase qu'on saute

Le retour d'expérience doit produire des **actions datées et assignées**, sinon il
ne sert à rien. Deux questions à distinguer :

- **Causes immédiates** — par où est-on entré, qu'est-ce qui a échoué ?
- **Causes profondes** — pourquoi cette faiblesse existait-elle, et pourquoi n'a-t-on
  pas détecté plus tôt ?

La seconde est la plus utile et la plus inconfortable. Une culture qui cherche un
responsable plutôt qu'une cause n'obtient plus d'informations fiables lors de
l'incident suivant.

## Obligations de notification : vue d'ensemble

| Régime | Destinataire | Délai | Déclencheur |
|---|---|---|---|
| **RGPD** | CNIL | 72 h après prise de connaissance | Violation de données personnelles, sauf risque improbable |
| **RGPD** | Personnes concernées | Dans les meilleurs délais | Risque **élevé** pour les droits et libertés |
| **NIS2** | Autorité nationale | 24 h (alerte), 72 h (notification), 1 mois (rapport) | Incident important, après transposition |
| Assurance cyber | Assureur | Selon contrat, souvent très court | Clause contractuelle |
| Plainte | Police ou gendarmerie | — | Recommandée, et souvent exigée par l'assureur |

## Points d'examen fréquents

**Pourquoi ne pas éteindre la machine ?** Parce que la mémoire vive contient des
preuves volatiles — processus, connexions, éléments en clair — définitivement
perdues à l'extinction.

**Confiner immédiatement ou observer ?** Les deux sont défendables. Ce qui est
évalué, c'est la capacité à exposer l'arbitrage et à dire qui décide.

**Quelle phase est la plus importante ?** La préparation. C'est la seule qui se
mène sans pression, et elle détermine ce qu'on pourra faire pendant les autres.

## Sources

- NIST SP 800-61 — *Computer Security Incident Handling Guide* (r2), et r3 alignée sur le CSF 2.0
- NIST Cybersecurity Framework 2.0
- ISO/IEC 27035 — gestion des incidents de sécurité de l'information
- ANSSI — guides sur la gestion de crise d'origine cyber
