$ErrorActionPreference = "SilentlyContinue"
$UserRN = $env:USERNAME
clear-host

# ------ Functions ---------
function Show-AsciiProgress {
    param (
        [int]$Percent
    )

    # Tamanho da barra
    $barLength = 40

    # Calcula quantos blocos █ preencher e quantos - deixar
    $filledLength = [Math]::Round($Percent * $barLength / 100)
    $emptyLength = $barLength - $filledLength
    $bar = "█" * $filledLength + "-" * $emptyLength

    # Mostra na MESMA LINHA, sobrescrevendo a anterior
    Write-Host "`r[$bar] $Percent%" -NoNewline
}

function ScannerAltLogoN {
Write-Host @"

    ╔════════════════════════════════════════════════════════════════════════════════════════════════╗
    ║    █████╗ ██╗  ████████╗    ███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗        ║
    ║   ██╔══██╗██║  ╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗       ║
    ║   ███████║██║     ██║       ███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝       ║
    ║   ██╔══██║██║     ██║       ╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗       ║
    ║   ██║  ██║███████╗██║       ███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║       ║
    ║   ╚═╝  ╚═╝╚══════╝╚═╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝       ║
    ║                                                                                                ║
    ╚════════════════════════════════════════════════════════════════════════════════════════════════╝

"@ -ForegroundColor Red
}

function ScannerAltLogo2{
Write-Host @"

    ╔════════════════════════════════════════════════════════════════════════════════════════════════╗
    ║    █████╗ ██╗  ████████╗    ███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗        ║
    ║   ██╔══██╗██║  ╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗       ║
    ║   ███████║██║     ██║       ███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝       ║
    ║   ██╔══██║██║     ██║       ╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗       ║
    ║   ██║  ██║███████╗██║       ███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║       ║
    ║   ╚═╝  ╚═╝╚══════╝╚═╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝       ║
    ║                                                                                                ║
    ║  Starting scan, ID = $ID                                                       ║
    ╚════════════════════════════════════════════════════════════════════════════════════════════════╝

"@ -ForegroundColor Red
}

function Finish {
Write-Host @"
    ╔════════════════════════════════════════════════════════════════════════════════════════════════════════╗
    ║   ███████╗ ██████╗ █████╗ ███╗   ██╗    ███████╗██╗███╗   ██╗██╗███████╗██╗  ██╗███████╗██████╗        ║
    ║   ██╔════╝██╔════╝██╔══██╗████╗  ██║    ██╔════╝██║████╗  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗       ║
    ║   ███████╗██║     ███████║██╔██╗ ██║    █████╗  ██║██╔██╗ ██║██║███████╗███████║█████╗  ██║  ██║       ║
    ║   ╚════██║██║     ██╔══██║██║╚██╗██║    ██╔══╝  ██║██║╚██╗██║██║╚════██║██╔══██║██╔══╝  ██║  ██║       ║
    ║   ███████║╚██████╗██║  ██║██║ ╚████║    ██║     ██║██║ ╚████║██║███████║██║  ██║███████╗██████╔╝       ║
    ║   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝    ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═════╝        ║
    ╚════════════════════════════════════════════════════════════════════════════════════════════════════════╝                                                                                                                           
"@ -ForegroundColor Green
}

