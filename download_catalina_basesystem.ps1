$url = "http://oscdn.apple.com/content/downloads/59/10/001-43312/oifium3yx72dhc4po3r65zfwblslmce191/RecoveryImage/BaseSystem.dmg?expires=1788280644~access=/content/downloads/59/10/001-43312/oifium3yx72dhc4po3r65zfwblslmce191/RecoveryImage/BaseSystem.dmg~md5=d18edf9a6df0cebfe151a17dc4829455"
$output = "BaseSystem.dmg"

Write-Output "Downloading Apple macOS Catalina BaseSystem.dmg..."
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Download complete!"
