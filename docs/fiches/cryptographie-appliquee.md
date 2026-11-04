# Cryptographie appliquée

Fiche d'ingénieur, pas de mathématicien : quelles primitives, pour quel service, et
que choisir aujourd'hui.

## Les quatre services rendus

| Service | Primitive | Ce qu'elle garantit |
|---|---|---|
| **Confidentialité** | Chiffrement | Seul le détenteur de la clé lit le message |
| **Intégrité** | Hachage, MAC | Le message n'a pas été altéré |
| **Authenticité** | MAC, signature | Le message vient bien de qui l'on croit |
| **Non-répudiation** | Signature **asymétrique** | L'auteur ne peut pas nier, car lui seul a la clé privée |

Point d'examen : un **MAC** (code d'authentification de message) assure intégrité et
authenticité, mais **pas** la non-répudiation, puisque la clé est partagée entre les
deux parties. Seule la signature asymétrique y parvient.

## Symétrique et asymétrique

| | Symétrique | Asymétrique |
|---|---|---|
| Clés | Une clé secrète partagée | Une paire : publique et privée |
| Vitesse | Rapide | Lente, de plusieurs ordres de grandeur |
| Problème résolu | Chiffrer du volume | Échanger une clé, signer |
| Problème non résolu | **Distribuer la clé** | Performance |
| Exemples | AES, ChaCha20 | RSA, ECDSA, Ed25519, ECDH |

En pratique, tout protocole sérieux est **hybride** : l'asymétrique négocie une clé
de session, le symétrique chiffre les données. TLS fonctionne exactement ainsi, et
c'est la réponse attendue à « pourquoi pas tout en RSA ? ».

## Que choisir aujourd'hui

| Besoin | Recommandé | À ne plus utiliser |
|---|---|---|
| Chiffrement symétrique | **AES-256-GCM**, ChaCha20-Poly1305 | DES, 3DES, RC4, AES en mode ECB |
| Hachage | **SHA-256**, SHA-384, SHA-3 | **MD5**, **SHA-1** |
| Signature | **Ed25519**, ECDSA (P-256 ou plus), RSA-PSS ≥ 3072 bits | RSA < 2048 bits, DSA |
| Échange de clés | **X25519**, ECDH (P-256 ou plus) | Diffie-Hellman < 2048 bits |
| Stockage de mots de passe | **Argon2id**, scrypt, bcrypt | SHA-256 seul, MD5, tout hachage rapide |
| Transport | **TLS 1.3** | SSL v2 et v3, TLS 1.0 et 1.1 |

### Deux erreurs de conception fréquentes

**Le mode ECB.** Chiffrer bloc par bloc sans chaînage produit le même bloc chiffré
pour le même bloc clair : la structure des données reste visible. C'est
l'illustration classique de « chiffré ne veut pas dire sûr ».

**Hacher un mot de passe avec SHA-256.** SHA-256 est conçu pour être *rapide*, ce
qui est exactement le défaut recherché ici : cela permet de tester des milliards de
candidats. Les fonctions de dérivation (Argon2id, bcrypt, scrypt) sont **lentes et
paramétrables** par construction, et intègrent un **sel** pour empêcher les tables
précalculées. Le sel est unique par mot de passe et n'a pas besoin d'être secret.

## Chiffrement authentifié

Le chiffrement seul ne protège pas contre la modification : un attaquant peut
altérer un message chiffré sans le lire. Les modes **AEAD** (*Authenticated
Encryption with Associated Data*) comme GCM ou Poly1305 fournissent confidentialité
et intégrité ensemble, et ils sont aujourd'hui le choix par défaut.

La règle associée : **ne jamais réutiliser un nonce** avec la même clé en mode GCM.
La réutilisation casse l'authentification et peut révéler du clair.

## TLS 1.3, ce qui a changé

- Suppression des algorithmes et modes obsolètes, dont RSA en échange de clés et les
  modes non authentifiés.
- **Confidentialité persistante obligatoire** (*forward secrecy*) : la compromission
  future de la clé privée du serveur ne permet pas de déchiffrer les sessions
  passées, car chaque session utilise des clés éphémères.