function Get-ValidID {
    while ($true) {
        $ID = Read-Host "Insira o ID do usuario"
        if ($ID -match '^\d+$') {  
            return $ID
        }
        else {
            Write-Host "[ERRO] O ID deve conter apenas numeros! Tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 2
            Clear-Host  
            ScannerAltLogoN
        }
    }
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Get-BrazilianDate {
    return (Get-Date).ToString("dd/MM/yyyy HH:mm")
}

# ------ FimFunction ---------

ScannerAltLogoN


if (!(Test-Admin)) {
    Write-Warning "Execute o script como Administrador"
    Start-Sleep 5
    Exit
} 
    
$ID = Get-ValidID
Write-Host ""    
Clear-Host
    ScannerAltLogo2

Start-Sleep -Seconds 1
Write-Host -ForegroundColor Yellow "Starting scan"
Write-Host ""


# =========================================
# Início do Scanner
# =========================================
$ProgressPercent = 0

# =========================================
# Etapa 1: Detecção de scanners anteriores
# =========================================
$scanFlagFile = Join-Path -Path $env:SystemRoot -ChildPath "System32\Scan_Alt.txt"
$scanFlagFile2 = Join-Path -Path $env:TEMP -ChildPath "HAHAHAHAHAHAHAHAHA.llogamcache"
$scanFlagFile3 = Join-Path -Path $env:SystemRoot -ChildPath "System32\ASmoothadw.raw"
$scanFlagFile4 = Join-Path -Path $env:APPDATA -ChildPath ".minecraft\scan_marker.log"
$scanFlagFile5 = Join-Path -Path $env:TEMP -ChildPath "40009c63-d158-ca66d0dc00b4-nigg-amotha3.tmp"

$scanDetected = (Test-Path $scanFlagFile) -or (Test-Path $scanFlagFile2) -or (Test-Path $scanFlagFile3) -or (Test-Path $scanFlagFile4) -or (Test-Path $scanFlagFile5)

if ($scanDetected) {
    $existingFile = @($scanFlagFile, $scanFlagFile2, $scanFlagFile3, $scanFlagFile4, $scanFlagFile5 | Where-Object { Test-Path $_ })[0]
    $lastModified = (Get-Item $existingFile).LastWriteTime.ToString("dd/MM/yyyy -- HH:mm")
    
    $storedID = "Unknown"
    if (Test-Path $scanFlagFile) {
        $content = Get-Content $scanFlagFile -ErrorAction SilentlyContinue
        if ($content -match "ID do Usuario: (\d+)") { $storedID = $matches[1] }
    }
    if ($storedID -eq "Unknown" -and (Test-Path $scanFlagFile4)) {
        $content = Get-Content $scanFlagFile4 -ErrorAction SilentlyContinue
        if ($content -match "ID do Usuario: (\d+)") { $storedID = $matches[1] }
    }
    
    Write-Host "[!] Esse computador ja foi escaneado anteriormente! ($lastModified | ID: $storedID)" -ForegroundColor Red
    Write-Host ""
    
    Set-Content -Path $scanFlagFile -Value "ID do Usuario: $ID" -Force -ErrorAction SilentlyContinue
    Set-Content -Path $scanFlagFile4 -Value "ID do Usuario: $ID" -Force -ErrorAction SilentlyContinue

}
else {
    try {
        $minecraftDir = Join-Path -Path $env:APPDATA -ChildPath ".minecraft"
        if (-not (Test-Path $minecraftDir)) {
            New-Item -Path $minecraftDir -ItemType Directory -Force | Out-Null
        }
        
        New-Item -Path $scanFlagFile -ItemType File -Force | Out-Null
        New-Item -Path $scanFlagFile2 -ItemType File -Force | Out-Null
        New-Item -Path $scanFlagFile3 -ItemType File -Force | Out-Null
        New-Item -Path $scanFlagFile4 -ItemType File -Force | Out-Null
        New-Item -Path $scanFlagFile5 -ItemType File -Force | Out-Null
        
        Set-Content -Path $scanFlagFile -Value "ID do Usuario: $ID" -Force
        Set-Content -Path $scanFlagFile4 -Value "ID do Usuario: $ID" -Force

    }
    catch {
        Write-Host "[ERRO] Dm Smooth" -ForegroundColor Yellow
    }
}

$ProgressPercent += 5
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 2: Verificação de Máquina Virtual (VM)
# =========================================
$VMIdentified = $false

$systemInfo = Get-WmiObject -Class Win32_ComputerSystem
if ($systemInfo.Model -imatch "virtual") {
    $VMIdentified = $true
    Write-Host "[!] Generic VM detectada" -ForegroundColor Red
}
if ($systemInfo.Manufacturer -imatch "Microsoft Corporation" -and $systemInfo.Model -imatch "Virtual Machine") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (Hyper-V)" -ForegroundColor Red
}
$biosInfo = Get-WmiObject -Namespace "root\cimv2" -Class Win32_BIOS
if ($biosInfo.Manufacturer -imatch "VMware" -or $biosInfo.SMBIOSBIOSVersion -imatch "VMware") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (VMware)" -ForegroundColor Red
}
if ($systemInfo.Manufacturer -imatch "Oracle" -or $systemInfo.Model -imatch "VirtualBox") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (VirtualBox)" -ForegroundColor Red
}
if ($systemInfo.Model -imatch "Xen" -or $systemInfo.Manufacturer -imatch "Xen") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (Xen)" -ForegroundColor Red
}
if ($systemInfo.Model -imatch "KVM" -or $systemInfo.Manufacturer -imatch "QEMU") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (QEMU/KVM)" -ForegroundColor Red
}
if ($systemInfo.Manufacturer -imatch "Parallels" -or $systemInfo.Model -imatch "Parallels") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (Parallels)" -ForegroundColor Red
}
if ($systemInfo.Model -imatch "Amazon EC2" -or $systemInfo.Manufacturer -imatch "Amazon") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (Amazon EC2)" -ForegroundColor Red
}
if ($systemInfo.Model -imatch "Google" -or $systemInfo.Manufacturer -imatch "Google") {
    $VMIdentified = $true
    Write-Host "[!] Maquina Virtual detectada (Google Compute Engine)" -ForegroundColor Red
}
$dockerEnv = Test-Path -Path "C:\ProgramData\Docker"
if ($dockerEnv) {
    $VMIdentified = $true
    Write-Host "[!] Container Docker detectado" -ForegroundColor Red
}
if (-not $VMIdentified) {
    Write-Host "[*] Maquina virtual nao encontrada" -ForegroundColor Green
}
Write-Host ""

