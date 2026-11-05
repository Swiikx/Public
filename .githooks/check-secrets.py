"""Controle de secrets et de fuite pour le depot Public.

Deux modes :

    python .githooks/check-secrets.py          lignes ajoutees et indexees (hook pre-commit)
    python .githooks/check-secrets.py --all    tous les fichiers suivis (CI)

Deux niveaux :

  REFUS      Le commit est bloque. Formats a tres faible taux de faux positifs,
             cles privees, fichiers interdits, et termes de la liste de fuite.
  ATTENTION  Affiche, le commit passe. Les fiches de ce depot parlent
             legitimement de mots de passe, d'adresses et de hachages : un hook
             qui bloque la-dessus serait desactive en deux jours.

Sortie sans accents, pour ne pas dependre de l'encodage de la console.

Contournement volontaire : git commit --no-verify
"""

import math
import os
import re
import subprocess
import sys
from collections import Counter

TAILLE_MAX_MO = 20

# Materiel de cle : ne doit jamais etre versionne, meme par megarde.
EXTENSIONS_INTERDITES = {".key", ".pem", ".p12", ".pfx", ".jks", ".keystore", ".kdbx", ".ovpn"}

# Signale sans bloquer : un portfolio public peut legitimement en contenir,
# mais un export bureautique est le premier vecteur de donnees non expurgees.
EXTENSIONS_SURVEILLEES = {".pdf", ".docx", ".xlsx", ".pptx", ".csv", ".sqlite", ".db"}

# Formats dont un faux positif est tres improbable. Chaque motif exige le corps
# du secret et pas seulement son prefixe, sinon ce fichier se detecte lui-meme.
BLOQUANTS = {
    "cle privee": r"-----BEGIN (?:RSA |EC |DSA |OPENSSH |PGP )?PRIVATE KEY-----",
    "token GitHub": r"\bghp_[A-Za-z0-9]{36}\b",
    "token GitHub (fin)": r"\bgithub_pat_[A-Za-z0-9_]{60,}",
    "cle d'acces AWS": r"\bAKIA[0-9A-Z]{16}\b",
    "secret AWS": r"(?i)aws_secret_access_key\s*[=:]\s*[A-Za-z0-9/+=]{40}",
    "token Slack": r"\bxox[abprs]-[0-9A-Za-z-]{20,}",
    "cle Google": r"\bAIza[0-9A-Za-z_-]{35}\b",
    "cle Anthropic ou OpenAI": r"\bsk-(?:ant-|proj-)?[A-Za-z0-9_-]{32,}",
    "URL avec identifiants": r"\b[a-z][a-z0-9+.-]*://[^\s/:@]+:[^\s/@]{3,}@",
    "cle WireGuard": r"(?i)\b(?:Private|Preshared)Key\s*=\s*[A-Za-z0-9+/]{42,43}=",
    "token Terraform Cloud": r"\b[a-z0-9]{14}\.atlasv1\.[A-Za-z0-9_-]{40,}",
}

AVERTISSEMENTS = {
    "identifiant en clair": r"(?i)\b(?:mot de passe|password|passwd)\s*[=:]\s*\S{4,}",
    "token generique": r"(?i)\b(?:api[_-]?key|access[_-]?token|secret[_-]?key|bearer)\s*[=:]\s*\S{12,}",
    "adresse IP publique": r"\b(?!0\.|10\.|127\.|169\.254\.|192\.168\.|172\.(?:1[6-9]|2\d|3[01])\.|22[4-9]\.|23\d\.)(?:\d{1,3}\.){3}\d{1,3}\b",
}

MAX_AVERTISSEMENTS = 8

LISTE_FUITE = ".githooks/ne-pas-publier.local.txt"
MODELE_FUITE = ".githooks/ne-pas-publier.local.example"


def git(*arguments):
    resultat = subprocess.run(
        ["git", "-c", "core.quotepath=false", *arguments],
        capture_output=True,
    )
    return resultat.stdout.decode("utf-8", "replace")


def racine_depot():
    return git("rev-parse", "--show-toplevel").strip()


def fichiers_indexes():
    sortie = git("diff", "--cached", "--name-only", "--diff-filter=ACM", "-z")
    return [c for c in sortie.split("\0") if c]


def fichiers_suivis():
    sortie = git("ls-files", "-z")
    return [c for c in sortie.split("\0") if c]


def taille_indexee(chemin, tout):
    if tout:
        sortie = git("cat-file", "-s", f"HEAD:{chemin}").strip()
    else:
        sortie = git("cat-file", "-s", f":{chemin}").strip()
    return int(sortie) if sortie.isdigit() else 0


def lignes_ajoutees():
    """Rend (fichier, numero, texte) pour chaque ligne ajoutee et indexee."""
    diff = git("diff", "--cached", "-U0", "--no-color", "--diff-filter=ACM")
    fichier, numero = None, 0
    for ligne in diff.splitlines():
        if ligne.startswith("+++ b/"):
            fichier, numero = ligne[6:], 0
        elif ligne.startswith("+++"):
            fichier = None
        elif ligne.startswith("@@"):
            trouve = re.search(r"\+(\d+)", ligne)
            numero = int(trouve.group(1)) if trouve else 0
        elif fichier and ligne.startswith("+"):
            yield fichier, numero, ligne[1:]
            numero += 1


