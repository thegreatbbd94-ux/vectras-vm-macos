$headers = @{
    "Host" = "osrecovery.apple.com"
    "Connection" = "close"
    "User-Agent" = "InternetRecovery/1.0"
}

$resp = Invoke-WebRequest -Uri "http://osrecovery.apple.com/" -Headers $headers -SessionVariable session
$sessionCookie = $session.Cookies.GetCookies("http://osrecovery.apple.com/") | Where-Object { $_.Name -eq "session" } | Select-Object -First 1

$postHeaders = @{
    "Host" = "osrecovery.apple.com"
    "Connection" = "close"
    "User-Agent" = "InternetRecovery/1.0"
    "Cookie" = "$($sessionCookie.Name)=$($sessionCookie.Value)"
    "Content-Type" = "text/plain"
}

$postBody = "cid=0123456789ABCDEF`nsn=00000000000000000`nbid=Mac-00BE6ED71E35EB86`nk=0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF`nfg=0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF`nos=default"

$recoveryResp = Invoke-WebRequest -Uri "http://osrecovery.apple.com/InstallationPayload/RecoveryImage" -Method Post -Headers $postHeaders -Body $postBody
$recoveryResp.Content
