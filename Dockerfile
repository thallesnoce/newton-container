# ============================================================
# V4 — Multistage + Segurança completa (versão de produção)
# ============================================================

# ── Stage 1: Build ──────────────────────────────────────────
FROM node:18-alpine AS builder
WORKDIR /app
COPY src/ .
# Em projetos reais: RUN npm ci && npm run build

# ── Stage 2: Production ─────────────────────────────────────
FROM nginx:1.27-alpine AS production

# Cria grupo e usuário sem privilégios
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /usr/share/nginx/html

# Copia apenas os artefatos do stage de build (sem Node.js)
COPY --from=builder /app        /usr/share/nginx/html
COPY nginx.conf                 /etc/nginx/nginx.conf

# Aplica ownership ao conteúdo copiado
RUN chown -R appuser:appgroup /usr/share/nginx/html

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD wget -qO- http://localhost:8080 || exit 1