- Poignée de main réduite à un aller-retour, et davantage de métadonnées chiffrées.

## PKI et certificats

| Élément | Rôle |
|---|---|
| **AC racine** | Autorité de confiance initiale, hors ligne, dans les magasins de confiance |
| **AC intermédiaire** | Signe les certificats, limite l'exposition de la racine |
| **CSR** | Demande de signature, contient la clé publique |
| **CRL / OCSP** | Mécanismes de révocation, par liste ou par interrogation |
| **Agrafage OCSP** | Le serveur présente lui-même la preuve de non-révocation |

Le vrai problème opérationnel d'une PKI n'est pas la cryptographie, c'est la
**gestion du cycle de vie** : l'expiration non surveillée d'un certificat est une
cause d'indisponibilité banale et parfaitement évitable. La supervision des dates
d'expiration vaut mieux que n'importe quel choix d'algorithme.

La **transparence des certificats** (*Certificate Transparency*) publie les
certificats émis dans des journaux publics, ce qui permet de détecter une émission
illégitime pour un domaine qu'on contrôle — à surveiller côté défense.

## Cryptographie post-quantique

Un ordinateur quantique suffisamment puissant casserait RSA et les courbes
elliptiques (algorithme de Shor), tandis que le symétrique ne serait qu'affaibli
(Grover), ce qui justifie des clés de 256 bits.

Le NIST a standardisé en août 2024 :

| Standard | Algorithme | Usage |
|---|---|---|
| **FIPS 203** | ML-KEM (anciennement Kyber) | Encapsulation de clé |
| **FIPS 204** | ML-DSA (anciennement Dilithium) | Signature |
| **FIPS 205** | SLH-DSA (anciennement SPHINCS+) | Signature, fondée sur le hachage |

La menace pratique immédiate s'appelle **« récolter maintenant, déchiffrer plus
tard »** : des flux chiffrés capturés aujourd'hui pourront être déchiffrés demain.
Les données à longue durée de confidentialité sont donc concernées dès maintenant.
L'ANSSI recommande une approche **hybride**, combinant un algorithme classique et un
algorithme post-quantique, plutôt qu'une bascule immédiate vers le seul
post-quantique.

## La règle qui résume tout

**Ne pas implémenter soi-même.** Utiliser des bibliothèques éprouvées et maintenues,
avec des paramètres par défaut sûrs. Les failles cryptographiques réelles ne
viennent presque jamais de la primitive mathématique, mais de son emploi :
réutilisation de nonce, générateur aléatoire insuffisant, comparaison non constante
en temps, gestion de clés négligée, absence d'authentification.

Corollaire : la **gestion des clés** est le sujet difficile. Une clé stockée à côté
de la donnée chiffrée, ou committée dans un dépôt, annule tout le reste.

## Points d'examen fréquents

**Hachage ou chiffrement pour un mot de passe ?** Ni l'un ni l'autre tel quel : une
fonction de dérivation lente et salée. Le hachage est à sens unique mais trop
rapide ; le chiffrement serait réversible, donc inadapté.

**À quoi sert le sel ?** À rendre chaque empreinte unique, ce qui empêche les tables
précalculées et les tables arc-en-ciel. Il n'a pas besoin d'être secret.

**Pourquoi un protocole hybride ?** L'asymétrique résout la distribution de clé mais
est lent ; le symétrique est rapide mais suppose une clé partagée. On combine les
deux forces.

**MAC ou signature ?** Le MAC authentifie entre deux parties partageant un secret ;
la signature apporte en plus la non-répudiation.

## Sources

- ANSSI — *Référentiel général de sécurité* et guides de sélection d'algorithmes cryptographiques
- NIST — FIPS 197 (AES), FIPS 180-4 et 202 (SHA-2, SHA-3), FIPS 203, 204, 205 (post-quantique)
- RFC 8446 — TLS 1.3
- OWASP — *Cryptographic Storage* et *Password Storage Cheat Sheets*
