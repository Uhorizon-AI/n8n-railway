# Cómo trabajar en este planeta

**Última actualización:** 2026-08-27

## Antes de modificar archivos

1. Leer `AGENTS.md` y respetar el proceso de actualización documentado.
2. Si el workspace tiene metadatos Git disponibles, ejecutar `git status --short`. En cualquier caso, no sobrescribir cambios ajenos.
3. Tratar los cambios de versión como cambios locales para revisión: no desplegar, hacer commit ni push sin autorización expresa.

## Alcance habitual

- `Dockerfile`: imagen oficial y configuración del contenedor.
- `README.md`: versión desplegable e instrucciones de Railway.
- `AGENTS.md`: versión actual, compatibilidad e historial de actualizaciones.
- `railway.toml`: configuración de Railway; modificarla solo cuando el cambio de versión lo exija.

No modificar `.solar/`, credenciales, variables de Railway ni workflows durante una actualización de versión.

## Comandos permitidos de validación

```bash
rg -n "2\.[0-9]+\.[0-9]+" planets/n8n/Dockerfile planets/n8n/README.md planets/n8n/AGENTS.md
```

Si el workspace tiene metadatos Git disponibles, también se permite:

```bash
git status --short -- planets/n8n
git diff --check -- planets/n8n
git diff -- planets/n8n
```

Si Docker está disponible, también se permite validar la construcción local:

```bash
docker build --check planets/n8n
```

## Antes de dar el cambio por válido

- La versión activa debe coincidir en `Dockerfile`, `README.md` y la sección de configuración actual de `AGENTS.md`.
- Las referencias históricas a versiones anteriores deben permanecer únicamente en el historial o en instrucciones de migración claramente identificadas.
- El diff debe quedar preparado para revisión humana en el IDE.

Para descartar únicamente este trabajo, restaurar de forma explícita los archivos modificados. No usar `git restore .` ni `git checkout .`.
