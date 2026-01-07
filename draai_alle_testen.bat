@echo off
title Robot Framework - Volledige Suite (20 Tests)
echo ====================================================
echo   BEZIG MET HET DRAAIEN VAN ALLE 20 TESTS...
echo ====================================================

:: Voer de tests uit
call python -m robot -d results/volledig "%~dp0tests"

echo ====================================================
echo   KLAAR! RAPPORT WORDT GEOPEND...
echo ====================================================

:: Controleer of het logbestand bestaat en open het dan direct
if exist "%~dp0results\volledig\log.html" (
    start "" "%~dp0results\volledig\log.html"
) else (
    echo [FOUT] Logbestand niet gevonden in results/volledig/
)

pause