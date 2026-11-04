# RGPD — Règlement général sur la protection des données

**Règlement (UE) 2016/679**, applicable depuis le **25 mai 2018**. En France, il est
complété par la **loi Informatique et Libertés** (loi n° 78-17 du 6 janvier 1978,
modifiée), et l'autorité de contrôle est la **CNIL**.

Un règlement européen est d'application directe : il n'a pas besoin d'être
transposé, contrairement à une directive comme NIS2.

## Vocabulaire : qui est qui

| Terme | Définition | Point d'attention |
|---|---|---|
| **Donnée à caractère personnel** | Toute information relative à une personne physique identifiée ou identifiable | Une adresse IP, un identifiant de connexion ou un cookie en sont |
| **Traitement** | Toute opération sur des données | La simple consultation ou conservation est un traitement |
| **Responsable de traitement** | Détermine les finalités et les moyens | C'est lui qui porte la responsabilité, même en cas de sous-traitance |
| **Sous-traitant** | Traite pour le compte du responsable | Obligations propres, mais ne décide pas des finalités |
| **Personne concernée** | L'individu dont les données sont traitées | Titulaire des droits |
| **DPO** | Délégué à la protection des données | Conseille et contrôle, n'est pas responsable pénalement du traitement |

La distinction responsable / sous-traitant se joue sur **qui décide**, pas sur qui
exécute. Un hébergeur qui choisit seul les finalités devient responsable conjoint.

## Les principes de l'article 5

| Principe | Contenu |
|---|---|
| Licéité, loyauté, transparence | Une base légale, des moyens loyaux, une information claire |
| Limitation des finalités | Finalités déterminées, explicites et légitimes ; pas de réutilisation incompatible |
| **Minimisation** | Seules les données adéquates, pertinentes et limitées au nécessaire |
| Exactitude | Données exactes et tenues à jour |
| Limitation de la conservation | Durée limitée à la finalité ; une durée doit être définie et justifiée |
| Intégrité et confidentialité | Sécurité appropriée des données |
| **Responsabilité** (*accountability*) | Article 5.2 : le responsable doit **pouvoir démontrer** la conformité |

L'*accountability* est le changement de philosophie majeur par rapport au régime
antérieur : on est passé d'un système de déclaration préalable à une obligation de
documenter en permanence ses choix et de pouvoir les prouver.

## Les six bases légales (article 6)

Une et une seule base par finalité, choisie avant le traitement et non
interchangeable ensuite.

| Base | Usage typique | Piège |
|---|---|---|
| **Consentement** | Prospection, cookies non essentiels | Doit être libre, spécifique, éclairé, univoque et **retirable à tout moment** |
| **Exécution d'un contrat** | Livraison d'une commande, gestion d'un abonnement | Ne couvre pas ce qui n'est pas nécessaire au contrat |
| **Obligation légale** | Conservation de pièces comptables | Il faut pouvoir citer le texte |
| **Sauvegarde des intérêts vitaux** | Urgence médicale | Usage très restreint |
| **Mission d'intérêt public** | Traitements d'une administration | Réservé au secteur public ou à une mission confiée |
| **Intérêts légitimes** | Sécurité des systèmes, lutte contre la fraude | Exige une **balance des intérêts** documentée ; indisponible pour les autorités publiques |

Le consentement n'est pas la base par défaut. C'est une erreur courante : le choisir
quand une autre base s'applique crée une fragilité, puisque son retrait oblige à
cesser le traitement.

## Catégories particulières (article 9)

Origine raciale ou ethnique, opinions politiques, convictions religieuses ou
philosophiques, appartenance syndicale, données génétiques, données biométriques
aux fins d'identification, données de santé, vie sexuelle ou orientation sexuelle.

Leur traitement est **interdit par principe**, sauf exceptions limitativement
énumérées, dont le consentement explicite. Les données d'infraction relèvent de
l'article 10, à part.

## Les droits des personnes (articles 12 à 22)

