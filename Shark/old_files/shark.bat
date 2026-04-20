@echo off
:: By : Ryan Moore , Celso Garcia e Gabriel Fellipe.
:: Define o padrão de caracteres para UTF-8 para evitar erros de acentuação
chcp 65001 >nul
:: [AUTO-ELEVAÇÃO] Garante que o script rode como Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd.exe -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

color 0A

:MENU
cls
echo ============================================================
echo          SHARKAPP - MENU PRINCIPAL
echo ============================================================
echo.
echo  [1]  Ativação windows com a chave da BIOS
echo  [2]  Atualizar aplicativos (Winget)
echo  [3]  Ativação windows e office (Temporária)
echo  [4]  Reparar arquivos do sistema (SFC)
echo  [5]  Verificar disco (CHKDSK)
echo  [6]  Diagnostico de rede
echo  [7]  Criar inventário
echo  [8]  Instalar apps - Chris Titus Tool
echo  [0]  Sair
echo.
echo    By : Ryan Moore , Celso Garcia e Gabriel Fellipe.
echo ============================================================
echo  Pressione a tecla correspondente:
choice /c 123456780 /n >nul

if errorlevel 9 goto SAIR
if errorlevel 8 goto CHRISTITUS
if errorlevel 7 goto INVENTARIO
if errorlevel 6 goto REDE_MENU
if errorlevel 5 goto CHKDSK_MENU
if errorlevel 4 goto SFC
if errorlevel 3 goto ATIVAR
if errorlevel 2 goto WINGET_UPDATE
if errorlevel 1 goto CHAVE_BIOS
goto MENU

:: ============================================================
:CHAVE_BIOS
cls
echo ============================================================
echo         ATIVAÇÃO WINDOWS COM A CHAVE DA BIOS
echo ============================================================
echo.
set "BIOS_KEY="
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "(Get-CimInstance -ClassName 'SoftwareLicensingService').OA3xOriginalProductKey"') do set "BIOS_KEY=%%a"

if "%BIOS_KEY%"=="" (
    echo Não foi encontrada a chave na BIOS.
) else (
    echo Chave encontrada: %BIOS_KEY%
    echo.
    echo Instalando a chave...
    cscript //nologo %windir%\system32\slmgr.vbs /ipk %BIOS_KEY%
    echo.
    echo Ativando o Windows...
    cscript //nologo %windir%\system32\slmgr.vbs /ato
)
echo.
echo ============================================================
pause
goto MENU

:: ============================================================
:WINGET_UPDATE
cls
echo ============================================================
echo       ATUALIZAR APLICATIVOS (WINGET UPDATE --ALL)
echo ============================================================
echo.
echo  Verificando e instalando atualizacoes...
echo.
winget update --all --include-unknown
echo.
echo ============================================================
pause
goto MENU

:: ============================================================
:ATIVAR
cls
echo ============================================================
echo        ATIVAÇÃO WINDOWS E OFFICE (CRACKEADO)
echo ============================================================
echo.
echo  Forcando TLS 1.2 e abrindo ativador...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; irm https://get.activated.win | iex"
echo.
pause
goto MENU


:: ============================================================
:SFC
cls
echo ============================================================
echo         REPARAR ARQUIVOS DO SISTEMA (SFC + DISM)
echo ============================================================
echo.
echo  [1/2] Reparando imagem do Windows (DISM)...
echo  Aguarde, isso pode levar varios minutos.
echo.
DISM /Online /Cleanup-Image /RestoreHealth
if %errorlevel% neq 0 (
    echo.
    echo  Aviso: DISM nao concluiu com sucesso. Continuando com SFC...
)
echo.
echo ============================================================
echo  [2/2] Verificando arquivos do sistema (SFC)...
echo  Aguarde, isso pode levar alguns minutos.
echo.
sfc /scannow
echo.
echo  Verificacao e reparo concluidos!
echo ============================================================
pause
goto MENU

:: ============================================================
:CHKDSK_MENU
cls
echo ============================================================
echo              VERIFICACAO DE DISCO (CHKDSK)
echo ============================================================
echo.
echo  [1]  Corrigir erros do disco        (chkdsk /f)
echo  [2]  Recuperar setores defeituosos  (chkdsk /r)
echo  [3]  Reparo completo                (chkdsk /f /r /x)
echo  [4]  Verificar disco especifico
echo  [0]  Voltar ao menu
echo.
echo  Pressione a tecla correspondente:

