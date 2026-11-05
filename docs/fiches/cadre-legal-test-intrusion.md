# Cadre légal et contractuel d'un test d'intrusion

La compétence qui distingue un *lead* d'un technicien n'est pas la technique :
c'est savoir **ce qui rend une mission licite**, et savoir l'arrêter quand elle
cesse de l'être.

> **Avertissement sur les montants.** Les peines ci-dessous sont données de mémoire
> et les sources juridiques secondaires se contredisent sur plusieurs d'entre elles.
> Le texte consolidé fait foi : vérifier sur **Légifrance** avant tout examen ou
> tout usage professionnel. La structure des infractions, elle, est stable.

## Le principe : l'autorisation retire le caractère frauduleux

Les infractions d'atteinte aux **STAD** (systèmes de traitement automatisé de
données) figurent aux articles **323-1 et suivants du code pénal**. Leur élément
constitutif central est l'adjectif **« frauduleux »** : c'est l'absence
d'autorisation du maître du système qui caractérise le délit.

Conséquence directe : un test d'intrusion n'est pas « légal parce que c'est un
test ». Il est licite **parce qu'il est autorisé**, et seulement dans les limites
de cette autorisation. Sortir du périmètre, c'est commettre l'infraction.

## Les infractions à connaître

| Article | Infraction | Ordre de grandeur de la peine |
|---|---|---|
| **323-1 al. 1** | Accès ou maintien frauduleux dans un STAD | 2 ans et 60 000 € |
| **323-1 al. 2** | Avec suppression ou modification de données, ou altération du fonctionnement | 3 ans et 100 000 € |
| **323-1 al. 3** | Lorsque le STAD est un traitement de données personnelles mis en œuvre par l'État | Aggravée |
| **323-2** | Entrave ou faussement du fonctionnement d'un STAD | 5 ans et 150 000 € |
| **323-3** | Introduction, modification, extraction, suppression frauduleuse de données | 5 ans et 150 000 € |
| **323-3-1** | Détention, offre, cession d'un moyen conçu pour commettre ces infractions | Peines de l'infraction la plus sévèrement réprimée |
| **323-7** | **Tentative**, punie des mêmes peines | Identique |

Deux points que les candidats manquent souvent :

**Le maintien est une infraction autonome.** Accéder par erreur n'est pas
nécessairement punissable ; **rester** après avoir compris qu'on n'était pas
autorisé l'est. La jurisprudence l'a appliqué à des administrateurs disposant d'un
accès technique large mais l'utilisant hors de leur mission : l'habilitation
technique ne vaut pas autorisation fonctionnelle.

**La tentative est punie comme l'infraction.** Un test qui échoue n'est pas pour
autant hors du champ pénal.

## L'article 323-3-1, et pourquoi il concerne tout étudiant en sécurité

Il réprime la détention et la diffusion de moyens conçus pour commettre les
infractions précédentes — ce qui viserait littéralement l'outillage de sécurité.

Le texte prévoit une exception : le **motif légitime**, notamment la recherche ou
la sécurité informatique. C'est elle qui rend licite la possession d'outils
d'analyse par un professionnel ou un étudiant du domaine.

Ce qui fait la différence en pratique, et ce qu'il faut pouvoir démontrer : un
cadre d'usage identifiable — formation, mission contractualisée, lab dont on est
propriétaire, plateforme d'entraînement — et l'absence d'usage hors de ce cadre.
Le motif légitime se prouve par le contexte, pas par l'intention déclarée.

## Le mandat d'autorisation

C'est la pièce maîtresse. Sans elle, il n'y a pas de mission, il y a une
infraction. Elle doit être **écrite, signée et antérieure** aux tests.

### Ce qu'elle doit contenir

| Élément | Pourquoi |
|---|---|
| Identité du commanditaire et du prestataire | Qui autorise, qui est autorisé |
| **Qualité du signataire** | Il doit avoir **autorité sur le système**, pas seulement sur le contrat |
| Périmètre technique précis | Adresses, noms de domaine, applications, comptes — par **inclusion**, jamais par exclusion |
| Ce qui est explicitement **hors périmètre** | Lève les ambiguïtés sur les systèmes mitoyens |
| Fenêtre temporelle | Dates et heures autorisées ; hors fenêtre, l'autorisation ne couvre plus |
| Types de tests autorisés et **interdits** | Notamment tout ce qui pourrait dégrader la disponibilité |
| Conditions d'arrêt | Qui peut suspendre, par quel canal, et sous quel délai |
| Contacts d'urgence des deux côtés | Joignables pendant toute la fenêtre |
| Traitement des données découvertes | Conservation, chiffrement, restitution, destruction |
| Clause de confidentialité | Dans les deux sens |

### Le piège du signataire

Un client peut signer pour **ses** systèmes, pas pour ceux d'autrui. Trois cas qui
reviennent :

