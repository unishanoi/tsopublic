$packages = @(
"Microsoft.Windows.ShellExperienceHost",
"Microsoft.Windows.StartMenuExperienceHost",
"Microsoft.Windows.PinningConfirmationDialog",
"Microsoft.Windows.PeopleExperienceHost",
"Microsoft.UI.Xaml",
"MicrosoftWindows.Client.Core",
"MicrosoftWindows.Client.CBS"
)
foreach ($pkg in $packages) {
$apps = Get-AppxPackage -Name $pkg -AllUsers
if ($apps) {
foreach ($app in $apps) {
$manifest = Join-Path $app.InstallLocation "AppXManifest.xml"
if (Test-Path $manifest) {
try {
Add-AppxPackage -DisableDevelopmentMode -Register $manifest -ForceApplicationShutdown
Write-Host " Re-registered: $($app.Name)"
} catch {
Write-Host "Skipped (in use or invalid): $($app.Name)"
}
} else {
Write-Host "Manifest not found for: $($app.Name)"
}
}
} else {
Write-Host "Package not found: $pkg"
}
}
