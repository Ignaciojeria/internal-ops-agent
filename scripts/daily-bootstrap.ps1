param(
  [string]$Vault = "",
  [switch]$OpenDaily
)

$ErrorActionPreference = "Stop"

function Run-ObsidianArgs([string[]]$Args) {
  $finalArgs = @()

  if ($Vault -ne "") {
    $finalArgs += "vault=$Vault"
  }

  $finalArgs += $Args

  Write-Host "> obsidian $($finalArgs -join ' ')" -ForegroundColor Cyan
  & obsidian @finalArgs
}

if (-not (Get-Command obsidian -ErrorAction SilentlyContinue)) {
  throw "Obsidian CLI no está instalado o no está en PATH."
}

$date = Get-Date -Format "yyyy-MM-dd"

$dailyPath = "01 Strategy/Daily/$date.md"
$leadPath = "02 CRM/Leads/Lead - $date.md"
$reelPath = "03 Content/Reels/Scripts/Reel - $date.md"

# Crea los 3 archivos usando plantillas de Obsidian
Run-ObsidianArgs @("create", "path=$dailyPath", "template=Daily-Execution-Template", "silent")
Run-ObsidianArgs @("create", "path=$leadPath", "template=Lead-Template", "silent")
Run-ObsidianArgs @("create", "path=$reelPath", "template=Reel-Case-Template", "silent")

if ($OpenDaily) {
  Run-ObsidianArgs @("open", "path=$dailyPath")
}

Write-Host "\n✅ Bootstrap diario listo:" -ForegroundColor Green
Write-Host "- $dailyPath"
Write-Host "- $leadPath"
Write-Host "- $reelPath"
