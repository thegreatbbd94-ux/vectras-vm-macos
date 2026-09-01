$dmg = "BaseSystem.dmg"
$img = "BaseSystem.img"
$streamIn = [System.IO.File]::OpenRead($dmg)
$streamOut = [System.IO.File]::Create($img)
$buffer = New-Object byte[] 65536

# Skip 200MB (209715200 bytes)
$skipBytes = 209715200L
$streamIn.Seek($skipBytes, [System.IO.SeekOrigin]::Begin) | Out-Null

while (($read = $streamIn.Read($buffer, 0, $buffer.Length)) -gt 0) {
    $streamOut.Write($buffer, 0, $read)
}

$streamIn.Close()
$streamOut.Close()
Write-Output "Extracted BaseSystem.img!"