def toutes_les_lignes(racine, chemins):
    """Rend (fichier, numero, texte) pour tout le contenu suivi."""
    for chemin in chemins:
        complet = os.path.join(racine, chemin)
        try:
            with open(complet, encoding="utf-8") as fichier:
                for numero, texte in enumerate(fichier, start=1):
                    yield chemin, numero, texte.rstrip("\n")
        except (OSError, UnicodeDecodeError):
            continue


def charge_liste_fuite(racine):
    """Termes qui ne doivent jamais etre publies, un par ligne.

    Hors du depot par construction : une liste qui enumere le nom de domaine
    du lab, l'employeur et les noms de machines ne peut pas vivre dans le
    depot public qu'elle protege.
    """
    chemin = os.path.join(racine, LISTE_FUITE)
    if not os.path.exists(chemin):
        return None
    termes = []
    with open(chemin, encoding="utf-8") as fichier:
        for ligne in fichier:
            terme = ligne.strip()
            if terme and not terme.startswith("#"):
                termes.append(terme)
    return termes


def entropie(chaine):
    occurrences = Counter(chaine)
    total = len(chaine)
    return -sum((n / total) * math.log2(n / total) for n in occurrences.values())


def main(argv):
    tout = "--all" in argv
    racine = racine_depot()
    if not racine:
        return 0

    chemins = fichiers_suivis() if tout else fichiers_indexes()
    if not chemins:
        return 0

    refus, alertes = [], []

    for chemin in chemins:
        extension = os.path.splitext(chemin)[1].lower()
        if extension in EXTENSIONS_INTERDITES:
            refus.append((chemin, None, f"materiel de cle ({extension})", ""))
        elif extension in EXTENSIONS_SURVEILLEES:
            alertes.append((chemin, None, f"fichier a relire avant publication ({extension})", ""))
        octets = taille_indexee(chemin, tout)
        if octets > TAILLE_MAX_MO * 1024 * 1024:
            refus.append((chemin, None, f"{octets / 1024 / 1024:.0f} Mo (limite {TAILLE_MAX_MO})", ""))

    termes = charge_liste_fuite(racine)
    motifs_fuite = [(t, re.compile(re.escape(t), re.I)) for t in (termes or [])]

    source = toutes_les_lignes(racine, chemins) if tout else lignes_ajoutees()

    for fichier, numero, texte in source:
        for libelle, motif in BLOQUANTS.items():
            trouve = re.search(motif, texte)
            if trouve:
                refus.append((fichier, numero, libelle, trouve.group(0)[:60]))

        # Le modele contient par construction des termes d'exemple.
        if fichier != MODELE_FUITE:
            for terme, motif in motifs_fuite:
                if motif.search(texte):
                    # On n'affiche pas le terme : ce message peut etre relu
                    # ailleurs, et le but est qu'il ne circule pas.
                    refus.append((fichier, numero, f"ne pas publier : terme interdit ({len(terme)} car.)", ""))

        for libelle, motif in AVERTISSEMENTS.items():
            trouve = re.search(motif, texte)
            if trouve:
                alertes.append((fichier, numero, libelle, trouve.group(0)[:60]))

        for jeton in re.findall(r"[A-Za-z0-9+/=_-]{32,}", texte):
            if (
                re.search(r"[a-z]", jeton)
                and re.search(r"[A-Z]", jeton)
                and re.search(r"[0-9]", jeton)
                and entropie(jeton) > 4.0
            ):
                alertes.append((fichier, numero, "chaine a haute entropie", jeton[:40]))

    if termes is None and not tout:
        print("ATTENTION  Liste 'ne pas publier' absente : le controle de fuite ne tourne pas.")
        print(f"           cp {MODELE_FUITE} {LISTE_FUITE}")
        print()

    if alertes:
        print(f"ATTENTION  {len(alertes)} point(s) a relire (le commit passe) :")
        for fichier, numero, libelle, extrait in alertes[:MAX_AVERTISSEMENTS]:
            position = f"{fichier}:{numero}" if numero else fichier
            print(f"           {position}  {libelle}{f'  -> {extrait}' if extrait else ''}")
        if len(alertes) > MAX_AVERTISSEMENTS:
            print(f"           ... et {len(alertes) - MAX_AVERTISSEMENTS} autre(s).")
        print()

    if refus:
        print(f"REFUS      {len(refus)} probleme(s) bloquant(s) :")
        for fichier, numero, libelle, extrait in refus:
            position = f"{fichier}:{numero}" if numero else fichier
            print(f"           {position}  {libelle}{f'  -> {extrait}' if extrait else ''}")
        print()
        print("           Ce depot est PUBLIC. Rien n'a ete committe.")
        print("           Si un secret est deja parti : le revoquer chez le")
        print("           fournisseur d'abord, reecrire l'historique ensuite.")
        print("           Faux positif : git commit --no-verify")
        return 1

    if tout:
        print(f"OK, {len(chemins)} fichier(s) suivi(s) controle(s).")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
