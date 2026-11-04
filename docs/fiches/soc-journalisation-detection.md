# SOC, journalisation et détection

Le **SOC** (*Security Operations Center*) est l'équipe chargée de surveiller,
détecter et réagir. Ce n'est pas un outil : un SIEM sans équipe ni procédures ne
constitue pas un SOC.

## Les niveaux et ce qu'ils font

| Niveau | Rôle | Sortie typique |
|---|---|---|
| **N1** | Tri des alertes, qualification de premier niveau, application des procédures | Clôture en faux positif, ou escalade |
| **N2** | Analyse approfondie, investigation, périmètre de la compromission | Qualification en incident, actions de confinement |
| **N3** | Expertise, investigation numérique, ingénierie de détection | Nouvelles règles, corrections de fond |
| **Threat intelligence** | Veille sur les menaces, indicateurs, contexte | Enrichissement des règles et des alertes |
| **Chasse aux menaces** | Recherche proactive sans alerte préalable | Détections que les règles ne couvraient pas |

La distinction qui compte : le SOC **détecte et réagit**, le CERT ou CSIRT
**coordonne la réponse** et peut couvrir plusieurs entités. En France, le CERT-FR
est rattaché à l'ANSSI.

## Journalisation : la condition de tout le reste

Sans journaux, il n'y a ni détection ni investigation. Le point aveugle le plus
fréquent n'est pas l'absence de SIEM, c'est l'absence de la source qui aurait
compté.

### Sources par ordre d'utilité

| Source | Ce qu'elle apporte |
|---|---|
| **Authentification** (annuaire, VPN, SSO) | Connexions réussies et échouées, origine, horaires inhabituels |
| **Postes de travail** (journaux système, EDR) | Exécution de processus, persistance, élévation de privilèges |
| **Résolution de noms** (DNS) | Contacts vers des domaines connus malveillants, exfiltration déguisée |
| **Proxy et pare-feu** | Flux sortants, volumes anormaux, destinations |
| **Serveurs applicatifs** | Accès aux données, erreurs répétées, comportements automatisés |
| **Messagerie** | Hameçonnage, pièces jointes, usurpation d'expéditeur |
| **Cloud et SaaS** | Journaux d'administration, créations de comptes, changements de droits |

### Les cinq règles de journalisation

1. **Horloge synchronisée** (NTP) partout. Sans référence de temps commune, la
   corrélation entre deux sources est impossible, et la chronologie d'un incident
   indéfendable.
2. **Centralisation**, pour qu'un attaquant qui compromet une machine ne puisse pas
   effacer la trace de son passage.
3. **Intégrité et accès restreint** : les journaux sont des preuves.
4. **Durée de conservation** définie, cohérente avec le délai moyen de détection —
   qui se compte souvent en semaines. Conserver sept jours revient à ne pas pouvoir
   investiguer.
5. **Journaliser ce qui sert** : la collecte exhaustive coûte cher et noie le signal.
   On part des scénarios à détecter, pas du volume disponible.

Attention au RGPD : les journaux contiennent des données personnelles
(identifiants, adresses IP). Ils nécessitent une base légale — en général
l'intérêt légitime à assurer la sécurité —, une durée de conservation justifiée et
une information des personnes.

## SIEM, EDR, XDR, SOAR

| Outil | Fonction | Limite |
|---|---|---|
| **SIEM** | Collecte, normalise, corrèle les journaux, déclenche des alertes | Ne voit que ce qu'on lui envoie |
| **EDR** | Détection et réponse sur les postes et serveurs | Périmètre limité aux systèmes équipés |
| **NDR** | Détection sur les flux réseau | Chiffrement limite l'analyse du contenu |
| **XDR** | Corrélation entre plusieurs périmètres | Terme commercial, le contenu varie selon l'éditeur |
| **SOAR** | Automatisation et orchestration de la réponse | Automatiser un mauvais processus l'accélère |

## Construire un cas d'usage de détection

Une règle de détection n'est pas une recherche : c'est un raisonnement documenté.

1. **Scénario** — quel comportement d'attaque veut-on voir ?
2. **Source** — quel journal porte la preuve de ce comportement ?
3. **Logique** — quelle condition distingue l'anormal du normal ?
4. **Seuil et contexte** — qu'est-ce qui est légitime dans *cet* environnement ?
5. **Procédure d'investigation** — que doit faire l'analyste N1 qui reçoit l'alerte ?
6. **Test et mesure** — la règle déclenche-t-elle, et sur quoi ?

Sans l'étape 5, l'alerte sera close en faux positif par lassitude. Sans l'étape 6,
on ne sait pas si la règle fonctionne : une règle qui ne déclenche jamais est
indistinguable d'une règle cassée.

### Deux indicateurs qui pilotent un SOC

| Indicateur | Ce qu'il mesure | Pourquoi c'est important |
|---|---|---|
| **MTTD** — délai moyen de détection | Temps entre la compromission et la détection | C'est la durée pendant laquelle l'attaquant agit librement |
| **MTTR** — délai moyen de réaction | Temps entre la détection et le confinement | Mesure l'efficacité de l'organisation, pas de l'outil |

Le **taux de faux positifs** complète les deux : un SOC saturé d'alertes non
pertinentes finit par ignorer la vraie. La fatigue d'alerte est une cause
documentée d'incidents non traités.

## MITRE ATT&CK, en usage défensif

Base de connaissances publique qui décrit les comportements observés d'attaquants,
organisés en **tactiques** (l'objectif poursuivi) et **techniques** (la manière).

Son usage défensif principal est la **mesure de couverture** : on cartographie ses
règles de détection sur la matrice pour identifier les tactiques où l'on est
aveugle. C'est un outil de pilotage, qui permet de dire « nous ne détecterions pas
une persistance » plutôt que « nous avons 400 règles ».

Référentiels complémentaires : **D3FEND** pour les contre-mesures,
**MITRE Engage** pour la tromperie défensive, et la **Cyber Kill Chain** de
Lockheed Martin comme modèle plus ancien et plus linéaire.

## Points d'examen fréquents

**Pourquoi NTP est-il critique en sécurité ?** Parce que sans horloges
synchronisées, on ne peut ni corréler deux sources, ni établir une chronologie
opposable.

**SOC ou CERT ?** Le SOC surveille et réagit au quotidien sur un périmètre ; le
CERT/CSIRT coordonne la réponse, souvent pour plusieurs entités, et porte la
relation avec l'extérieur.

**Faut-il tout journaliser ?** Non. On journalise ce qui sert les scénarios de
détection et l'investigation. Le volume inutile coûte cher et dégrade la détection.

**À quoi sert ATT&CK quand on est en défense ?** À mesurer sa couverture de
détection et à prioriser ce qu'il manque.

## Sources

- MITRE ATT&CK et MITRE D3FEND
- NIST SP 800-92 — *Guide to Computer Security Log Management*
- ANSSI — recommandations de sécurité pour la mise en œuvre d'un système de journalisation
- CNIL — recommandations sur les dispositifs de journalisation
