# n8n Railway - Agent Configuration Guide

Este archivo contiene información específica para agentes de IA sobre la configuración actual de n8n en Railway y cómo realizar actualizaciones futuras.

## 📋 Configuración Actual

### Versión de n8n
- **Versión actual:** 1.109.1
- **Imagen Docker:** `docker.n8n.io/n8nio/n8n:1.109.1`
- **Fecha de actualización:** Diciembre 2024

### Configuración del Dockerfile

```dockerfile
# Imagen base
FROM docker.n8n.io/n8nio/n8n:1.109.1

# Configuración de Node.js
ENV NODE_ENV=production
ENV NODE_VERSION=22.15.0

# Configuración para Python/Zoho SalesIQ Security
ENV NODE_FUNCTION_ALLOW_BUILTIN=crypto

# Variables de n8n recomendadas
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV N8N_EXECUTIONS_MODE=queue
ENV N8N_RUNNERS_ENABLED=true

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
FROM docker.n8n.io/n8nio/n8n:1.107.4
# A:
FROM docker.n8n.io/n8nio/n8n:1.109.1
```

### 3. Verificar Compatibilidad
- ✅ **Node.js 22.15.0** - Compatible con n8n 1.109.1
- ✅ **Python/Pyodide** - Soporte incluido en la imagen
- ✅ **Variables de entorno** - No requieren cambios

### 4. Actualizar Documentación
- Actualizar versión en `README.md` (línea 3)
- Verificar sección de Python Support
- Actualizar este archivo `AGENTS.md`

## 🐍 Configuración de Python

### Variables Importantes
- `NODE_FUNCTION_ALLOW_BUILTIN=crypto` - Habilita módulo crypto para seguridad
- `N8N_RUNNERS_ENABLED=true` - Habilita sistema de runners para Python

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
- `N8N_RUNNERS_ENABLED=true` - Necesaria para Python

### Railway Específico
- Puerto: 5678 (no cambiar)
- Usuario: root (requerido para Railway)
- Volumen persistente: `/home/node/.n8n`

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
| Dic 2024 | 1.109.1 | Actualización desde 1.107.4, agregada documentación Python |
| - | 1.107.4 | Versión inicial |

---

**Nota para Agentes:** Este archivo debe actualizarse cada vez que se realice una actualización de n8n para mantener la documentación actualizada y facilitar futuras actualizaciones.
