"""Interface en ligne de commande."""

from __future__ import annotations

import argparse
import sys
from collections.abc import Sequence

from mon_projet import __version__


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="mon-projet",
        description="<Description courte du projet.>",
    )
    parser.add_argument("--version", action="version", version=f"%(prog)s {__version__}")
    parser.add_argument("name", nargs="?", default="monde", help="Nom à saluer.")
    return parser


def greet(name: str) -> str:
    """Retourne le message de salutation."""
    return f"Bonjour, {name} !"


def main(argv: Sequence[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    print(greet(args.name))
    return 0


if __name__ == "__main__":
    sys.exit(main())
