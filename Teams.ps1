Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Teams" -Recurse -Force

Write-Host "Removed Microsoft Teams Classic"

try {
    Get-AppxPackage -Name *Teams* | Remove-AppxPackage -ErrorAction Stop
    Write-Host "Teams app removed successfully."
} catch {
    Write-Host "Failed to remove Teams app: $_"
}


$teamsUrl = "https://statics.teams.cdn.office.net/production-windows/1.7.00.18901/MSTeamsSetup.exe"
$downloadPath = "$env:TEMP\Teams_windows_x64.exe"


Write-Host "Downloading Microsoft Teams..."

Invoke-WebRequest -Uri $teamsUrl -OutFile $downloadPath


if (Test-Path $downloadPath) {
    Write-Host "Download completed. Installing Microsoft Teams..."
    
    Start-Process -FilePath $downloadPath -ArgumentList "/silent" -Wait
    Remove-Item $downloadPath -Force
    Write-Host "Installation Started."
} else {
    Write-Host "Download failed. Please check the URL and try again."
}