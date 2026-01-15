@echo off
setlocal enabledelayedexpansion

:: --- Advanced Configuration ---
set "VERSION=4.0-ADVANCED"
set "LOG_FILE=setup_history.log"
set "CART="
set "CART_COUNT=0"

:: --- Enable ANSI Colors via Registry ---
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: ANSI Escape Codes
set "ESC="
set "RED=%ESC%[91m"
set "GREEN=%ESC%[92m"
set "YELLOW=%ESC%[93m"
set "BLUE=%ESC%[94m"
set "MAGENTA=%ESC%[95m"
set "CYAN=%ESC%[96m"
set "WHITE=%ESC%[97m"
set "RESET=%ESC%[0m"

:: Check for Administrator privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo %YELLOW%Requesting administrative privileges...%RESET%
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
    echo [%DATE% %TIME%] --- Session Started: %VERSION% --- >> "%LOG_FILE%"

:MainMenu
cls
echo %CYAN%======================================================
echo          ULTIMATE PC SETUP ^& PACKAGE MANAGER v%VERSION%
echo ======================================================%RESET%
echo  1. DEV CORE      5. MEDIA/DESIGN   9. %YELLOW%REVIEW CART (%CART_COUNT% items)%RESET%
echo  2. IDEs/EDITORS  6. UTILS/SYSTEM   S. %GREEN%SEARCH ^& ADD%RESET%
echo  3. PRODUCTIVITY  7. AI TOOLS       U. %CYAN%UPDATE ALL%RESET%
echo  4. BROWSERS      8. SYS UPDATES    X. %RED%EXIT%RESET%
echo %CYAN%======================================================%RESET%
echo %WHITE%Current Cart: !CART!%RESET%
set /p main_choice="Select Category or Action: "

if /i "%main_choice%"=="1" goto MenuDevCore
if /i "%main_choice%"=="2" goto MenuIDEs
if /i "%main_choice%"=="3" goto MenuProductivity
if /i "%main_choice%"=="4" goto MenuBrowsers
if /i "%main_choice%"=="5" goto MenuMedia
if /i "%main_choice%"=="6" goto MenuUtilities
if /i "%main_choice%"=="7" goto MenuAITools
if /i "%main_choice%"=="8" goto UpdateSystem
if /i "%main_choice%"=="9" goto ReviewCart
if /i "%main_choice%"=="S" goto SearchPackages
if /i "%main_choice%"=="U" goto UpdateApps
if /i "%main_choice%"=="X" exit
goto MainMenu

:: --- Category Menus (Simplified for Cart Logic) ---

:MenuDevCore
cls
echo %BLUE%--- Programming ^& Dev Core ---%RESET%
echo  1. Python 3.12       4. Docker Desktop   7. winSCP
echo  2. Node.js LTS       5. Win Terminal     8. TablePlus
echo  3. Git               6. Postman          9. Terminus
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]            C. [Clear Cart]     I. [Install Cart Now]
set /p sub="Choice (Select num to add to cart): "
if /i "%sub%"=="B" goto MainMenu
if /i "%sub%"=="C" set "CART=" & set "CART_COUNT=0" & goto MenuDevCore
if /i "%sub%"=="I" goto ReviewCart
if "%sub%"=="1" call :AddToCart Python.Python.3.12
if "%sub%"=="2" call :AddToCart OpenJS.NodeJS.LTS
if "%sub%"=="3" call :AddToCart Git.Git
if "%sub%"=="4" call :AddToCart Docker.DockerDesktop
if "%sub%"=="5" call :AddToCart Microsoft.WindowsTerminal
if "%sub%"=="6" call :AddToCart Postman.Postman
if "%sub%"=="7" call :AddToCart WinSCP.WinSCP
if "%sub%"=="8" call :AddToCart TablePlus.TablePlus
if "%sub%"=="9" call :AddToCart Terminus.Terminus
goto MenuDevCore

:MenuIDEs
cls
echo %BLUE%--- IDEs ^& Editors ---%RESET%
echo  1. VS Code           3. Antigravity      5. Zed
echo  2. Cursor            4. JetBrains Toolbox
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]            C. [Clear Cart]     I. [Install Cart Now]
set /p sub="Choice: "
if /i "%sub%"=="B" goto MainMenu
if /i "%sub%"=="C" set "CART=" & set "CART_COUNT=0" & goto MenuIDEs
if /i "%sub%"=="I" goto ReviewCart
if "%sub%"=="1" call :AddToCart Microsoft.VisualStudioCode
if "%sub%"=="2" call :AddToCart Anysphere.Cursor
if "%sub%"=="3" call :AddToCart Google.Antigravity
if "%sub%"=="4" call :AddToCart JetBrains.Toolbox
if "%sub%"=="5" call :AddToCart Zed.Zed
goto MenuIDEs

