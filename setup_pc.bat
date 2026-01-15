@echo off
setlocal enabledelayedexpansion

:: --- WarpDrive Kernel v8.2-DIRECT (TITAN EDITION) ---
set "VERSION=8.2-DIRECT"
set "LOG_FILE=setup_history.log"

:: Check for Administrator
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo [!] Administrator privileges required.
    echo [!] Attempting to elevate Titan Engine...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /B
)

:MainMenu
cls
echo ----------------------------------------------------
echo WARPDRIVE TITAN EDITION [v%VERSION%]
echo ----------------------------------------------------
echo * [0] Base Setup (Winget, Choco, PowerShell)
echo * [1] Programming and Dev Core
echo * [2] IDEs and Editors
echo * [3] Cloud and Infrastructure
echo * [4] Databases and Data Tools
echo * [5] Web Browsers and Networking
echo * [6] Media, Design and UI
echo * [7] Utilities and System Analysis
echo.
echo * [D] DEEP DEBLOAT (Services, Taskbar, Apps)
echo * [T] TITAN OPTIMIZATIONS (Power, Net, GodMode)
echo * [Q] QUANTUM SEARCH (Winget Search)
echo * [U] ULTIMATE MAINTENANCE (System Sync)
echo.
echo * [X] EXIT
echo ----------------------------------------------------
set /p opt="Selection> "

if /i "%opt%"=="0" goto MenuBaseTools
if /i "%opt%"=="1" goto MenuDevCore
if /i "%opt%"=="2" goto MenuIDEs
if /i "%opt%"=="3" goto MenuCloud
if /i "%opt%"=="4" goto MenuDatabases
if /i "%opt%"=="5" goto MenuBrowsers
if /i "%opt%"=="6" goto MenuMedia
if /i "%opt%"=="7" goto MenuUtilities
if /i "%opt%"=="D" goto WindowsDebloat
if /i "%opt%"=="T" goto SystemTweaks
if /i "%opt%"=="Q" goto SearchPackages
if /i "%opt%"=="U" goto UpdateApps
if /i "%opt%"=="X" exit
goto MainMenu

:: --- CATEGORY MENUS ---

:MenuBaseTools
cls
echo --- BASE SETUP AND PACKAGE MANAGERS ---
echo * [1] Update Winget (App Installer)
echo * [2] Install Chocolatey (Choco)
echo * [3] Install PowerShell 7 (Latest)
echo * [4] Install Scoop
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" (
    echo [TITAN] Updating Winget sources...
    winget source update
    pause
)
if "%sub%"=="2" (
    echo [TITAN] Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServiceProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    pause
)
if "%sub%"=="3" call :SmartInstall Microsoft.PowerShell
if "%sub%"=="4" (
    echo [TITAN] Installing Scoop...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (new-object net.webclient).downloadstring('https://get.scoop.sh')"
    pause
)
goto MenuBaseTools

:MenuDevCore
cls
echo --- PROGRAMMING AND DEV CORE ---
echo * [1] Python 3.12       * [5] Docker Desktop     * [9] Rust (via Rustup)
echo * [2] Node.js LTS       * [6] Windows Terminal   * [10] Java (OpenJDK 21)
echo * [3] Git               * [7] .NET 8 SDK         * [11] Go Language
echo * [4] C++ Build Tools   * [8] PowerShell 7       * [12] Ruby
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstall Python.Python.3.12
if "%sub%"=="2" call :SmartInstall OpenJS.NodeJS.LTS
if "%sub%"=="3" call :SmartInstall Git.Git
if "%sub%"=="4" call :SmartInstall Microsoft.VisualStudio.2022.BuildTools
if "%sub%"=="5" call :SmartInstall Docker.DockerDesktop
if "%sub%"=="6" call :SmartInstall Microsoft.WindowsTerminal
if "%sub%"=="7" call :SmartInstall Microsoft.DotNet.SDK.8
if "%sub%"=="8" call :SmartInstall Microsoft.PowerShell
if "%sub%"=="9" call :SmartInstall Rustlang.Rustup
if "%sub%"=="10" call :SmartInstall Microsoft.OpenJDK.21
if "%sub%"=="11" call :SmartInstall GoLang.Go
if "%sub%"=="12" call :SmartInstall RubyInstallerTeam.Ruby.3.2
goto MenuDevCore