choice /c 12340 /n >nul

if errorlevel 5 goto MENU
if errorlevel 4 goto CHKDSK_ESPECIFICO
if errorlevel 3 goto CHKDSK_FULL
if errorlevel 2 goto CHKDSK_R
if errorlevel 1 goto CHKDSK_F
goto CHKDSK_MENU

:CHKDSK_F
echo.
echo  Solicitando chkdsk /f para %SystemDrive%...
:: Agora sem o "echo S |", permitindo que você digite S ou N manualmente
chkdsk %SystemDrive% /f
echo.
pause
goto MENU

:CHKDSK_R
echo.
echo  Solicitando chkdsk /r para %SystemDrive%...
chkdsk %SystemDrive% /r
echo.
pause
goto MENU

:CHKDSK_FULL
echo.
echo  Solicitando chkdsk /f /r /x para %SystemDrive%...
chkdsk %SystemDrive% /f /r /x
echo.
pause
goto MENU

:CHKDSK_ESPECIFICO
echo.
set /p letra=  Digite a letra do disco (ex: D): 
echo.
chkdsk %letra%: /f /r /x
echo.
pause
goto MENU

:: ============================================================
:REDE_MENU
cls
echo ============================================================
echo              DIAGNOSTICO DE REDE
echo ============================================================
echo.
echo  [1]  Configuracoes basicas           (ipconfig)
echo  [2]  Detalhes completos              (ipconfig /all)
echo  [3]  Liberar IP                      (ipconfig /release)
echo  [4]  Renovar IP                      (ipconfig /renew)
echo  [5]  Liberar e renovar IP (reset)
echo  [6]  Ver endereco MAC                (getmac)
echo  [7]  Ping em host
echo  [0]  Voltar ao menu
echo.
echo  Pressione a tecla correspondente:

choice /c 12345670 /n >nul

if errorlevel 8 goto MENU
if errorlevel 7 goto REDE_PING
if errorlevel 6 goto REDE_MAC
if errorlevel 5 goto REDE_RESET
if errorlevel 4 goto REDE_RENEW
if errorlevel 3 goto REDE_RELEASE
if errorlevel 2 goto REDE_ALL
if errorlevel 1 goto REDE_BASIC
goto REDE_MENU

:REDE_BASIC
echo.
ipconfig
echo.
pause
goto MENU

:REDE_ALL
echo.
ipconfig /all
echo.
pause
goto MENU

:REDE_RELEASE
echo.
ipconfig /release
echo.
pause
goto MENU

:REDE_RENEW
echo.
ipconfig /renew
echo.
pause
goto MENU

:REDE_RESET
echo.
echo  Liberando IP...
ipconfig /release
echo  Renovando IP...
ipconfig /renew
echo.
pause
goto MENU

:REDE_MAC
echo.
getmac
echo.
pause
goto MENU

:REDE_PING
echo.
set /p host=  Digite o hostname ou IP: 
echo.
ping %host%
echo.
pause
goto MENU

