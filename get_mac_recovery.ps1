$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "InternetRecovery/1.0")
$client.Headers.Add("Host", "osrecovery.apple.com")

$resp = $client.DownloadString("http://osrecovery.apple.com/")
$cookie = $client.ResponseHeaders["Set-Cookie"]

$client2 = New-Object System.Net.WebClient
$client2.Headers.Add("User-Agent", "InternetRecovery/1.0")
$client2.Headers.Add("Host", "osrecovery.apple.com")
$client2.Headers.Add("Cookie", $cookie)
$client2.Headers.Add("Content-Type", "text/plain")

$body = "cid=0123456789ABCDEF`nsn=00000000000000000`nbid=Mac-00BE6ED71E35EB86`nk=0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF`nfg=0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF`nos=default"

$result = $client2.UploadString("http://osrecovery.apple.com/InstallationPayload/RecoveryImage", $body)
Write-Output $result
