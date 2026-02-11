# n8n Railway - Agent Configuration Guide

Este archivo contiene información específica para agentes de IA sobre la configuración actual de n8n en Railway y cómo realizar actualizaciones futuras.

## 📋 Configuración Actual

### Versión de n8n
- **Versión actual:** 2.6.4
- **Imagen Docker:** `docker.n8n.io/n8nio/n8n:2.6.4`
- **Fecha de actualización:** Febrero 2026

### Configuración del Dockerfile

```dockerfile
# Imagen base
FROM docker.n8n.io/n8nio/n8n:2.6.4

# Configuración de Node.js
ENV NODE_ENV=production
ENV NODE_VERSION=22.15.0

# Configuración para Python/Zoho SalesIQ Security
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Variables de n8n recomendadas
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV N8N_EXECUTIONS_MODE=queue

# Railway-specific configuration
ENV N8N_TRUST_PROXY=true

# Puerto
EXPOSE 5678

# Usuario para Railway
USER root
```

## 🔄 Proceso de Actualización

### 1. Verificar Versión Disponible
Antes de actualizar, verificar la versión más reciente estable:
```bash
# Verificar versión latest
docker pull docker.n8n.io/n8nio/n8n:latest

# Verificar versión específica
docker pull docker.n8n.io/n8nio/n8n:1.109.1
```

### 2. Actualizar Dockerfile
Cambiar la línea 2 del Dockerfile:
```dockerfile
# De:
FROM docker.n8n.io/n8nio/n8n:<version-anterior>
# A:
FROM docker.n8n.io/n8nio/n8n:<version-objetivo>
```

### 3. Verificar Compatibilidad
- ✅ **Node.js 22.15.0** - Compatible con n8n 2.6.4
- ✅ **Python/Pyodide** - Soporte incluido en la imagen
- ✅ **Variables de entorno** - No requieren cambios

### 4. Actualizar Documentación
- Actualizar versión en `README.md` (línea 3)
- Verificar sección de Python Support
- Actualizar este archivo `AGENTS.md`

## 🐍 Configuración de Python

### Variables Importantes
- `NODE_FUNCTION_ALLOW_BUILTIN=crypto` - Habilita módulo crypto para seguridad
- ~~`N8N_RUNNERS_ENABLED=true`~~ - **DEPRECATED** (Feb 2026): Esta variable ya no es necesaria y ha sido eliminada

### Compatibilidad
- **Pyodide:** Incluido en la imagen oficial de n8n
- **Versión Python:** Determinada por Pyodide (actualmente Python 3.11)
- **Estado:** Beta - puede tener limitaciones

## ⚠️ Consideraciones Importantes

