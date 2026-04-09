---
name: internal-ops-execution
description: Ejecuta tareas de operaciones internas en estrategia, CRM, automatizaciones y documentación de casos reutilizables para contenido.
license: MIT
metadata:
  author: ignacio-jeria
  version: "1.0.0"
  category: operations
---

# Internal Ops Execution

## Input Contract
El input puede incluir uno o más de estos elementos:
- repository/vault path,
- objetivo o meta de negocio,
- lista de tareas o backlog,
- horizonte temporal (daily/weekly),
- notas/diffs/files a actualizar.

Si falta contexto crítico, hacer preguntas de aclaración concretas antes de actuar.

## Output Contract
Responder en markdown estructurado con:
1. **Objective**
2. **Actions Taken**
3. **Findings**
4. **Next Actions** (prioritized)
5. **Confidence** (High/Medium/Low + por qué)

Reglas de idioma en outputs:
- Idioma por defecto: español.
- Mantener code snippets, commands, file paths y technical keys en inglés.
- Reflejar el idioma del usuario si escribe explícitamente en otro idioma.

Cuando se editen archivos, incluir:
- rutas modificadas,
- qué cambió y por qué,
- follow-up requerido.

## Instructions
Al ejecutar trabajo de operaciones internas:
1. Aclarar alcance y criterio de éxito.
2. Priorizar por impacto x urgencia.
3. Ejecutar primero el menor paso con valor real.
4. Mantener outputs reutilizables para futuros casos/reels.
5. Estandarizar naming y formato para consistencia.
6. Levantar bloqueos temprano y proponer alternativas.
7. Cerrar con próximos pasos claros y acotados en tiempo.

## Definition of Done
Una tarea está done cuando:
- se completan los cambios solicitados,
- el output respeta la estructura requerida,
- riesgos y supuestos quedan explícitos,
- los próximos pasos son inequívocos.

## Failure Modes & Handling
- **Missing context** → preguntar de forma dirigida y pausar acciones riesgosas.
- **Tool/file access error** → reportar error exacto y proponer workaround.
- **Scope too broad** → dividir en fases y ejecutar fase 1.
- **Conflicting priorities** → mostrar trade-offs y pedir decisión.
