#* STAGE 1: on crée notre environnement

  # on installe un petit intérpréteur python 
FROM python:3.12-slim-bookworm AS builder

  # installation UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/ 

WORKDIR /app

  # installation des dépendances dans un .venv + optimisation du cache docker
RUN --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-dev --no-install-project


#* STAGE 2: le runtime
FROM python:3.12-slim-bookworm AS runtime

WORKDIR /app

  # on copie que l'environnement virtuel du builder
COPY --from=builder /app/.venv /app/.venv
  
  # on copie le code source ensuite
COPY MAIN ./MAIN

  # on utilise le path pour utiliser .venv par défaut
ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

  # on crée un utilisateur non root 
RUN useradd -m worker
USER worker

CMD ["python", "MAIN/main.py"]