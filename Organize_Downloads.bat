@echo off
setlocal EnableExtensions EnableDelayedExpansion

title Downloads File Organizer

REM ============================================================
REM  Downloads File Organizer
REM  Organizes files in the current user's Downloads folder
REM ============================================================

set "DOWNLOADS=%USERPROFILE%\Downloads"
set "SCRIPT=%~nx0"

echo.
echo ============================================================
echo   DOWNLOADS FILE ORGANIZER
echo ============================================================
echo.
echo Target folder:
echo %DOWNLOADS%
echo.

if not exist "%DOWNLOADS%" (
    echo ERROR: Downloads folder was not found.
    pause
    exit /b 1
)

REM Create category folders
for %%F in (
    "PDFs"
    "Documents"
    "Spreadsheets"
    "Presentations"
    "Images"
    "Videos"
    "Audio"
    "Archives"
    "Installers"
    "Code"
    "Text_Files"
    "Data_Files"
    "Design_Files"
    "Other"
) do (
    if not exist "%DOWNLOADS%\%%~F" mkdir "%DOWNLOADS%\%%~F"
)

echo Organizing files...
echo.

REM PDFs
for %%E in (pdf) do call :MoveFiles "%%E" "PDFs"

REM Documents
for %%E in (doc docx odt rtf wps) do call :MoveFiles "%%E" "Documents"

REM Spreadsheets
for %%E in (xls xlsx xlsm xlsb ods) do call :MoveFiles "%%E" "Spreadsheets"

REM Presentations
for %%E in (ppt pptx pps ppsx odp) do call :MoveFiles "%%E" "Presentations"

REM Images
for %%E in (jpg jpeg png gif bmp webp tif tiff heic svg ico raw cr2 nef) do call :MoveFiles "%%E" "Images"

REM Videos
for %%E in (mp4 mov avi mkv m4v wmv flv webm mpg mpeg 3gp) do call :MoveFiles "%%E" "Videos"

REM Audio
for %%E in (mp3 wav m4a aac flac ogg wma opus) do call :MoveFiles "%%E" "Audio"

REM Archives
for %%E in (zip rar 7z tar gz tgz bz2 xz iso) do call :MoveFiles "%%E" "Archives"

REM Installers / packages
for %%E in (exe msi msix appx appxbundle cab apk) do call :MoveFiles "%%E" "Installers"

REM Code
for %%E in (py js jsx ts tsx java c cpp h hpp cs php rb go rs swift kt kts html htm css scss sass sql sh ps1 bat cmd json xml yaml yml) do call :MoveFiles "%%E" "Code"

REM Text files
for %%E in (txt md log ini cfg conf) do call :MoveFiles "%%E" "Text_Files"

REM Data files
for %%E in (csv tsv parquet avro db sqlite sqlite3) do call :MoveFiles "%%E" "Data_Files"

REM Design / creative files
for %%E in (psd ai eps xd fig sketch blend dwg dxf) do call :MoveFiles "%%E" "Design_Files"

REM Move remaining loose files into Other
for %%F in ("%DOWNLOADS%\*") do (
    if exist "%%~fF" (
        if not exist "%%~fF\" (
            if /I not "%%~nxF"=="%SCRIPT%" (
                move /Y "%%~fF" "%DOWNLOADS%\Other\" >nul 2>&1
                if not errorlevel 1 echo [Other] %%~nxF
            )
        )
    )
)

echo.
echo ============================================================
echo   ORGANIZATION COMPLETE
echo ============================================================
echo.
echo Your files have been organized inside:
echo %DOWNLOADS%
echo.
pause
exit /b

:MoveFiles
set "EXT=%~1"
set "CATEGORY=%~2"

for %%F in ("%DOWNLOADS%\*.%EXT%") do (
    if exist "%%~fF" (
        if /I not "%%~nxF"=="%SCRIPT%" (
            move /Y "%%~fF" "%DOWNLOADS%\%CATEGORY%\" >nul 2>&1
            if not errorlevel 1 echo [%CATEGORY%] %%~nxF
        )
    )
)
exit /b
