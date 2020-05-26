#Requires -RunAsAdministrator
<#
    .SYNOPSIS
        Installs Adobe Acrobat Reader DC.
#>
[CmdletBinding()]
Param ()

try {
    $ArgumentList = "-sfx_nu /sALL /msi EULA_ACCEPT=YES ENABLE_CHROMEEXT=0 DISABLE_BROWSER_INTEGRATION=1 ENABLE_OPTIMIZATION=YES ADD_THUMBNAILPREVIEW=0 DISABLEDESKTOPSHORTCUT=1"
    Start-Process -FilePath AcroRdrDC2000920063_en_US.exe -ArgumentList $ArgumentList -Wait
}
catch { }

try {
    $ArgumentList = "/update AcroRdrDCUpd2000920065.msp /quiet /qn"
    Start-Process -FilePath 'C:\Windows\System32\msiexec.exe' -ArgumentList $ArgumentList -Wait
}
catch { }

# Test application is installed
$Success = 0; $Failed = 1
try {
    $File = Get-Item -Path "${env:ProgramFiles(x86)}\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe" -ErrorAction SilentlyContinue
    If ($File.VersionInfo.ProductVersion -ge "20.9.20063") { Return $Success } Else { Return $Failed }
}
catch {
    Return $Failed
}
