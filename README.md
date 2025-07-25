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
WEBHOOK_URL=https://<your-domain>.up.railway.app
N8N_PROTOCOL=https
PORT=5678
N8N_ENCRYPTION_KEY=<your-static-encryption-key>
```

> 🌐 `WEBHOOK_URL` ensures public webhook URLs do not default to localhost:5678.


> ⚠️ Not all environment variables are mandatory if using SQLite temporarily.  
> ℹ️ The variables `NODE_VERSION=22.14.0` and `NODE_ENV=production` are already defined in the `Dockerfile`.  
> 🔐 `N8N_ENCRYPTION_KEY` is required if you want to migrate credentials between instances.

> ✅ This configuration has been validated as functional on Railway with the official `n8n` image.  
> The `healthcheckPath` in `railway.toml` was re-enabled with the path `/`, as it was successfully validated in production without causing startup errors.  

> ℹ️ Replace `<your-domain>` with your Railway domain.


## 🧪 Additional Variables (optional)

- `N8N_EXECUTIONS_MODE=queue`
- `N8N_RUNNERS_ENABLED=true`
- `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true`

> 🧱 These variables are already defined in the Dockerfile and do not need to be redefined in Railway.

## 📦 Persistence

A persistent volume should be mounted at `/home/node/.n8n` to ensure data is preserved between deployments. The size of the volume depends on your specific needs.


## 📥 Import Workflows

To migrate workflows from another `n8n` instance:  
1. Export the workflows as `.json` files from the UI.  
2. Import them into the new instance also through the `n8n` UI.

## 🗄️ PostgreSQL Configuration (optional)

If you prefer using PostgreSQL instead of the default SQLite setup, add the following environment variables to your Railway project:

```env
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=your-postgres-host
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=your-db-user
DB_POSTGRESDB_PASSWORD=your-db-password
```

> 🔐 Make sure your PostgreSQL instance is properly secured and accessible from your Railway deployment.

> 🗑️ If you're using PostgreSQL, you can skip mounting the volume at `/home/node/.n8n`, as database persistence will be handled by your PostgreSQL instance.

## 🛠 Credits

- Inspired by [@louisjimenezp](https://github.com/louisjimenezp)'s Render setup:  
  https://github.com/louisjimenezp/n8n-render-blueprint

- Based on the official Docker image for `n8n`:  
https://hub.docker.com/r/n8nio/n8n