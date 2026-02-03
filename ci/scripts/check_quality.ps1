Write-Host "Running Quality Checks..." -ForegroundColor Cyan

Write-Host "--------------------------------------------------" -ForegroundColor Gray
Write-Host "1. Formatting..." -ForegroundColor Yellow
dart format --output=none --set-exit-if-changed .
if ($LASTEXITCODE -ne 0) { Write-Error "Formatting failed"; exit 1 }

Write-Host "--------------------------------------------------" -ForegroundColor Gray
Write-Host "2. Analyzing..." -ForegroundColor Yellow
flutter analyze
if ($LASTEXITCODE -ne 0) { Write-Error "Analysis failed"; exit 1 }

Write-Host "--------------------------------------------------" -ForegroundColor Gray
Write-Host "3. Testing..." -ForegroundColor Yellow
flutter test
if ($LASTEXITCODE -ne 0) { Write-Error "Tests failed"; exit 1 }

Write-Host "--------------------------------------------------" -ForegroundColor Gray
Write-Host "All checks passed!" -ForegroundColor Green
