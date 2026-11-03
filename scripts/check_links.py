#!/usr/bin/env python3
"""Vérifie que les liens relatifs des fichiers Markdown pointent sur quelque chose.

Ne touche pas au réseau : seuls les liens relatifs sont résolus sur le disque.
Les liens externes (http, https, mailto) et les ancres pures (#section) sont ignorés.

Usage :
    python3 scripts/check_links.py [racine]

Sortie : 0 si tous les liens relatifs résolvent, 1 sinon.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote, urlparse

# [texte](cible) — on ignore les images de la même forme, elles sont traitées pareil.
LINK_RE = re.compile(r"!?\[[^\]]*\]\(\s*([^)\s]+)")

SKIP_DIRS = {".git", "node_modules", ".venv", "venv", ".terraform", "dist", "build"}

IGNORED_SCHEMES = {"http", "https", "mailto", "tel", "ftp", "data"}


def iter_markdown(root: Path):
    for path in sorted(root.rglob("*.md")):
        if any(part in SKIP_DIRS for part in path.parts):
            continue
        yield path


def is_external(target: str) -> bool:
    return urlparse(target).scheme in IGNORED_SCHEMES


def check_file(path: Path, root: Path) -> list[tuple[int, str]]:
    broken: list[tuple[int, str]] = []
    text = path.read_text(encoding="utf-8")

    in_fence = False
    for lineno, line in enumerate(text.splitlines(), start=1):
        stripped = line.lstrip()
        if stripped.startswith("```") or stripped.startswith("~~~"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue

        for target in LINK_RE.findall(line):
            if target.startswith("<"):
                target = target.lstrip("<").rstrip(">")
            if is_external(target) or target.startswith("#"):
                continue

            # On enlève une éventuelle ancre : seul le chemin est vérifié.
            file_part = unquote(target.split("#", 1)[0])
            if not file_part:
                continue
            if file_part.startswith("/"):
                resolved = root / file_part.lstrip("/")
            else:
                resolved = path.parent / file_part

            if not resolved.exists():
                broken.append((lineno, target))

    return broken


def main(argv: list[str]) -> int:
    root = Path(argv[0]).resolve() if argv else Path.cwd()
    if not root.is_dir():
        print(f"racine introuvable : {root}", file=sys.stderr)
        return 2

    total_files = 0
    total_broken = 0

    for path in iter_markdown(root):
        total_files += 1
        broken = check_file(path, root)
        if broken:
            rel = path.relative_to(root)
            for lineno, target in broken:
                print(f"{rel}:{lineno}: lien cassé -> {target}")
            total_broken += len(broken)

    if total_broken:
        print(f"\n{total_broken} lien(s) cassé(s) sur {total_files} fichier(s) Markdown.")
        return 1

    print(f"OK — {total_files} fichier(s) Markdown, aucun lien relatif cassé.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
