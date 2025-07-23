# Usamos una imagen oficial de n8n con versión específica para mayor estabilidad
#FROM docker.n8n.io/n8nio/n8n:1.102.3
FROM n8nio/n8n:1.102.3

# Configuración general de Node.js
ENV NODE_ENV=production \
    NODE_VERSION=22.14.0

# Permitir el uso del módulo 'crypto' en funciones personalizadas
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Configuración específica para Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Exponer el puerto
EXPOSE 5678

# Crear directorio de datos si no existe y configurar permisos
# USER root
# RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
# USER node

# Comando de inicio correcto para n8n
#CMD ["n8n"]
#CMD ["node", "/usr/local/lib/node_modules/n8n/bin/n8n"]
#CMD ["/bin/sh", "-c", "./packages/cli/bin/n8n"]

# Ejecutar n8n directamente sin entrypoint
CMD ["/bin/sh", "-c", "./packages/cli/bin/n8n"]