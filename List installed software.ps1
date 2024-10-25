function Get-InstalledSoftware {
    $registryPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    $softwareList = @()

    foreach ($path in $registryPaths) {
        $softwareList += Get-ItemProperty $path | Where-Object { $_.DisplayName } | 
        Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
    }

    return $softwareList
}
Get-InstalledSoftware | Format-Table -AutoSize