$ProgressPercent += 10
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# File Create
$OutputFile = "$env:USERPROFILE\Downloads\Alt Detector.txt"

if (Test-Path $OutputFile) {
    Remove-Item -Path $OutputFile -Force
}

New-Item -ItemType File -Path $OutputFile -Force | Out-Null


Add-Content -Path $OutputFile -Value "ALT Detector - By: Smooth"
Add-Content -Path $OutputFile -Value "Scan Result:"
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""  

$UserCachePath = "C:\Users\$UserRN\AppData\Roaming\.minecraft\usercache.json"
$UsernameCachePath = "C:\Users\$UserRN\AppData\Roaming\.minecraft\usernamecache.json"
$LauncherCachePath = "C:\Users\$UserRN\AppData\Roaming\.minecraft\launcher_accounts_microsoft_store.json"
$IASCachePath = "C:\Users\$UserRN\AppData\Roaming\.minecraft\config\ias.json"


# =========================================
# Etapa 3: Usercache
# =========================================
$UserCacheExists = Test-Path $UserCachePath
$UserCacheModificationDate = if ($UserCacheExists) { (Get-Item $UserCachePath).LastWriteTime.ToString("dd/MM/yyyy HH:mm") } else { "N/A" }

Add-Content -Path $OutputFile -Value "Usercache: $(if ($UserCacheExists) { 'Existe' } else { 'Nao existe' })"
Add-Content -Path $OutputFile -Value "Data de modificacao: $UserCacheModificationDate"
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""

if ($UserCacheExists) {
    $UserCacheContent = Get-Content -Path $UserCachePath -Raw | ConvertFrom-Json

    $FlattenedList = @()
    foreach ($entry in $UserCacheContent) {
        if ($entry -is [array]) {
            $FlattenedList += $entry
        } else {
            $FlattenedList += @($entry)
        }
    }
    $UserNames = $FlattenedList | ForEach-Object { $_.name }
    Add-Content -Path $OutputFile -Value "Contas encontradas no usercache.json:"
    Add-Content -Path $OutputFile -Value ""  
    $UserNames | ForEach-Object { Add-Content -Path $OutputFile -Value "    Conta: $_" }
}
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value ""