:MenuProductivity
cls
echo %BLUE%--- Productivity ---%RESET%
echo  1. Notion            3. Slack            5. Teams
echo  2. Obsidian          4. Discord          6. Miro
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]            C. [Clear Cart]
set /p sub="Choice: "
if /i "%sub%"=="B" goto MainMenu
if /i "%sub%"=="1" call :AddToCart Notion.Notion
if /i "%sub%"=="2" call :AddToCart Obsidian.Obsidian
if /i "%sub%"=="3" call :AddToCart SlackTechnologies.Slack
if /i "%sub%"=="4" call :AddToCart Discord.Discord
if /i "%sub%"=="5" call :AddToCart Microsoft.Teams
if /i "%sub%"=="6" call :AddToCart Miro.Miro
goto MenuProductivity

:MenuBrowsers
cls
echo %BLUE%--- Browsers ---%RESET%
echo  1. Chrome            3. Brave            5. Vivaldi
echo  2. Firefox           4. Opera GX         6. Edge
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]            C. [Clear Cart]
set /p sub="Choice: "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :AddToCart Google.Chrome
if "%sub%"=="2" call :AddToCart Mozilla.Firefox
if "%sub%"=="3" call :AddToCart Brave.Brave
if "%sub%"=="4" call :AddToCart Opera.OperaGX
if "%sub%"=="5" call :AddToCart Vivaldi.Vivaldi
if "%sub%"=="6" call :AddToCart Microsoft.Edge
goto MenuBrowsers

:MenuMedia
cls
echo %BLUE%--- Media ^& Design ---%RESET%
echo  1. Spotify           3. OBS Studio       5. VLC
echo  2. GIMP              4. Audacity         6. Handbrake
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]            C. [Clear Cart]
set /p sub="Choice: "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :AddToCart Spotify.Spotify USER
if "%sub%"=="2" call :AddToCart GIMP.GIMP
if "%sub%"=="3" call :AddToCart OBSProject.OBSStudio
if "%sub%"=="4" call :AddToCart Audacity.Audacity
if "%sub%"=="5" call :AddToCart VideoLAN.VLC
if "%sub%"=="6" call :AddToCart Handbrake.Handbrake
goto MenuMedia

:MenuUtilities
cls
echo %BLUE%--- Utilities ---%RESET%
echo  1. 7-Zip             3. Rufus            5. CPU-Z
echo  2. PowerToys         4. HWInfo           6. GPU-Z
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]            C. [Clear Cart]
set /p sub="Choice: "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :AddToCart 7zip.7zip
if "%sub%"=="2" call :AddToCart Microsoft.PowerToys
if "%sub%"=="3" call :AddToCart Akeo.Rufus
if "%sub%"=="4" call :AddToCart REALiX.HWiNFO
if "%sub%"=="5" call :AddToCart CPUID.CPU-Z
if "%sub%"=="6" call :AddToCart TechPowerUp.GPU-Z
goto MenuUtilities

:MenuAITools
cls
echo %BLUE%--- AI Tools ---%RESET%
echo  1. Ollama
echo  2. Gemini CLI (NPM)
echo %BLUE%------------------------------------------------------%RESET%
echo  B. [Back]
set /p sub="Choice: "
if /i "%sub%"=="B" goto MainMenu
if "%sub%"=="1" call :AddToCart Ollama.Ollama
if "%sub%"=="2" call :AddToCart @google/gemini-cli NPM
goto MenuAITools

:: --- Core Action Engines ---

:SearchPackages
cls
echo %YELLOW%--- Search ^& Add ---%RESET%
set /p sq="Search query (or B to back): "
if /i "%sq%"=="B" goto MainMenu
winget search "%sq%"
set /p sid="Enter Winget ID to add to cart (or skip): "
if not "%sid%"=="" call :AddToCart %sid%
goto SearchPackages

:ReviewCart
cls
if "%CART%"=="" echo %RED%Cart is empty!%RESET% & pause & goto MainMenu
echo %GREEN%======================================================
echo          SELECTION CART REVIEW
echo ======================================================%RESET%
echo Items to install: %WHITE%!CART!%RESET%
echo %GREEN%======================================================%RESET%
set /p confirm="Proceed with installation? (Y/N): "
if /i "%confirm%" NEQ "Y" goto MainMenu

