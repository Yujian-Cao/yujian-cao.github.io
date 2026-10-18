$ErrorActionPreference = 'Stop'

$sourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $sourceDir
$outputDir = Join-Path $repoRoot 'assets\files'
$outputPdf = Join-Path $outputDir 'Resume.pdf'

$pdflatexCommand = Get-Command pdflatex.exe -ErrorAction SilentlyContinue
$pdflatexPath = if ($pdflatexCommand) {
    $pdflatexCommand.Source
} else {
    Join-Path $env:LOCALAPPDATA 'Programs\MiKTeX\miktex\bin\x64\pdflatex.exe'
}

if (-not (Test-Path -LiteralPath $pdflatexPath)) {
    throw "pdflatex was not found. Install MiKTeX or add pdflatex.exe to PATH."
}

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

Push-Location $sourceDir
try {
    $arguments = @(
        '-interaction=nonstopmode',
        '-halt-on-error',
        '-no-shell-escape',
        "-output-directory=$sourceDir",
        (Join-Path $sourceDir 'resume.tex')
    )

    & $pdflatexPath @arguments
    if ($LASTEXITCODE -ne 0) {
        throw "The first LaTeX compilation failed with exit code $LASTEXITCODE."
    }

    # Run twice so hyperref can finish the PDF outline and link metadata.
    & $pdflatexPath @arguments
    if ($LASTEXITCODE -ne 0) {
        throw "The second LaTeX compilation failed with exit code $LASTEXITCODE."
    }
} finally {
    Pop-Location
}

$compiledPdf = Join-Path $sourceDir 'resume.pdf'
if (-not (Test-Path -LiteralPath $compiledPdf)) {
    throw "Compilation finished without producing $compiledPdf."
}

Copy-Item -LiteralPath $compiledPdf -Destination $outputPdf -Force
Write-Host "Updated $outputPdf"