:MenuIDEs
cls
echo --- IDEs AND EDITORS ---
echo * [1] VS Code           * [4] JetBrains Toolbox  * [7] PyCharm Community
echo * [2] Cursor            * [5] Zed Editor         * [8] IntelliJ Community
echo * [3] Antigravity       * [6] Notepad++          * [9] Sublime Text 4
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstall Microsoft.VisualStudioCode
if "%sub%"=="2" call :SmartInstall Anysphere.Cursor
if "%sub%"=="3" call :SmartInstall Google.Antigravity
if "%sub%"=="4" call :SmartInstall JetBrains.Toolbox
if "%sub%"=="5" call :SmartInstall ZedIndustries.Zed
if "%sub%"=="6" call :SmartInstall Notepad++.Notepad++
if "%sub%"=="7" call :SmartInstall JetBrains.PyCharm.Community
if "%sub%"=="8" call :SmartInstall JetBrains.IntelliJIDEA.Community
if "%sub%"=="9" call :SmartInstall SublimeHQ.SublimeText.4
goto MenuIDEs

:MenuCloud
cls
echo --- CLOUD AND INFRASTRUCTURE ---
echo * [1] AWS CLI           * [4] Terraform         * [7] Kubectl
echo * [2] Azure CLI         * [5] Ansible (WSL)     * [8] Helm
echo * [3] Google Cloud SDK  * [6] Docker Compose    * [9] Minikube
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstall Amazon.AWSCLI
if "%sub%"=="2" call :SmartInstall Microsoft.AzureCLI
if "%sub%"=="3" call :SmartInstall Google.CloudSDK
if "%sub%"=="4" call :SmartInstall Hashicorp.Terraform
if "%sub%"=="5" echo [info] Ansible requires WSL. Install Ubuntu from Store. & pause
if "%sub%"=="6" call :SmartInstall Docker.DockerCompose
if "%sub%"=="7" call :SmartInstall Kubernetes.kubectl
if "%sub%"=="8" call :SmartInstall Helm.Helm
if "%sub%"=="9" call :SmartInstall Kubernetes.minikube
goto MenuCloud

:MenuDatabases
cls
echo --- DATABASES AND DATA TOOLS ---
echo * [1] PostgreSQL 16     * [4] Redis (local)     * [7] TablePlus
echo * [2] MongoDB Shell     * [5] DBeaver Community * [8] SQLite Browser
echo * [3] MySQL Server      * [6] HeidiSQL          * [9] Compass (Mongo)
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstall PostgreSQL.PostgreSQL.16
if "%sub%"=="2" call :SmartInstall MongoDB.Shell
if "%sub%"=="3" call :SmartInstall MariaDB.Server
if "%sub%"=="4" call :SmartInstall Redis.Redis
if "%sub%"=="5" call :SmartInstall DBeaver.DBeaver.Community
if "%sub%"=="6" call :SmartInstall HeidiSQL.HeidiSQL
if "%sub%"=="7" call :SmartInstall TablePlus.TablePlus
if "%sub%"=="8" call :SmartInstall DBBrowserForSQLite.DBBrowserForSQLite
if "%sub%"=="9" call :SmartInstall MongoDB.Compass.Community
goto MenuDatabases

:MenuBrowsers
cls
echo --- WEB BROWSERS AND NETWORKING ---
echo * [1] Google Chrome     * [4] Wireshark         * [7] Postman
echo * [2] Mozilla Firefox   * [5] WinSCP            * [8] Insomnia
echo * [3] Brave Browser     * [6] FileZilla         * [9] Charles Proxy
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstall Google.Chrome
if "%sub%"=="2" call :SmartInstall Mozilla.Firefox
if "%sub%"=="3" call :SmartInstall Brave.Brave
if "%sub%"=="4" call :SmartInstall WiresharkFoundation.Wireshark
if "%sub%"=="5" call :SmartInstall WinSCP.WinSCP
if "%sub%"=="6" call :SmartInstall FileZilla.FileZilla
if "%sub%"=="7" call :SmartInstall Postman.Postman
if "%sub%"=="8" call :SmartInstall Insomnia.Insomnia
if "%sub%"=="9" call :SmartInstall XK72.Charles
goto MenuBrowsers