$ProgressPercent += 8
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 4: Usernamecache
# =========================================
$UsernameCacheExists = Test-Path $UsernameCachePath
$UsernameCacheModificationDate = if ($UsernameCacheExists) { (Get-Item $UsernameCachePath).LastWriteTime.ToString("dd/MM/yyyy HH:mm") } else { "N/A" }

Add-Content -Path $OutputFile -Value "Usernamecache: $(if ($UsernameCacheExists) { 'Existe' } else { 'Nao existe' })"
Add-Content -Path $OutputFile -Value "Data de modificacao: $UsernameCacheModificationDate"
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""

if ($UsernameCacheExists) {
    $UsernameCacheContent = Get-Content -Path $UsernameCachePath -Raw | ConvertFrom-Json

    Add-Content -Path $OutputFile -Value "Contas: "
    Add-Content -Path $OutputFile -Value ""  
    foreach ($key in $UsernameCacheContent.PSObject.Properties) {
        Add-Content -Path $OutputFile -Value "    Conta: $($key.Value)"
    }
}
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value ""

$ProgressPercent += 8
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 5: Microsoft Accounts
# =========================================
$LauncherCacheExists = Test-Path $LauncherCachePath
$LauncherCacheModificationDate = if ($LauncherCacheExists) { (Get-Item $LauncherCachePath).LastWriteTime.ToString("dd/MM/yyyy HH:mm") } else { "N/A" }

Add-Content -Path $OutputFile -Value "Launcher Accounts (Microsoft Store): $(if ($LauncherCacheExists) { 'Existe' } else { 'Nao existe' })"
Add-Content -Path $OutputFile -Value "Data de modificacao: $LauncherCacheModificationDate"
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""

if ($LauncherCacheExists) {
    $LauncherCacheContent = Get-Content -Path $LauncherCachePath -Raw | ConvertFrom-Json

    $AccountName = $LauncherCacheContent.accounts.PSObject.Properties | ForEach-Object { $_.Value.minecraftProfile.name }

    Add-Content -Path $OutputFile -Value "Contas :"
    Add-Content -Path $OutputFile -Value ""  
    $AccountName | ForEach-Object { Add-Content -Path $OutputFile -Value "    Conta: $_" }
}
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value ""

$ProgressPercent += 8
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 6: In-Game Account Switcher
# =========================================
$IASCacheExists = Test-Path $IASCachePath
$IASCacheModificationDate = if ($IASCacheExists) { (Get-Item $IASCachePath).LastWriteTime.ToString("dd/MM/yyyy HH:mm") } else { "N/A" }

Add-Content -Path $OutputFile -Value "In-Game Account Switcher: $(if ($IASCacheExists) { 'Existe' } else { 'Nao existe' })"
Add-Content -Path $OutputFile -Value "Data de modificacao: $IASCacheModificationDate"
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""

if ($IASCacheExists) {
    $IASCacheContent = Get-Content -Path $IASCachePath -Raw | ConvertFrom-Json

    Add-Content -Path $OutputFile -Value "Contas :"
    Add-Content -Path $OutputFile -Value ""
    foreach ($account in $IASCacheContent.accounts) {
        $accountType = if ($account.type -eq "ias:offline") { "Pirata" } else { "Original" }
        Add-Content -Path $OutputFile -Value "    Conta: $($account.name) | Tipo: $accountType"
    }
}
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""
Add-Content -Path $OutputFile -Value ""

$ProgressPercent += 8
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 7: Minecraft Logs
# =========================================
$MinecraftLogsPath = "C:\Users\$env:USERNAME\AppData\Roaming\.minecraft\logs"
$LogsExists = Test-Path $MinecraftLogsPath
$LogsModificationDate = if ($LogsExists) { (Get-Item $MinecraftLogsPath).LastWriteTime.ToString("dd/MM/yyyy HH:mm") } else { "N/A" }

Add-Content -Path $OutputFile -Value "Minecraft Logs: $(if ($LogsExists) { 'Existe' } else { 'Nao existe' })"
Add-Content -Path $OutputFile -Value "Data de modificacao: $LogsModificationDate"
Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
Add-Content -Path $OutputFile -Value ""

