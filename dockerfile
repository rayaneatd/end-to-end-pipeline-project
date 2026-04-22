# on installe un petit intérpréteur python 
FROM python:3.12-slim-bookworm AS builder

# installation UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/ 

# STAGE 1: on crée notre environnement
WORKDIR /app
    
  COPY pyproject.toml uv.lock ./
    
  RUN uv sync --frozen --no-dev

  COPY MAIN ./MAIN

  ENV PATH="/app/.venv/bin:${PATH}"

  CMD ["python", "MAIN/main.py"]