:MenuMedia
cls
echo --- MEDIA, DESIGN AND UI ---
echo * [1] Spotify           * [4] Figma Desktop     * [7] JetBrains Mono NF
echo * [2] VLC Media Player  * [5] OBS Studio        * [8] Fira Code
echo * [3] GIMP              * [6] Audacity          * [9] Cascadia Code
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstallUser Spotify.Spotify
if "%sub%"=="2" call :SmartInstall VideoLAN.VLC
if "%sub%"=="3" call :SmartInstall GIMP.GIMP.2
if "%sub%"=="4" call :SmartInstall Figma.Figma
if "%sub%"=="5" call :SmartInstall XPFFH613W8V6LV
if "%sub%"=="6" call :SmartInstall Audacity.Audacity
if "%sub%"=="7" call :SmartInstall DEVCOM.JetBrainsMonoNerdFont
if "%sub%"=="8" echo [info] Fira Code: install manually or via font-category if available. & pause
if "%sub%"=="9" echo [info] Cascadia Code is included with Windows Terminal. & pause
goto MenuMedia

:MenuUtilities
cls
echo --- UTILITIES AND SYSTEM ANALYSIS ---
echo * [1] 7-Zip             * [4] PowerToys         * [7] WinDirStat
echo * [2] HWInfo            * [5] Everything Search * [8] TreeSize Free
echo * [3] Rufus             * [6] CrystalDiskInfo   * [9] CPU-Z / GPU-Z
echo.
echo * [B] Back
set /p sub="Selection> "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :SmartInstall 7zip.7zip
if "%sub%"=="2" call :SmartInstall REALiX.HWiNFO
if "%sub%"=="3" call :SmartInstall Rufus.Rufus
if "%sub%"=="4" call :SmartInstall Microsoft.PowerToys
if "%sub%"=="5" call :SmartInstall voidtools.Everything
if "%sub%"=="6" call :SmartInstall CrystalDewWorld.CrystalDiskInfo
if "%sub%"=="7" call :SmartInstall WinDirStat.WinDirStat
if "%sub%"=="8" call :SmartInstall JAMSoftware.TreeSize.Free
if "%sub%"=="9" call :SmartInstall CPUID.CPU-Z & call :SmartInstall TechPowerUp.GPU-Z
goto MenuUtilities

:: --- TITAN MODULES ---

:WindowsDebloat
cls
echo !!! TITAN DEEP DEBLOAT !!!
echo.
echo * [1] Standard Debloat (Apps + Privacy)
echo * [2] DEEP Service Purge (Disable Telemetry/Tracking)
echo * [3] Taskbar Cleanup (Remove Widgets, Chat, Search)
echo * [4] TOTAL TITAN PURGE (All of the above)
echo * [B] Back
set /p dbl="Selection> "
if /i "%dbl%"=="B" goto MainMenu
if "%dbl%"=="1" (
    call :RunAppXDebloat
    call :RunPrivacyTweaks
    pause & goto MainMenu
)
if "%dbl%"=="2" call :RunServicePurge & pause & goto MainMenu
if "%dbl%"=="3" call :RunTaskbarCleanup & pause & goto MainMenu
if "%dbl%"=="4" (
    call :RunAppXDebloat
    call :RunPrivacyTweaks
    call :RunServicePurge
    call :RunTaskbarCleanup
    pause & goto MainMenu
)
goto WindowsDebloat

:RunServicePurge
echo [TITAN] Disabling non-essential services...
sc stop SysMain >nul 2>&1 & sc config SysMain start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1 & sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1 & sc config dmwappushservice start= disabled >nul 2>&1
sc stop TermService >nul 2>&1 & sc config TermService start= disabled >nul 2>&1
echo [OK] Telemetry and background services restricted.
goto :EOF

:RunTaskbarCleanup
echo [TITAN] Cleaning Windows 11 Taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v "ChatIcon" /t REG_DWORD /d 3 /f >nul 2>&1
echo [OK] Widgets, Search box, and Chat disabled.
goto :EOF

:RunAppXDebloat
echo [TITAN] Massive purge of pre-installed apps...
powershell -Command "& { $apps = @('Microsoft.XboxApp','Microsoft.XboxGameOverlay','Microsoft.ZuneVideo','Microsoft.ZuneMusic','Microsoft.BingNews','Microsoft.BingWeather','Microsoft.Getstarted','Microsoft.MicrosoftSolitaireCollection','Microsoft.SkypeApp','Microsoft.YourPhone','Microsoft.People','Microsoft.GetHelp','Microsoft.WindowsFeedbackHub','Microsoft.Messaging','Microsoft.MixedReality.Portal'); foreach ($app in $apps) { Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue } }"
echo [OK] Junk apps removed.
goto :EOF

