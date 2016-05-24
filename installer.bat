@echo off

:: ToS install location
set "tosDir=D:\TOS\tos.junction\"

:: mod unzipped location
set "modDir=%~dp0\"

:: files to not install
set "excludeFiles=*.zip *.bat *.md *.txt"

:: directories to not install
set "excludeDirs=.git _data-src _patch-src"





:handleArgs
shift
:processArguments
:: Process all arguments in the order received
if defined %0 then (
    set %0
    shift
    goto:processArguments
)

:saveCurDir
set PCD="%CD%"

:installMods
cd /D "%modDir%"

:: XCOPY doesn't like working with junctions much...
REM XCOPY /E /I /H /Y current.junction D:\TOS\tos.junction\tmpAddon

ROBOCOPY "%CD%" %tosDir% *.* /E /XF %excludeFiles% /XD %excludeDirs%

:loadCurDir
cd /D "%PCD%"

:exit
pause