- **Hébergement mutualisé ou cloud** — le client autorise son application, pas
  l'infrastructure du fournisseur. Les conditions d'utilisation du fournisseur
  s'appliquent en plus, et certains exigent une déclaration préalable.
- **Services tiers intégrés** — une API externe, un prestataire de paiement, un
  fournisseur d'identité ne sont pas couverts par le mandat du client.
- **Filiales et entités juridiques distinctes** — une maison mère ne signe pas
  nécessairement valablement pour une filiale.

La règle : **si le système appartient à un tiers, il faut l'autorisation de ce
tiers.** Aucune clause du mandat ne peut y suppléer.

## Règles d'engagement

Le mandat dit *ce qui* est autorisé ; les règles d'engagement disent *comment*.

- **Ce qui est proscrit par défaut** : toute action visant à dégrader la
  disponibilité, toute modification ou destruction de données, toute exfiltration
  réelle de données de production.
- **Données personnelles rencontrées** : on ne les copie pas, on documente leur
  existence et leur exposition. Le RGPD s'applique pendant la mission.
- **Découverte hors périmètre** : on arrête, on documente, on signale. On ne
  « continue un peu pour vérifier ».
- **Découverte d'une compromission préexistante** : condition d'arrêt immédiat et
  d'escalade. C'est un incident, plus un test, et la suite relève de la réponse à
  incident, pas du prestataire de test.
- **Journalisation de ses propres actions** : horodatée, pour pouvoir distinguer
  ses actions de celles d'un tiers, et se disculper si un incident survient
  pendant la fenêtre.

## Responsabilité et assurance

| Point | Contenu |
|---|---|
| **Responsabilité civile professionnelle** | Couvre les dommages causés au client ; à vérifier qu'elle inclut l'activité de test d'intrusion |
| Obligation de moyens | Le prestataire s'engage sur la méthode, pas sur l'exhaustivité des découvertes |
| Clause de limitation | Usuelle, mais elle ne couvre pas une faute lourde ni un dépassement de périmètre |
| Sous-traitance | À autoriser explicitement ; le prestataire reste responsable de son sous-traitant |

Un test d'intrusion **ne prouve pas l'absence de vulnérabilité**. Il constate ce
qui a été trouvé, dans un périmètre et une durée donnés. Un rapport qui laisse
croire le contraire expose le prestataire.

## Divulgation de vulnérabilités hors mission

| Situation | Conduite |
|---|---|
| Vulnérabilité dans un produit du marché | Divulgation coordonnée auprès de l'éditeur, délai convenu avant publication |
| Pas de contact ou éditeur non coopératif | Signalement à l'**ANSSI**, protégé par l'**article L. 2321-4 du code de la défense** : le signalant de bonne foi est protégé, et son anonymat peut être préservé auprès de l'éditeur |
| Système d'un tiers, sans mandat | Ne pas tester. Trouver par hasard n'autorise pas à vérifier |
| Programme de bogue primé | Lire le périmètre et les règles du programme : ils **sont** l'autorisation, et ils ne couvrent que ce qu'ils énoncent |

## Articulation avec les autres régimes

| Régime | Ce qu'il ajoute |
|---|---|
| **RGPD** | S'applique aux données personnelles rencontrées ou traitées pendant la mission ; le prestataire est généralement sous-traitant |
| **NIS2** (après transposition) | Inscrit la gestion et la divulgation des vulnérabilités parmi les obligations, article 21 |
| **Secret des affaires** | Les constats sont des informations sensibles du client |
| **Droit du travail** | Un test impliquant l'observation de salariés touche à des obligations d'information |

## Points d'examen fréquents

**Qu'est-ce qui rend un test licite ?** L'autorisation écrite et préalable du
maître du système, et le respect strict de son périmètre. Pas la finalité
défensive, pas la qualité professionnelle du prestataire.

**Le client peut-il autoriser un test sur son hébergement mutualisé ?** Non, pas
au-delà de ce dont il est maître. L'infrastructure du fournisseur relève du
fournisseur et de ses conditions d'utilisation.

**La tentative est-elle punissable ?** Oui, des mêmes peines (article 323-7).

**Détenir des outils de sécurité est-il illégal ?** Non, en présence d'un motif
légitime — recherche ou sécurité informatique. Mais ce motif doit pouvoir être
établi par le contexte.

**Que faire si l'on découvre une intrusion préexistante ?** Arrêter, préserver,
escalader immédiatement auprès du commanditaire. Ce n'est plus un test.

## Sources

- Code pénal, articles 323-1 à 323-7 — **à vérifier sur Légifrance** pour les peines en vigueur
- Code de la défense, article L. 2321-4 — signalement de vulnérabilité à l'ANSSI
- Règlement (UE) 2016/679 (RGPD), pour les données rencontrées en mission
- Directive (UE) 2022/2555 (NIS2), article 21
