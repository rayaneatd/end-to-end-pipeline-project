# on installe un petit intérpréteur python 
FROM python:3.12-slim-bookworm AS builder

# installation UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/ 

# STAGE 1: on crée notre environnement
WORKDIR /app

# installation des dépendances dans un .venv + optimisation du cache docker
  RUN --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-dev --no-install-project


FROM python:3.12-slim-bookworm AS runtime

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv
    
  COPY MAIN ./MAIN

  ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

  RUN useradd -m worker
  USER worker

  CMD ["python", "MAIN/main.py"]