

# n8n on Railway

Este repositorio permite desplegar una instancia de [n8n](https://n8n.io/) en Railway usando Docker.

## 🚀 Deploy

1. Clona este repositorio en tu cuenta de Railway.
2. Railway detectará automáticamente el `Dockerfile`.
3. Crea un volumen persistente en `/home/node/.n8n` para guardar los workflows y credenciales.
4. Agrega las siguientes variables de entorno en Railway:

```env
# Básicas
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_PROTOCOL=http
N8N_EDITOR_BASE_URL=https://<tu-dominio>.up.railway.app

# Base de datos (opcional pero recomendado)
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=...
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=...
DB_POSTGRESDB_USER=...
DB_POSTGRESDB_PASSWORD=...
DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false
```

> ℹ️ Sustituye `<tu-dominio>` y los datos de PostgreSQL con los que te da Railway.

## 🧪 Variables adicionales (opcional)

- `N8N_EXECUTIONS_MODE=queue`
- `N8N_RUNNERS_ENABLED=...`
- `NODE_ENV=production`

## 📦 Persistencia

Si no usas PostgreSQL, asegúrate de montar un volumen persistente en `/home/node/.n8n`.

## 📥 Importar Workflows

Para migrar workflows desde otra instancia de `n8n`:
1. Exporta los workflows como `.json` desde la UI.
2. Importa en la nueva instancia también desde la UI de `n8n`.

## 🛠 Créditos

Basado en la imagen oficial de Docker para `n8n`:  
https://hub.docker.com/r/n8nio/n8n