if ($LogsExists) {
    $foundAccounts = @()
    $logFiles = Get-ChildItem -Path $MinecraftLogsPath -Filter *.log.gz

    foreach ($logFile in $logFiles) {
        try {
            $gzipStream = [System.IO.Compression.GzipStream]::new([System.IO.File]::OpenRead($logFile.FullName), [System.IO.Compression.CompressionMode]::Decompress)
            $reader = [System.IO.StreamReader]::new($gzipStream, [System.Text.Encoding]::UTF8)  
            $logFileContent = $reader.ReadToEnd() -split "`n"  
            $reader.Close()
            $gzipStream.Close()

            foreach ($line in $logFileContent) {
                if ($line -match "Setting user: (\w+)") {
                    $accountName = $matches[1]
                    if ($foundAccounts -notcontains $accountName) {
                        Add-Content -Path $OutputFile -Value "Conta: $accountName"  
                        $foundAccounts += $accountName
                    }
                }
            }
        } catch {
            Write-Host "Erro ao processar: $($logFile.FullName)" -ForegroundColor Red  
        }
    }
    $latestLogPath = "$MinecraftLogsPath\latest.log"
    if (Test-Path $latestLogPath) {
        try {
            $latestLogContent = Get-Content -Path $latestLogPath -Encoding UTF8
            foreach ($line in $latestLogContent) {
                if ($line -match "Setting user: (\w+)") {
                    $accountName = $matches[1]
                    if ($foundAccounts -notcontains $accountName) {
                        Add-Content -Path $OutputFile -Value "Conta: $accountName"  
                        $foundAccounts += $accountName
                    }
                }
            }
        } catch {
            Write-Host "Erro ao processar: $latestLogPath" -ForegroundColor Red  
        }
    }

    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value ""
} else {
    Write-Host "Pasta de logs do Minecraft nao encontrada: $MinecraftLogsPath" -ForegroundColor Red
    Write-Host ""
}

$ProgressPercent += 8
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 8: Lunar Client
# =========================================
$LunarClientPath = "C:\Users\$UserRN\.lunarclient"
$LunarClientLogsPath = "C:\Users\$UserRN\.lunarclient\logs\game"
$LunarClientLauncherLog = "C:\Users\$UserRN\.lunarclient\logs\launcher\main.log"

if (Test-Path $LunarClientPath) {
    Add-Content -Path $OutputFile -Value "LunarClient Detectado!"
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""

    $foundLcAccounts = [System.Collections.Generic.HashSet[string]]::new()

    if (Test-Path $LunarClientLogsPath) {
        $logFiles = Get-ChildItem -Path $LunarClientLogsPath -Filter *.log
        foreach ($logFile in $logFiles) {
            $logFileContent = Get-Content -Path $logFile.FullName
            foreach ($line in $logFileContent) {
                if ($line -match "\[LC\] Setting user: (\S+)") {
                    $accountName = $matches[1]
                    if ($foundLcAccounts.Add($accountName)) {
                        Add-Content -Path $OutputFile -Value "    Conta: $accountName"
                    }
                }
            }
        }
    }
    if (Test-Path $LunarClientLauncherLog) {
        $launcherLogContent = Get-Content -Path $LunarClientLauncherLog
        foreach ($line in $launcherLogContent) {
            if ($line -match "\[Authenticator\] Creating Minecraft session for (\S+)") {
                $launcherAccount = $matches[1]
                if ($foundLcAccounts.Add($launcherAccount)) {
                    Add-Content -Path $OutputFile -Value "    Conta: $launcherAccount"
                }
            }
        }
    }
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value ""
} 

$ProgressPercent += 10
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 9: Lunar Client 2 (Offline)
# =========================================
$lunarOfflinePath = "C:\Users\$UserRN\.lunarclient\offline\multiver\logs"
$lunarExists = Test-Path $lunarOfflinePath