:RunPrivacyTweaks
echo [TITAN] Hardening privacy registry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo [OK] Privacy hardened.
goto :EOF

:SystemTweaks
cls
echo --- TITAN PERFORMANCE ENGINE ---
echo.
echo * [1] Unlock Ultimate Performance Plan
echo * [2] Enable God Mode (Desktop Icon)
echo * [3] Titan Network Engine (TCP/Ack Boost)
echo * [4] Titan File Engine (NTFS Optimization)
echo * [5] Kill All Startup Delays
echo * [A] APPLY ALL TITAN TWEAKS
echo * [B] Back
set /p twk="Selection> "
if /i "%twk%"=="B" goto MainMenu
if "%twk%"=="1" (
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
    echo [OK] Ultimate Performance Plan Unlocked.
)
if "%twk%"=="2" (
    mkdir "%USERPROFILE%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" >nul 2>&1
    echo [OK] God Mode active on Desktop.
)
if "%twk%"=="3" (
    powershell -Command "foreach($int in (Get-NetAdapter | Where-Object Status -eq 'Up').InterfaceIndex) { New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces' -Name TcpAckFrequency -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue }"
    echo [OK] Network latency optimized.
)
if "%twk%"=="4" fsutil behavior set disablelastaccess 1 >nul 2>&1 & echo [OK] NTFS Faster.
if "%twk%"=="5" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /f >nul 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul 2>&1
    echo [OK] Boot speed increased.
)
if /i "%twk%"=="A" (
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
    mkdir "%USERPROFILE%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" >nul 2>&1
    powershell -Command "foreach($int in (Get-NetAdapter | Where-Object Status -eq 'Up').InterfaceIndex) { New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces' -Name TcpAckFrequency -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue }"
    fsutil behavior set disablelastaccess 1 >nul 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /f >nul 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul 2>&1
    echo [OK] Titan engine fully engaged.
)
pause
goto SystemTweaks

:SearchPackages
cls
echo --- QUANTUM SEARCH ---
set /p sq="Search Package: "
winget search "%sq%"
set /p sid="Enter ID to install: "
if not "%sid%"=="" call :SmartInstall %sid%
pause
goto MainMenu

:UpdateApps
echo [TITAN] Running Ultimate Maintenance...
echo > [1/3] Windows System Updates...
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { if (!(Get-Module -ListAvailable PSWindowsUpdate)) { Install-Module -Name PSWindowsUpdate -Force -AllowClobber -Scope CurrentUser }; Import-Module PSWindowsUpdate; Get-WindowsUpdate -Install -AcceptAll -AutoReboot }"
echo > [2/3] Application Suite Upgrade...
winget upgrade --all --silent --accept-package-agreements
echo > [3/3] Disk Integrity (Cleanup)...
cleanmgr /sageset:1 & cleanmgr /sagerun:1
echo [OK] System health restored.
pause & goto MainMenu

:: --- KERNEL ENGINE ---

:SmartInstall
set "p=%~1"
echo [CHECK] %p%...
winget list --id "%p%" --exact >nul 2>&1
if %errorlevel% equ 0 ( 
    echo [SKIP] %p% already installed.
    pause
) else (
    echo [TITAN-INSTALL] %p%...
    winget install --id "%p%" --silent --accept-package-agreements --accept-source-agreements
    if %errorlevel% equ 0 ( 
        echo [OK] %p% installed successfully. >> "%LOG_FILE%"
    ) else ( 
        echo [FAIL] %p% installation failed. >> "%LOG_FILE%"
    )
    pause
)
goto :EOF

:SmartInstallUser
set "p=%~1"
winget list --id "%p%" --exact >nul 2>&1
if %errorlevel% equ 0 ( 
    echo [SKIP] %p% already installed.
    pause
) else (
    echo [TITAN-USER] %p%...
    runas /trustlevel:0x20000 "cmd /c winget install --id %p% --silent --accept-package-agreements --accept-source-agreements"
    pause
)
goto :EOF

:SmartInstallNPM
set "p=%~1"
call npm list -g "%p%" >nul 2>&1
if %errorlevel% equ 0 ( 
    echo [SKIP] %p% already installed.
    pause
) else (
    echo [TITAN-NPM] %p%...
    call npm install -g "%p%"
    pause
)
goto :EOF
