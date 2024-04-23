function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"

Set-Location -Path $BUILD_DIRECTORY

# LibreOffice downloading and installing
$LIBREOFFICE_INSTALLER="LibreOffice_24.2.2.1_Win_x86-64.msi"
$LIBREOFFICE_DOWNLOAD_URL="https://downloadarchive.documentfoundation.org/libreoffice/old/24.2.2.1/win/x86_64/$LIBREOFFICE_INSTALLER"
$LIBREOFFICE_INSTALL_ARGS="/quiet"

Write-Log "Downloading LibreOffice system installer..."
Invoke-WebRequest -Uri $LIBREOFFICE_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$LIBREOFFICE_INSTALLER"

Write-Log "Installing LibreOffice..."
Start-Process "$BUILD_DIRECTORY\$LIBREOFFICE_INSTALLER" -ArgumentList $LIBREOFFICE_INSTALL_ARGS -Wait

Write-Log "add_libreoffice script completed"