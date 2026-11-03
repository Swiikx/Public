# syntax=docker/dockerfile:1

# ---- Étape de build ----
FROM python:3.12-slim AS build

WORKDIR /app

# Les dépendances d'abord : cette couche reste en cache tant que
# pyproject.toml ne change pas.
COPY pyproject.toml ./
RUN pip install --no-cache-dir --prefix=/install .

COPY src/ ./src/

# ---- Image finale ----
FROM python:3.12-slim AS runtime

# Pas de root dans le conteneur.
RUN useradd --create-home --uid 10001 app

WORKDIR /app

COPY --from=build /install /usr/local
COPY --from=build /app/src ./src

USER app

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import sys; sys.exit(0)"

CMD ["python", "-m", "mon_projet"]