if ($lunarExists) {
    $lunarModDate = (Get-Item $lunarOfflinePath).LastWriteTime.ToString("dd/MM/yyyy HH:mm")

    Add-Content -Path $OutputFile -Value "Offline Lunar: Existe"
    Add-Content -Path $OutputFile -Value "Data de modificacao: $lunarModDate"
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""

    $offlineAccounts = [System.Collections.Generic.HashSet[string]]::new()
    $logGzFiles = Get-ChildItem -Path $lunarOfflinePath -Filter *.log.gz

    foreach ($logGzFile in $logGzFiles) {
        try {
            $gzipStream = [System.IO.Compression.GzipStream]::new([System.IO.File]::OpenRead($logGzFile.FullName), [System.IO.Compression.CompressionMode]::Decompress)
            $streamReader = [System.IO.StreamReader]::new($gzipStream, [System.Text.Encoding]::GetEncoding("ISO-8859-1"))
            $fileContent = $streamReader.ReadToEnd() -split "`r?`n"
            $streamReader.Close()
            $gzipStream.Close()

            foreach ($line in $fileContent) {
                if ($line -match "Setting user: ([^\s]+)") {
                    $user = $matches[1]
                    if ($user -notmatch "^Player\d+$") {
                        if ($offlineAccounts.Add($user)) {
                            Add-Content -Path $OutputFile -Value "    Conta: $user"
                        }
                    }
                }
            }
        } catch {
            Write-Host "Erro ao processar: $logGzFile.FullName" -ForegroundColor Red
        }
    }

    $latestLogPath = Join-Path $lunarOfflinePath "latest.log"
    if (Test-Path $latestLogPath) {
        $latestLogContent = Get-Content -Path $latestLogPath
        foreach ($line in $latestLogContent) {
            if ($line -match "Setting user: ([^\s]+)") {
                $user = $matches[1]
                if ($user -notmatch "^Player\d+$") {
                    if ($offlineAccounts.Add($user)) {
                        Add-Content -Path $OutputFile -Value "    Conta: $user"
                    }
                }
            }
        }
    }

    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value ""
}

$ProgressPercent += 8
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 10: Badlion Client
# =========================================
$BadlionClientPath = "C:\Users\$UserRN\AppData\Roaming\.minecraft\logs\blclient"
$BadlionClientLogsPath = "$BadlionClientPath\minecraft"

if (Test-Path $BadlionClientPath) {
    Add-Content -Path $OutputFile -Value "Badlion Client Detectado!"
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""

    $uniqueSettingUsers = [System.Collections.Generic.HashSet[string]]::new()

    if (Test-Path $BadlionClientLogsPath) {
        $logFiles = Get-ChildItem -Path $BadlionClientLogsPath -Filter *.log

        foreach ($logFile in $logFiles) {
            $logFileContent = Get-Content -Path $logFile.FullName

            foreach ($line in $logFileContent) {
                if ($line -match "Setting user:\s*(\S+)") {
                    $user = $matches[1]
                    if ($uniqueSettingUsers.Add($user)) {
                        Add-Content -Path $OutputFile -Value "    Conta: $user"
                    }
                }
            }
        }
    }

    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value ""
}

$ProgressPercent += 5
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 11: Badlion Client 2 (Change Account)
# =========================================
if (Test-Path $BadlionClientPath) {
    Add-Content -Path $OutputFile -Value "Badlion 2 (Change Account)"
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""

    $uniqueSessions = [System.Collections.Generic.HashSet[string]]::new()

    if (Test-Path $BadlionClientLogsPath) {
        $logFiles = Get-ChildItem -Path $BadlionClientLogsPath -Filter *.log

        foreach ($logFile in $logFiles) {
            $logFileContent = Get-Content -Path $logFile.FullName

            foreach ($line in $logFileContent) {
                if ($line -match "Adding session:\s*(\S+)") {
                    $sessionAccount = $matches[1]
                    if ($uniqueSessions.Add($sessionAccount)) {
                        Add-Content -Path $OutputFile -Value "    Conta: $sessionAccount"
                    }
                }
            }
        }
    }

    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value ""
}

$ProgressPercent += 5
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 12: TLauncher
# =========================================
$TLauncherPath = "C:\Users\$UserRN\AppData\Roaming\.tlauncher"
$TLauncherLogsPath = "$TLauncherPath\logs\tlauncher"

