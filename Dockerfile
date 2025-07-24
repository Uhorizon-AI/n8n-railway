FROM docker.n8n.io/n8nio/n8n:1.102.3

ENV NODE_ENV=production \
    NODE_FUNCTION_ALLOW_BUILTIN=crypto \
    N8N_HOST=0.0.0.0 \
    N8N_PORT=5678 \
    N8N_USER_FOLDER=/home/node/n8n-data

EXPOSE 5678
