# Use an official n8n image with a specific version for stability
FROM docker.n8n.io/n8nio/n8n:1.102.3

# General Node.js configuration
ENV NODE_ENV=production \
    NODE_VERSION=22.14.0

# Allow crypto module for Zoho SalesIQ Security
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Recommended additional environment variables
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_EXECUTIONS_MODE=queue \
    N8N_RUNNERS_ENABLED=true

# Railway-specific configuration
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Expose the port
EXPOSE 5678

# Required for Railway disk/volume mounting
USER root

# Set working directory
WORKDIR /home/node

# Copy custom files if needed (e.g., settings, credentials)
# COPY ./local_files /home/node/.n8n

# Ensure proper file permissions
RUN chown -R node:node /home/node

# Use non-root user to run the app
USER node

# Start the n8n service
CMD ["n8n"]