$foundAccounts = @()

if (Test-Path $TLauncherPath) {
    Add-Content -Path $OutputFile -Value "TLauncher Detectado!"
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""

    if (Test-Path $TLauncherLogsPath) {
        $logFiles = Get-ChildItem -Path $TLauncherLogsPath -Filter *.log
        
        foreach ($logFile in $logFiles) {
            $logFileContent = Get-Content -Path $logFile.FullName

            foreach ($line in $logFileContent) {
                if ($line -match "displayName=([^\s,]+)") {
                    $accountName = $matches[1]  

                    if ($foundAccounts -notcontains $accountName) {
                        Add-Content -Path $OutputFile -Value "    Conta: $accountName"
                        $foundAccounts += $accountName
                    }
                }
            }
        }
    }
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value "----------------------------------------------------------"
    Add-Content -Path $OutputFile -Value ""
    Add-Content -Path $OutputFile -Value ""
}

$ProgressPercent += 5
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 13: Hwid Collector
# =========================================
$outputFile2 = "$env:USERPROFILE\Downloads\Serial Collector.txt"

$pcName = (Get-WmiObject Win32_ComputerSystem).Name
$mbUUID = (Get-WmiObject Win32_ComputerSystemProduct).UUID
$ramSerials = Get-WmiObject Win32_PhysicalMemory | ForEach-Object { $_.SerialNumber }
$diskSerials = Get-WmiObject Win32_DiskDrive | ForEach-Object { $_.SerialNumber }
$volumeSerials = Get-WmiObject Win32_LogicalDisk | ForEach-Object { $_.VolumeSerialNumber }
$macAddresses = (Get-WmiObject Win32_NetworkAdapter | Where-Object { $_.MACAddress -ne $null } | ForEach-Object { $_.MACAddress })[0]
$displayDeviceID = Get-WmiObject Win32_DesktopMonitor | ForEach-Object { $_.PNPDeviceID }

@"
==================================================
PC Name: $pcName
==================================================
UUID: $mbUUID
==================================================
DisplayDeviceID:
`t$($displayDeviceID -join "`n`t")
==================================================
MAC Address:
`t$macAddresses
==================================================
RAM Serials:
`t$($ramSerials -join "`n`t")
==================================================
Disk Serials:
`t$($diskSerials -join "`n`t")
==================================================
LogicalDisk VolumeSerial:
`t$($volumeSerials -join "`n`t")
==================================================
"@ | Out-File -FilePath $outputFile2 -Encoding UTF8

$ProgressPercent += 5
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200

# =========================================
# Etapa 14: Formatação e informações finais
# =========================================
$osInfo = Get-WmiObject -Class Win32_OperatingSystem
if ($osInfo) {
    $installationDate = [System.Management.ManagementDateTimeConverter]::ToDateTime($osInfo.InstallDate)
    $lastBootUpTime = [System.Management.ManagementDateTimeConverter]::ToDateTime($osInfo.LastBootUpTime)

    $formattedInstallationDate = $installationDate.ToString("dd/MM/yyyy, HH:mm:ss")
    $formattedLastBootUpTime = $lastBootUpTime.ToString("dd/MM/yyyy, HH:mm:ss")

    Write-Host -ForegroundColor RED "Data da instalacao original: " -NoNewLine
    Write-Host "$formattedInstallationDate"
    Write-Host ""
    Write-Host -ForegroundColor RED "Tempo de Inicializacao do Sistema: " -NoNewLine
    Write-Host "$formattedLastBootUpTime"
} else {
    Write-Host "Erro: Nao foi possível obter as informacões do sistema."
}
Write-Host ""

$ProgressPercent = 100
Show-AsciiProgress -Percent $ProgressPercent
Start-Sleep -Milliseconds 200
Write-Host ""

Write-Host -ForegroundColor Yellow "Alt Scan salvo em: " -NoNewLine  
Write-Host "$OutputFile"
Write-Host ""
Write-Host -ForegroundColor Yellow "Serial Scanner salvo em: " -NoNewLine  
Write-Host "$outputFile2"
Write-Host ""

Finish