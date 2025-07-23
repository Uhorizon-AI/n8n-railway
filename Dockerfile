FROM docker.n8n.io/n8nio/n8n:1.102.3

# Usamos una imagen oficial de n8n con versión específica para mayor estabilidad
FROM docker.n8n.io/n8nio/n8n:1.102.3

# Configuración general de Node.js
ENV NODE_ENV=production \
    NODE_VERSION=22.14.0

# Permitir el uso del módulo 'crypto' en funciones personalizadas (por ejemplo, para Zoho SalesIQ)
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# No se requiere configuración adicional: n8n se iniciará con la configuración por defecto,
# la cual puede ser modificada mediante variables de entorno definidas en Railway.
