# Write-up — <nom de la machine / du lab / du challenge>

> Template de write-up. Copier ce fichier, remplacer les `<placeholders>`,
> supprimer cette citation.
>
> **Périmètre** : uniquement des cibles pour lesquelles l'autorisation est
> explicite — lab monté soi-même, plateforme d'entraînement (HTB, THM, root-me,
> VulnHub), CTF, ou périmètre écrit d'un engagement. Ne jamais publier de
> write-up sur une cible tierce sans autorisation.

**Plateforme** : <HTB / THM / lab local / CTF> · **Difficulté** : <facile / moyen / difficile> · **Date** : <AAAA-MM-JJ>

**Autorisation** : <plateforme d'entraînement publique / lab personnel / engagement n° X>

## Résumé

<Le chemin complet en trois ou quatre phrases : point d'entrée, vulnérabilité
exploitée, élévation de privilèges. Quelqu'un qui lit ce paragraphe seul doit
comprendre comment la machine tombe.>

| | |
|---|---|
| Vecteur initial | <ex. upload de fichier non filtré> |
| Élévation de privilèges | <ex. binaire SUID mal configuré> |
| CVE / CWE | <CVE-AAAA-NNNNN ou CWE-NNN> |

## Environnement

| Élément | Valeur |
|---|---|
| Cible | `<nom de la machine>` — IP de lab, non reproduite ici |
| Attaquant | <ex. Kali 2026.1> |
| Outils | <nmap, ffuf, burp, ...> |

Les adresses IP sont celles d'un réseau de lab éphémère et ne sont pas
reproduites : utiliser `$TARGET` dans les commandes.

## Reconnaissance

### Scan de ports

```bash
nmap -sC -sV -oA scans/initial "$TARGET"
```

<Extrait de sortie utile, pas le scan complet.>

| Port | Service | Version |
|---|---|---|
| <22> | <ssh> | <OpenSSH 9.x> |
| <80> | <http> | <nginx 1.x> |

### Énumération <du service>

```bash
<commandes>
```

<Ce que ça révèle et ce qui a attiré l'attention.>

## Exploitation

### Vulnérabilité

<Nature de la faille, où elle se trouve, pourquoi elle est exploitable. La
mécanique, pas seulement la suite de commandes.>

### Mise en œuvre

```bash
<étapes reproductibles>
```

<Résultat : accès obtenu, en tant que quel utilisateur.>

> Les credentials trouvés pendant le lab ne sont pas reproduits ici, même
> expirés : indiquer où ils se trouvaient, pas leur valeur.

## Élévation de privilèges

### Énumération

```bash
<commandes d'énumération post-accès>
```

<Le détail qui ouvre la voie.>

### Escalade

```bash
<étapes>
```

<Accès root / administrateur obtenu.>

## Remédiation

La partie qui transforme un write-up en travail utile : pour chaque faille,
ce qui aurait empêché l'exploitation.

| Faille | Correctif | Détection |
|---|---|---|
| <vulnérabilité> | <configuration ou patch à appliquer> | <log ou règle qui l'aurait vue passer> |

## Ce qui a coincé

<Pistes suivies pour rien, erreurs de raisonnement, et ce qui a débloqué.
Plus formateur que le chemin propre reconstruit après coup.>

## Références

- <Titre> — <URL>
