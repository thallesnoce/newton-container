# ============================================================
# V1 — Dockerfile básico (ponto de partida)
# Problemas: versão não fixada, roda como root, sem healthcheck
# ============================================================

FROM nginx:latest

COPY src/index.html /usr/share/nginx/html/index.html

EXPOSE 80
