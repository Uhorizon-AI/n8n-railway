# n8n on Railway

This repository allows you to deploy an instance of [n8n](https://n8n.io/) on Railway using Docker.

## 🚀 Deploy

1. Clone this repository to your Railway account.
2. Railway will automatically detect the `Dockerfile`.
3. Create a persistent volume at `/home/node/.n8n` to store workflows and credentials.
4. Add the following environment variables in Railway:

```env
# Basic
N8N_EDITOR_BASE_URL=https://<your-domain>.up.railway.app
N8N_PROTOCOL=https
PORT=5678
N8N_ENCRYPTION_KEY=<your-static-encryption-key>
```


> ⚠️ Not all environment variables are mandatory if using SQLite temporarily.  
> ℹ️ The variables `NODE_VERSION=22.14.0` and `NODE_ENV=production` are already defined in the `Dockerfile`.  
> 🔐 `N8N_ENCRYPTION_KEY` is required if you want to migrate credentials between instances.

> ✅ This configuration has been validated as functional on Railway with the official `n8n` image.  
> The `healthcheckPath` in `railway.toml` was re-enabled with the path `/`, as it was successfully validated in production without causing startup errors.  

> ℹ️ Replace `<your-domain>` with your Railway domain.

> ✅ The `healthcheckPath = "/"` was re-enabled in `railway.toml` after successful production tests.

## 🧪 Additional Variables (optional)

- `N8N_EXECUTIONS_MODE=queue`
- `N8N_RUNNERS_ENABLED=true`
- `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true`

> 🧱 These variables are already defined in the Dockerfile and do not need to be redefined in Railway.

## 📦 Persistence

A 1 GB volume mounted at `/home/node/.n8n` is used to ensure data is preserved between deployments.

## 📥 Import Workflows

To migrate workflows from another `n8n` instance:  
1. Export the workflows as `.json` files from the UI.  
2. Import them into the new instance also through the `n8n` UI.

## 🛠 Credits

Based on the official Docker image for `n8n`:  
https://hub.docker.com/r/n8nio/n8n