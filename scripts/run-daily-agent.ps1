param(
  [ValidateSet("daily", "weekly")]
  [string]$Mode = "daily",

  [string]$AgentCommandTemplate = "",

  [string]$OutputRoot = "05 Analytics/Agent-Runs",

  [switch]$SkipBootstrap
)

$ErrorActionPreference = "Stop"

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) {
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
  }
}

function Build-Prompt([string]$CurrentMode) {
  $base = @"
Eres un internal-ops-agent.
Devuelve respuesta en markdown y en español (excepto comandos/rutas/keys técnicas).

Formato obligatorio:
1) Objective
2) Actions Taken
3) Findings
4) Next Actions (prioritized)
5) Confidence
"@

  if ($CurrentMode -eq "daily") {
    return $base + @"

Contexto de ejecución: DAILY PLANNING.
Objetivo: definir y priorizar Top 3 de hoy, riesgos y siguiente paso inmediato.
"@
  }

  return $base + @"

Contexto de ejecución: WEEKLY REVIEW.
Objetivo: revisar avances, bloqueos, métricas y plan de la próxima semana.
"@
}

function Resolve-AgentCommand([string]$Template, [string]$Prompt, [string]$PromptFile) {
  $escapedPrompt = $Prompt.Replace('"', '`"')

  if ($Template -ne "") {
    return $Template.Replace("{PROMPT}", $escapedPrompt).Replace("{PROMPT_FILE}", $PromptFile)
  }

  # Fallback pragmático: si existe `pi`, usarlo directo con prompt inline.
  if (Get-Command pi -ErrorAction SilentlyContinue) {
    return 'pi "' + $escapedPrompt + '"'
  }

  throw 'No se encontró runner por defecto. Pasa -AgentCommandTemplate (ej: ''pi "{PROMPT}"'').'
}

$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HHmmss"
$runDir = Join-Path $OutputRoot $date
Ensure-Dir $runDir

if (-not $SkipBootstrap -and $Mode -eq "daily") {
  Write-Host "> Running daily bootstrap..." -ForegroundColor Cyan
  & pwsh -File "scripts/daily-bootstrap.ps1"
}

$prompt = Build-Prompt -CurrentMode $Mode
$promptFile = Join-Path $runDir "prompt-$Mode-$time.md"
$rawOutputFile = Join-Path $runDir "raw-output-$Mode-$time.txt"
$reportFile = Join-Path $runDir "agent-run-$Mode-$time.md"

$prompt | Out-File -FilePath $promptFile -Encoding UTF8

$command = Resolve-AgentCommand -Template $AgentCommandTemplate -Prompt $prompt -PromptFile $promptFile

Write-Host "> Running agent command:" -ForegroundColor Cyan
Write-Host "  $command" -ForegroundColor DarkCyan

$raw = Invoke-Expression $command 2>&1 | Tee-Object -FilePath $rawOutputFile

$reportLines = @(
  "---",
  "type: agent-run",
  "status: completed",
  "mode: $Mode",
  "date: $date",
  "time: $time",
  "raw_output: $rawOutputFile",
  "prompt_file: $promptFile",
  "---",
  "",
  "# Agent Run - $Mode ($date $time)",
  "",
  "## Command",
  '```powershell',
  "$command",
  '```',
  "",
  "## Output",
  '```',
  "$raw",
  '```'
)

$report = $reportLines -join "`n"
$report | Out-File -FilePath $reportFile -Encoding UTF8

Write-Host "`n✅ Agent run guardado en:" -ForegroundColor Green
Write-Host "- $reportFile"
Write-Host "- $rawOutputFile"
Write-Host "- $promptFile"
