# Flutter Build Script for PowerShell 7
# Usage: .\build.ps1 [command]
# Commands: run, clean, get, build, help

param(
    [Parameter(Position=0)]
    [ValidateSet('run', 'clean', 'get', 'build', 'help', '')]
    [string]$Command = 'run'
)

function Show-Help {
    Write-Host "`nFlutter Build Script - Available commands:" -ForegroundColor White
    Write-Host "  .\build.ps1          - Clean, get dependencies, and run (default)" -ForegroundColor Green
    Write-Host "  .\build.ps1 run      - Clean, get dependencies, and run" -ForegroundColor Green
    Write-Host "  .\build.ps1 clean    - Clean the Flutter project" -ForegroundColor Yellow
    Write-Host "  .\build.ps1 get      - Get Flutter dependencies" -ForegroundColor Cyan
    Write-Host "  .\build.ps1 build    - Build the Flutter app" -ForegroundColor Magenta
    Write-Host "  .\build.ps1 help     - Show this help message`n" -ForegroundColor White
}

function Invoke-FlutterClean {
    Write-Host "`n🧹 Cleaning Flutter project..." -ForegroundColor Yellow
    flutter clean
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Flutter clean failed!" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Clean complete`n" -ForegroundColor Green
}

function Invoke-FlutterGet {
    Write-Host "📦 Getting Flutter dependencies..." -ForegroundColor Cyan
    flutter pub get
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Flutter pub get failed!" -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Dependencies installed`n" -ForegroundColor Green
}

function Invoke-FlutterRun {
    Write-Host "🚀 Running Flutter app..." -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor DarkGray
    flutter run
}

function Invoke-FlutterBuild {
    Write-Host "`n🔨 Building Flutter app..." -ForegroundColor Magenta
    flutter build
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Build complete`n" -ForegroundColor Green
    }
}

# Handle empty or default command
if ([string]::IsNullOrEmpty($Command)) {
    $Command = 'run'
}

# Execute command
switch ($Command) {
    'run' {
        Invoke-FlutterClean
        Invoke-FlutterGet
        Invoke-FlutterRun
    }
    'clean' {
        Invoke-FlutterClean
    }
    'get' {
        Invoke-FlutterGet
    }
    'build' {
        Invoke-FlutterBuild
    }
    'help' {
        Show-Help
    }
}