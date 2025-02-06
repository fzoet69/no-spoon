@ECHO OFF
rem ***Batch program to click & run a python program with some parameters, like (latest) filename.***
rem May be adapted to allow batch processing for different parameters. Please date and comment updated bat file, and share.
rem Thx, Floris
rem Last edit: 2025-02-06

rem ***Set the python program name***
SET PyProg=Statement_Converter.py

rem ***Set input file name.***
rem Wildcard allowed. File with latest date will be selected later in this bat program.
rem Example: ing bank filename with wildcard "Alle_rekeningen_*.csv" for filenames like "Alle_rekeningen_06-12-2024_02-02-2025.csv"
SET FileIn=Alle_rekeningen_*.csv

rem ***Set output filename***
Set FileOut=INGstatement.qif

rem ***Get Downloads folder (2 methods)***
rem Get Downloads folder method 1:
SET downloads=%userprofile%\Downloads
rem ECHO Downloads folder: %downloads%
rem Get Downloads folder method 2:
rem FOR /F "USEBACKQ TOKENS=2,*" %%a IN (
rem	`REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V {374DE290-123F-4565-9164-39C4925E467B}`
rem ) DO (
rem	SET downloads=%%b

rem ***Get latest inputfile***
rem Will get the file with last date that conforms to the format of FileIn
FOR /f "tokens=*" %%i in ('dir %downloads%"\"%FileIn% /s /od /b') do set file=%%i
rem ECHO File to process: %file%

rem ***Set the command***
SET command=python %~dp0%PyProg%
rem Other possible format like "program inputfile > outputfile"
rem SET command=python %~dp0%PyProg% %file% > %FileOut%


rem ***Feedback to user with path, batch program, and python program so he can verify these are correct.***
ECHO This batch file (%~nx0) will run a python program located in the same directory with path:
ECHO %~dp0
ECHO Python program to execute: %PyProg%
rem ECHO This file (no extension): %~n0
rem ECHO Full path to this batch file: %~f0
ECHO.
ECHO Used command: %command%
rem ECHO Input file: %file%
rem ECHO Output file: %FileOut%
ECHO.
PAUSE

rem ***Execute python program***
%command%
ECHO.
PAUSE