// Create-Profile.ps1
if (!(Test-Path -Path $profile.CurrentUserAllHosts)) {
  New-Item -ItemType File -Path $profile.CurrentUserAllHosts -Force
}