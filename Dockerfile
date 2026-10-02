# Use an official n8n image with a specific version for stability.
# 2.41.6 is the stable release of 2026-10-02, pulled from Docker Hub.
# docker.n8n.io rate-limits anonymous manifest requests (429).
# The image ships Node 26.7.0; NODE_VERSION records that, it does not install another Node.
FROM n8nio/n8n:2.41.6

# General Node.js configuration
ENV NODE_ENV=production \
    NODE_VERSION=26.7.0

# Allow crypto module for Zoho SalesIQ Security
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Recommended additional environment variables
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_EXECUTIONS_MODE=queue

# Railway's edge is one reverse proxy and sends X-Forwarded-For.
# n8n trusts that header only when N8N_PROXY_HOPS > 0.
# N8N_TRUST_PROXY is not read; leaving hops at 0 logs
# ERR_ERL_UNEXPECTED_X_FORWARDED_FOR and breaks rate limiting.
ENV N8N_PROXY_HOPS=1
#ENV N8N_HOST=0.0.0.0
#ENV N8N_PORT=5678

# Expose the port
EXPOSE 5678

# Required for Railway disk/volume mounting
USER root
