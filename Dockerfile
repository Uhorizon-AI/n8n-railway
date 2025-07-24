# Usamos una imagen oficial de n8n con versión específica para mayor estabilidad
FROM docker.n8n.io/n8nio/n8n:1.102.3

# Configuración general de Node.js
ENV NODE_ENV=production \
    NODE_VERSION=22.14.0


ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Configuración específica para Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Exponer el puerto
EXPOSE 5678

# Requerido para el disk/volume
USER root