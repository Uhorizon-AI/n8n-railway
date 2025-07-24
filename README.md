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
N8N_PROTOCOL=https
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

> ⚠️ No todas las variables de entorno son obligatorias si se está usando SQLite temporalmente.  
> ℹ️ Las variables `NODE_VERSION=22.14.0` y `NODE_ENV=production` ya están definidas en el `Dockerfile`.

> ✅ Esta configuración ha sido validada como funcional en Railway con la imagen oficial de `n8n`.  
> Se reactivó el `healthcheckPath` en `railway.toml` con la ruta `/`, ya que fue validado exitosamente en producción sin provocar errores de arranque.  
> No es necesario definir `startCommand`, ya que el `CMD` está embebido correctamente en la imagen base oficial.

> ❗ Nota: No definas `startCommand` en `railway.toml` si estás usando la imagen oficial de Docker de `n8n`.  
> Esta imagen ya define su propio `CMD` embebido correctamente, y sobreescribirlo causará errores como `Command "start" not found`.

> ℹ️ Sustituye `<tu-dominio>` y los datos de PostgreSQL con los que te da Railway.

> ✅ Se reactivó el `healthcheckPath = "/"` en `railway.toml` tras pruebas exitosas en producción.

## 🧪 Variables adicionales (opcional)

- `N8N_EXECUTIONS_MODE=queue`
- `N8N_RUNNERS_ENABLED=...`

> 🔧 `NODE_ENV=production` ya está definido en el `Dockerfile` para evitar confusiones.

## 📦 Persistencia

Se está usando un volumen de 1 GB montado en `/home/node/.n8n`, lo que garantiza que los datos se conserven entre despliegues.

## 📥 Importar Workflows

Para migrar workflows desde otra instancia de `n8n`:
1. Exporta los workflows como `.json` desde la UI.
2. Importa en la nueva instancia también desde la UI de `n8n`.

## 🛠 Créditos

Basado en la imagen oficial de Docker para `n8n`:  
https://hub.docker.com/r/n8nio/n8n