| Droit | Article | Contenu |
|---|---|---|
| Information | 12 à 14 | Information claire, accessible, au moment de la collecte |
| Accès | 15 | Obtenir confirmation et copie des données |
| Rectification | 16 | Corriger des données inexactes |
| Effacement | 17 | « Droit à l'oubli », non absolu |
| Limitation | 18 | Geler le traitement sans supprimer |
| **Portabilité** | 20 | Récupérer ses données dans un format structuré ; limité aux bases consentement et contrat, et aux traitements automatisés |
| Opposition | 21 | S'opposer, notamment à la prospection — sans condition dans ce cas |
| Décision automatisée | 22 | Ne pas faire l'objet d'une décision purement automatisée ayant un effet significatif |

**Délai de réponse : un mois**, prorogeable de deux mois pour les demandes
complexes, avec information de la personne dans le premier mois.

## Violation de données : les délais

Une **violation** est un incident de sécurité entraînant destruction, perte,
altération, divulgation ou accès non autorisé à des données personnelles. Un
rançongiciel chiffrant des données personnelles en est une, même sans exfiltration,
car la disponibilité est atteinte.

| Obligation | Article | Délai | Condition |
|---|---|---|---|
| Notifier l'autorité de contrôle | 33 | **72 heures** après en avoir pris connaissance | Sauf si la violation est peu susceptible d'engendrer un risque |
| Informer les personnes concernées | 34 | Dans les meilleurs délais | Si **risque élevé** pour les droits et libertés |
| Documenter en interne | 33.5 | — | **Toute** violation, y compris non notifiée |

Le registre interne des violations est obligatoire sans exception. C'est souvent ce
que la CNIL demande en premier lors d'un contrôle.

## AIPD : l'analyse d'impact (article 35)

Obligatoire quand un traitement est susceptible d'engendrer un **risque élevé**,
notamment en cas d'évaluation systématique à grande échelle, de traitement à grande
échelle de données sensibles, ou de surveillance systématique d'une zone accessible
au public. La CNIL publie des listes de traitements qui en requièrent une et de
traitements qui en sont dispensés.

L'AIPD se conduit **avant** la mise en œuvre, et le DPO y est associé. Elle
documente la nécessité, la proportionnalité, les risques et les mesures.

## DPO : quand il est obligatoire (article 37)

- Les **autorités et organismes publics**, sauf juridictions dans l'exercice de leur fonction juridictionnelle.
- Les organismes dont l'activité de base implique un **suivi régulier et systématique à grande échelle** des personnes.
- Les organismes traitant à **grande échelle** des données sensibles ou relatives à des condamnations.

Hors ces cas, il est recommandé mais facultatif. Le DPO doit disposer de moyens et
ne peut être sanctionné pour l'exercice de ses missions ; il ne doit pas être en
conflit d'intérêts, ce qui exclut en pratique le responsable informatique décideur.

## Sanctions (article 83)

Deux plafonds, et le montant retenu est **le plus élevé** des deux termes :

| Niveau | Plafond |
|---|---|
| Manquements aux obligations du responsable et du sous-traitant | 10 M€ ou **2 %** du chiffre d'affaires annuel mondial |
| Manquements aux principes, aux droits et aux transferts | 20 M€ ou **4 %** du chiffre d'affaires annuel mondial |

S'y ajoutent les mesures correctrices non financières : avertissement, mise en
demeure, limitation ou interdiction du traitement, qui peuvent être plus lourdes de
conséquences qu'une amende.

## Points d'examen fréquents

**72 heures à partir de quand ?** De la **prise de connaissance** de la violation,
pas de sa survenance. Une notification incomplète est possible, à compléter ensuite.

**Le consentement est-il la base par défaut ?** Non, c'est l'une des six, et souvent
la plus fragile.

**Le sous-traitant est-il responsable ?** Il a des obligations propres, dont la
sécurité et la tenue d'un registre, mais la responsabilité des finalités reste au
responsable de traitement. La responsabilité juridique ne se transfère pas par
contrat.

**RGPD et NIS2 se recoupent-ils ?** Partiellement : le RGPD protège les données
personnelles, NIS2 la sécurité des réseaux et systèmes. Un même incident peut
déclencher les deux régimes de notification, avec des délais et des destinataires
différents.

## Sources

- Règlement (UE) 2016/679 du 27 avril 2016
- Loi n° 78-17 du 6 janvier 1978 relative à l'informatique, aux fichiers et aux libertés, modifiée
- CNIL — lignes directrices, référentiels et listes AIPD
- Lignes directrices du Comité européen de la protection des données (CEPD)