### Breaking Changes
- Revisar [Release Notes de n8n](https://docs.n8n.io/release-notes/)
- Verificar cambios en variables de entorno
- Comprobar compatibilidad de workflows existentes

### Variables Críticas
- `N8N_ENCRYPTION_KEY` - Requerida para migración de credenciales
- `NODE_FUNCTION_ALLOW_BUILTIN=crypto` - Específica para Zoho SalesIQ
- `N8N_TRUST_PROXY=true` - Requerida para Railway/proxy reverso (rate limiting e IPs correctas)
- ~~`N8N_RUNNERS_ENABLED=true`~~ - **DEPRECATED** (ya no es necesaria)

### Railway Específico
- Puerto: 5678 (no cambiar)
- Usuario: root (requerido para Railway)
- Volumen persistente: `/home/node/.n8n`
- `N8N_TRUST_PROXY=true` - **Crítico**: Requerido para Railway (proxy reverso). Permite rate limiting correcto y lectura de IPs reales desde headers X-Forwarded-For

## 🚀 Producción: actualización 1.x → 2.x (2.4.7)

**Importante:** Pasar de 1.122.5 a 2.4.7 es un salto de **major** (1.x → 2.x). En producción hay que hacer pasos adicionales.

### Pasos directos (Railway + Postgres)
1. **Backup Postgres (Railway):**
   - En Railway, abre el servicio de **Postgres** de n8n.
   - Crea **snapshot/backup** desde el panel.
   - Confirma que el snapshot quedó listo antes de continuar.
2. **Backup lógico (opcional pero recomendado):**
   - Exporta todos los workflows (JSON) desde n8n.
3. **Migration Report (recomendado):**
   - En la instancia actual 1.x: Settings > Migration Report.
   - Anota issues **Critical/Medium** para resolver tras el upgrade.
4. **Revisión de breaking changes v2.0:**
   - **Start node eliminado:** Cambiar por Manual Trigger / Execute Workflow Trigger o eliminar.
   - **Publish/Save:** Revisar workflows que deben publicarse.
   - **Nodos eliminados:** Spontit, crowd.dev, Kitemaker, Automizy.
5. **Actualizar imagen en repo (Dockerfile):**
   - Cambiar a `FROM docker.n8n.io/n8nio/n8n:2.4.7`.
   - Mantener `NODE_VERSION=22.15.0`, `NODE_FUNCTION_ALLOW_BUILTIN=crypto`, `N8N_TRUST_PROXY=true`.
6. **Verificar variables críticas en Railway:**
   - **No cambiar** `N8N_ENCRYPTION_KEY`.
   - Confirmar `N8N_EXECUTIONS_MODE=queue`.
7. **Deploy en Railway:**
   - Haz push a la rama desplegada (normalmente `main`).
   - Espera a que el build termine y el contenedor arranque.
8. **Primer arranque y migraciones:**
   - Deja que las migraciones de BD finalicen antes de usar la UI.
   - Revisa logs si el arranque tarda más de lo habitual.
9. **Validación post-deploy:**
   - Healthcheck `/` responde.
   - Login correcto y credenciales legibles.
   - Probar workflows críticos y webhooks públicos.
   - En Settings > Migration Report, resolver primero **Critical**, luego **Medium**.
10. **Zendesk Trigger (2.4.7):**
   - Si usas el nodo Zendesk Trigger, configurar verificación de firma de webhook tras el deploy.

### Referencias
- [n8n 2.0 Breaking Changes](https://docs.n8n.io/2-0-breaking-changes/)
- [n8n Migration Tool v2](https://docs.n8n.io/migration-tool-v2/)
- [n8n 2.4.7 Release](https://github.com/n8n-io/n8n/releases) (Zendesk webhook signature)

## 🔍 Verificaciones Post-Actualización

1. **Health Check:** Verificar que Railway detecte el servicio correctamente
2. **Python Execution:** Probar ejecución de código Python en n8n
3. **Workflows:** Verificar que workflows existentes funcionen
4. **Webhooks:** Confirmar que webhooks públicos funcionen correctamente

## 📚 Recursos Útiles

- [n8n Release Notes](https://docs.n8n.io/release-notes/)
- [n8n Docker Hub](https://hub.docker.com/r/n8nio/n8n)
- [n8n Python Documentation](https://docs.n8n.io/integrations/builtin/cluster-nodes/sub-nodes/Code/)
- [Railway Documentation](https://docs.railway.app/)

## 🏷️ Historial de Actualizaciones

| Fecha | Versión | Cambios |
|-------|---------|---------|
| Feb 2026 | 2.6.4 | Actualización 2.4.7 → 2.6.4 (minor). Eliminada variable deprecated N8N_RUNNERS_ENABLED. Agregada N8N_TRUST_PROXY=true para Railway. |
| Feb 2026 | 2.4.7 | Actualización 1.122.5 → 2.4.7 (major). Zendesk Trigger: webhook signature verification. Ver sección Producción si vienes de 1.x. |
| Dic 2025 | 1.122.5 | Actualización desde 1.119.2 a 1.122.5 |
| Nov 2025 | 1.119.2 | Actualización desde 1.113.3 a 1.119.2 |
| Dic 2024 | 1.113.3 | Actualización desde 1.111.0 a 1.113.3 |
| Dic 2024 | 1.111.0 | Actualización desde 1.107.4, agregada documentación Python |
| - | 1.107.4 | Versión inicial |

---

**Nota para Agentes:** Este archivo debe actualizarse cada vez que se realice una actualización de n8n para mantener la documentación actualizada y facilitar futuras actualizaciones.
