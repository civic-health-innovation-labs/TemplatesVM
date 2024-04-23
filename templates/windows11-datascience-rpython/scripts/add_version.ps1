function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$vmVersion = "1.0.0"
$vmVersion | Out-File C:\VMversion.txt

Write-Log "add_version script completed"