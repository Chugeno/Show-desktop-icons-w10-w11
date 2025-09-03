@echo off

:main_menu
cls
echo.
echo  ========================================
echo      WINDOWS CUSTOMIZATION MENU
echo  ========================================
echo.
echo  1. Manage Desktop Icons
echo  2. Exit
echo.
set /p choice="Choose an option and press Enter: "

if "%choice%"=="1" goto desktop_menu
if "%choice%"=="2" exit
goto main_menu

:desktop_menu
cls
echo.
echo  ========================================
echo          MANAGE DESKTOP ICONS
echo  ========================================
echo.
echo  1. Show/Hide 'This PC'
echo  2. Show/Hide 'Recycle Bin'
echo  3. Show/Hide 'User's Files'
echo  4. Show/Hide 'Control Panel'
echo  5. Show/Hide 'Network'
echo.
echo  6. Back to Main Menu
echo.
set /p d_choice="Choose the icon you want to configure: "

if "%d_choice%"=="1" call :toggle_icon "This PC" "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
if "%d_choice%"=="2" call :toggle_icon "Recycle Bin" "{645FF040-5081-101B-9F08-00AA002F954E}"
if "%d_choice%"=="3" call :toggle_icon "User's Files" "{59031a47-3f72-44a7-89c5-5595fe6b30ee}"
if "%d_choice%"=="4" call :toggle_icon "Control Panel" "{871C5380-42A0-1069-A2EA-08002B30309D}"
if "%d_choice%"=="5" call :toggle_icon "Network" "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}"
if "%d_choice%"=="6" goto main_menu
goto desktop_menu

:toggle_icon
cls
echo.
echo  Configuring "%~1"
echo.
echo  S - Show icon
echo  H - Hide icon
echo.
set /p action="Choose an action (S/H): "
set "reg_val=1"
if /i "%action%"=="S" set "reg_val=0"

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "%~2" /t REG_DWORD /d %reg_val% /f > nul

REM Force a desktop refresh to apply changes instantly
ie4uinit.exe -show

echo.
echo  Configuration for "%~1" applied.
pause
exit /b