:: ============================================================
:INVENTARIO
cls
echo ============================================================
echo          CRIAR INVENTÁRIO
echo ============================================================
echo.
echo  Gerando inventario...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference = 'SilentlyContinue'; Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name RequireSecuritySignature -Value 0 -Force; Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name AllowInsecureGuestAuth -Value 1 -Force; Start-Sleep 3; Restart-Service lanmanworkstation; Restart-Service lanmanserver; Start-Sleep 3; $hostname = 'C3PO.local'; $networkPath = '\\' + $hostname + '\inventarios\Ryan'; $mesAtual = Get-Date -Format 'MMMM'; $dataAtual = Get-Date -Format 'dd-MM-yyyy'; $mesPath = Join-Path $networkPath $mesAtual; $dataPath = Join-Path $mesPath $dataAtual; if (!(Test-Path $dataPath)) { New-Item -ItemType Directory -Path $dataPath -Force | Out-Null }; $clienteResposta = Read-Host 'Do you want to create a folder for a specific client? (Y/N)'; if ($clienteResposta -match '^[Yy]$') { $clienteNome = Read-Host 'Enter the clients name'; $dataPath = Join-Path $dataPath $clienteNome; if (!(Test-Path $dataPath)) { New-Item -ItemType Directory -Path $dataPath -Force | Out-Null } }; Write-Host 'Enter the file name (without extension)' -ForegroundColor Yellow; $nomeArquivo = Read-Host; $arquivo = Join-Path $dataPath ($nomeArquivo + '.txt'); $computador = 'Computer:      ' + (Get-CimInstance -ClassName Win32_ComputerSystem).Model; $cpu = 'CPU:           ' + (Get-CimInstance -ClassName Win32_Processor).Name; $cpuClock = '               ' + [math]::Round((Get-CimInstance -ClassName Win32_Processor).MaxClockSpeed / 1000, 2).ToString() + ' GHz'; $motherboard = 'Motherboard:   ' + (Get-CimInstance -ClassName Win32_BaseBoard).Manufacturer + ' ' + (Get-CimInstance -ClassName Win32_BaseBoard).Product; $bios = 'BIOS:          ' + (Get-CimInstance -ClassName Win32_BIOS).SMBIOSBIOSVersion; $chipset = 'Chipset:       ' + ((Get-PnpDevice | Where-Object { $_.Class -eq 'System' } | Select-Object -ExpandProperty FriendlyName | Where-Object { $_ -match 'Intel.*' }) -join ', '); $memoria = Get-CimInstance -ClassName Win32_PhysicalMemory; $totalMemoria = 'Memory:        ' + [math]::Round(($memoria | Measure-Object -Property Capacity -Sum).Sum / 1GB, 0).ToString() + ' MBytes'; $memoriaDetalhes = ($memoria | ForEach-Object { '               - ' + [math]::Round($_.Capacity / 1GB, 0).ToString() + ' MB ' + $_.Speed.ToString() + 'MHz ' + $_.Manufacturer + ' ' + $_.PartNumber }) -join [Environment]::NewLine; $gpu = Get-CimInstance -ClassName Win32_VideoController; $gpuDetalhes = ($gpu | ForEach-Object { 'Graphics:      ' + $_.Name + ' [' + $_.PNPDeviceID.Split('\')[1] + ']' + [Environment]::NewLine + '               ' + $_.Name + ', ' + [math]::Round($_.AdapterRAM / 1MB, 0).ToString() + ' MB' }) -join [Environment]::NewLine; $discos = Get-CimInstance -ClassName Win32_DiskDrive; $discosDetalhes = ($discos | ForEach-Object { 'Drive:         ' + $_.Model + ', ' + [math]::Round($_.Size / 1GB, 1).ToString() + ' GB, ' + $_.InterfaceType }) -join [Environment]::NewLine; $audio = Get-CimInstance -ClassName Win32_SoundDevice; $audioDetalhes = ($audio | ForEach-Object { 'Sound:         ' + $_.Name }) -join [Environment]::NewLine; $rede = 'Network:       ' + (Get-CimInstance -ClassName Win32_NetworkAdapter | Where-Object { $_.NetEnabled -eq $true } | Select-Object -ExpandProperty Name -First 1); $sistema = 'OS:            ' + (Get-CimInstance -ClassName Win32_OperatingSystem).Caption + ' (x64) Build ' + (Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber; $conteudo = @($computador, $cpu, $cpuClock, $motherboard, $bios, $chipset, $totalMemoria, $memoriaDetalhes, $gpuDetalhes, $discosDetalhes, $audioDetalhes, $rede, $sistema) -join [Environment]::NewLine; $conteudo | Out-File -Encoding utf8 $arquivo; Write-Output ('File saved at: ' + $arquivo); Start-Process 'explorer.exe' $dataPath"
echo.
pause
goto MENU

:: ============================================================
:CHRISTITUS
cls
echo ============================================================
echo        INSTALAR APPS - CHRIS TITUS TECH TOOL
echo ============================================================
echo.
echo  Abrindo Chris Titus Tool... aguarde.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb https://christitus.com/win | iex"
echo.
pause
goto MENU

:: ============================================================
:SAIR
cls
echo.
echo  Encerrando...
echo.
timeout /t 1 >nul
exit