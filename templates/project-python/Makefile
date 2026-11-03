VENV ?= .venv
PY := $(VENV)/bin/python

.PHONY: help venv install lint fmt test check clean

help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

venv: ## Crée l'environnement virtuel
	python3 -m venv $(VENV)

install: venv ## Installe le projet en editable + deps de dev
	$(PY) -m pip install --upgrade pip
	$(PY) -m pip install -e ".[dev]"

lint: ## Lint (ruff) + vérification du format
	$(PY) -m ruff check .
	$(PY) -m ruff format --check .

fmt: ## Formate le code
	$(PY) -m ruff format .
	$(PY) -m ruff check --fix .

test: ## Lance les tests
	$(PY) -m pytest

check: lint test ## Lint + tests

clean: ## Supprime les artefacts
	rm -rf $(VENV) .pytest_cache .ruff_cache dist build *.egg-info
	find . -type d -name __pycache__ -exec rm -rf {} +
