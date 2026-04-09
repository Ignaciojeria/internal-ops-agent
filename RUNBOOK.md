# RUNBOOK — Internal Ops Agent

## Objetivo
Operar el agente con una rutina simple diaria/semanal, dejando trazabilidad en `05 Analytics/Agent-Runs`.

## Flujo diario (10–15 min)
1. Ejecutar bootstrap diario de notas:
   - `pwsh -File scripts/daily-bootstrap.ps1`
2. Ejecutar el agente para planificación diaria y guardar salida:
   - `pwsh -File scripts/run-daily-agent.ps1 -Mode daily -AgentCommandTemplate "pi \"{PROMPT}\""`
3. Revisar output en:
   - `05 Analytics/Agent-Runs/YYYY-MM-DD/`
4. Ejecutar Top 3 del día.

## Flujo semanal (20–30 min)
1. Ejecutar revisión semanal:
   - `pwsh -File scripts/run-daily-agent.ps1 -Mode weekly -AgentCommandTemplate "pi \"{PROMPT}\""`
2. Actualizar:
   - `01 Strategy/Weekly/*.md`
   - `04 Automations/*.md`
   - `03 Content/Reels/Scripts/*.md`

## Modo manual (sin automatización)
- Si no quieres scheduler aún, corre los comandos manualmente cada mañana.

## Automatización opcional (Task Scheduler)
- Programar 1 tarea diaria (L–V) que ejecute:
  - `pwsh -File C:\_git\internal-ops-agent\scripts\daily-bootstrap.ps1`
  - `pwsh -File C:\_git\internal-ops-agent\scripts\run-daily-agent.ps1 -Mode daily -AgentCommandTemplate "pi \"{PROMPT}\""`

## Notas importantes
- `agent.yaml`, `SOUL.MD` y `skills/internal-ops-execution/SKILL.md` ya definen política de idioma (es por defecto).
- Mantén comandos, rutas y claves técnicas en inglés.
- Si usas otro runner (GitAgent CLI, etc.), cambia `-AgentCommandTemplate`.