echo.
echo %CYAN%Starting Batch Installation...%RESET%
for %%a in (!CART!) do (
    set "PKG=%%a"
    :: Check for flags
    if "!PKG!"=="USER" ( 
        :: Handled by previous call logic 
    ) else if "!PKG!"=="NPM" (
        :: Handled by previous call logic
    ) else (
        :: Normal installation (This loop is a bit tricky with flags, so we'll 
        :: re-run a simplified cart processor)
    )
)

:: Re-processing the cart more cleanly
for %%i in (!CART_LOG!) do (
    set "item=%%i"
    :: Split item: PKGID|TYPE
    for /f "tokens=1,2 delims=|" %%a in ("!item!") do (
        if "%%b"=="USER" (
            call :SmartInstallUser %%a
        ) else if "%%b"=="NPM" (
            call :SmartInstallNPM %%a
        ) else (
            call :SmartInstall %%a
        )
    )
)

echo %GREEN%All installations complete!%RESET%
echo %YELLOW%Refreshing environment variables...%RESET%
call :RefreshEnv
set "CART="
set "CART_COUNT=0"
set "CART_LOG="
pause
goto MainMenu

:UpdateSystem
echo.
echo %CYAN%--- Updating Windows ^& Drivers ---%RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { if (!(Get-Module -ListAvailable PSWindowsUpdate)) { Write-Host 'Installing PSWindowsUpdate...' -ForegroundColor Cyan; Install-Module -Name PSWindowsUpdate -Force -AllowClobber -Scope CurrentUser }; Import-Module PSWindowsUpdate; Get-WindowsUpdate -Install -AcceptAll -AutoReboot }"
pause
goto MainMenu

:UpdateApps
echo.
echo %MAGENTA%--- Upgrading All Apps ---%RESET%
winget upgrade --all --silent --accept-package-agreements
pause
goto MainMenu

:: --- Advanced Helper Functions ---

:AddToCart
set "pkg=%~1"
set "type=%~2"
if "%type%"=="" set "type=WINGET"

:: Check for duplicates
echo !CART! | findstr /C:"%pkg% " >nul
if %errorlevel% equ 0 (
    echo %YELLOW%[%pkg% is already in cart]%RESET%
) else (
    set "CART=!CART!%pkg% "
    set "CART_LOG=!CART_LOG! "%pkg%|%type%""
    set /a CART_COUNT+=1
    echo %GREEN%[Added %pkg% to cart]%RESET%
)
timeout /t 1 >nul
goto :EOF

:SmartInstall
set "p=%~1"
echo %WHITE%[%p%] Checking...%RESET%
winget list --id "%p%" --exact >nul 2>&1
if %errorlevel% equ 0 (
    echo %YELLOW%[SKIP] %p% already exists.%RESET%
) else (
    echo %BLUE%[INSTALL] %p%...%RESET%
    winget install --id "%p%" --silent --accept-package-agreements --accept-source-agreements
    if %errorlevel% equ 0 ( 
        echo %GREEN%[SUCCESS] %p% installed.%RESET%
        echo [%DATE% %TIME%] SUCCESS: %p% >> "%LOG_FILE%"
    ) else (
        echo %RED%[FAIL] %p% installation failed.%RESET%
        echo [%DATE% %TIME%] FAILED: %p% >> "%LOG_FILE%"
    )
)
goto :EOF

:SmartInstallUser
set "p=%~1"
echo %WHITE%[%p%] Checking (User Context)...%RESET%
winget list --id "%p%" --exact >nul 2>&1
if %errorlevel% equ 0 (
    echo %YELLOW%[SKIP] %p% already exists.%RESET%
) else (
    echo %BLUE%[INSTALL] %p% via runas...%RESET%
    runas /trustlevel:0x20000 "cmd /c winget install --id %p% --silent --accept-package-agreements --accept-source-agreements"
    echo [%DATE% %TIME%] ATTEMPT: %p% (User Context) >> "%LOG_FILE%"
)
goto :EOF

:SmartInstallNPM
set "p=%~1"
echo %WHITE%[%p%] Checking NPM...%RESET%
call npm list -g "%p%" >nul 2>&1
if %errorlevel% equ 0 (
    echo %YELLOW%[SKIP] %p% already exists.%RESET%
) else (
    echo %BLUE%[INSTALL] %p% via npm...%RESET%
    call npm install -g "%p%"
    echo [%DATE% %TIME%] NPM: %p% >> "%LOG_FILE%"
)
goto :EOF

:RefreshEnv
powershell -Command "setx REFRESH_ENV_INTERNAL (Get-Date); [Environment]::SetEnvironmentVariable('PATH', [Environment]::GetEnvironmentVariable('PATH', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('PATH', 'User'), 'Process')"
echo %GREEN%Environment variables refreshed!%RESET%
goto :EOF
