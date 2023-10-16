:: Get Admin
@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

@title CleanandFormat Utility- Version 1.1
@echo Clean and Format Utility - Version 1.1
@echo Made by: Cameron Reina
@echo ------------------------------------------------------
@echo off
set "ParentDir=%~dp0"
@diskpart /s %ParentDir%scripts\listdisk.txt
@echo:
@set /p "disk=Select the Disk You Wish to Clean and Format (ex: disk 2): "
@echo:
@echo You have selected: %disk%
@echo:
@set /p "disklabel=Enter a name for the Format Label: "
@echo:
@echo You have selected: %disklabel%
@echo:
@choice /c:qf /m "How extensive do you want to format? Quick or full?"
if %errorlevel% EQU 2 goto :full
if %errorlevel% EQU 1 goto :quick

:full
@diskpart /s %ParentDir%scripts\cleanandformatfull.txt
:quick
@diskpart /s %ParentDir%scripts\cleanandformatquick.txt

@cls
@choice /c:yn /m "You Have Completed the Process on %disk%. Would You Like to Work on Another Drive?"
if %errorlevel% EQU 2 goto :end
if %errorlevel% EQU 1 goto :restart
:restart
@cls
@call %ParentDir%CleanandFormat.bat

:end
exit