# ============================================================
# V2 — Segurança básica (single-stage)
# Melhorias: versão fixada, usuário não-root, healthcheck
# ============================================================

FROM nginx:1.27-alpine

# Cria usuário sem privilégios de root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /usr/share/nginx/html

COPY src/index.html /usr/share/nginx/html/index.html
COPY nginx.conf     /etc/nginx/nginx.conf

# Troca do usuário root para o não-privilegiado
USER appuser

EXPOSE 8080

# Verifica se o servidor responde a cada 30 segundos
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD wget -qO- http://localhost:8080 || exit 1
