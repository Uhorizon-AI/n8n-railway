# Usamos imagen oficial n8n estable
FROM docker.n8n.io/n8nio/n8n:1.102.3

# Variables necesarias para producción en Railway
ENV NODE_ENV=production \
    NODE_VERSION=22.14.0 \
    NODE_FUNCTION_ALLOW_BUILTIN=crypto \
    N8N_HOST=0.0.0.0 \
    N8N_PORT=5678

EXPOSE 5678

# Comando explícito para iniciar n8n
CMD ["n8n"]
