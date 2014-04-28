@echo off
SET SCRIPTS_DIR=%~dp0

START /B %SCRIPTS_DIR%\proj.win32\Debug\slotmachine-player.exe -workdir %SCRIPTS_DIR%\ -file %SCRIPTS_DIR%\scripts\main.lua -size 640x960
