# ============================================================
# V3 — Multistage build (sem otimização de segurança ainda)
# Conceito: separar ambiente de build do ambiente de produção
#
# Por que multistage?
#   • A imagem final não carrega Node.js, npm, nem código-fonte
#   • Resultado: imagem menor, superfície de ataque reduzida
# ============================================================

# ── Stage 1: Build ──────────────────────────────────────────
# Em projetos reais: npm install + npm run build (React, Vue…)
FROM node:18-alpine AS builder
WORKDIR /app
COPY src/ .

# ── Stage 2: Production ─────────────────────────────────────
# Apenas o Nginx + os arquivos compilados — sem Node.js
FROM nginx:1.27-alpine AS production

COPY --from=builder /app /usr/share/nginx/html

EXPOSE 80
