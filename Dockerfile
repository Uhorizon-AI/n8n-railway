# Use an official n8n image with a specific version for stability
FROM docker.n8n.io/n8nio/n8n:2.6.4

# General Node.js configuration
ENV NODE_ENV=production \
    NODE_VERSION=22.15.0

# Allow crypto module for Zoho SalesIQ Security
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Recommended additional environment variables
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_EXECUTIONS_MODE=queue \
    N8N_RUNNERS_ENABLED=true

# Railway-specific configuration
#ENV N8N_HOST=0.0.0.0
#ENV N8N_PORT=5678

# Expose the port
EXPOSE 5678

# Required for Railway disk/volume mounting
USER root
