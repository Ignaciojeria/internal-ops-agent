---
type: automation
status: active
category: planning
time_saved_hours_week: 2
error_reduction_pct: 20
linked_reel: "[[03 Content/Reels/Scripts/Reel - Automation 00 Daily Bootstrap]]"
tags:
  - automation
  - planning
  - case-study
---

# Automation 00 - Planificación con Daily Bootstrap

## Problema
Cada día empezaba con la planificación dispersa entre estrategia, CRM y notas de contenido.

## Flujo (antes)
Creación manual de notas diarias y cambios de contexto frecuentes.

## Flujo (después)
Ejecutar `scripts/daily-bootstrap.ps1` una vez para crear:
- `01 Strategy/Daily/YYYY-MM-DD.md`
- `02 CRM/Leads/Lead - YYYY-MM-DD.md`
- `03 Content/Reels/Scripts/Reel - YYYY-MM-DD.md`

## Herramientas
PowerShell + Obsidian CLI + Templates

## Métricas
- time_saved_hours_week: 2 (estimación inicial)
- errors_reduced_pct: 20 (menos artefactos diarios omitidos)
- throughput_change: inicio diario más rápido

## Siguiente iteración
- Agregar bloques de prioridad automática para Today Top 3.
- Agregar snapshot opcional de KPI semanal los lunes.
