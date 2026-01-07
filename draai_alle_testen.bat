@echo off
title Robot Framework - Volledige Suite (20 Tests)
echo ====================================================
echo   BEZIG MET HET DRAAIEN VAN ALLE 20 TESTS...
echo ====================================================

:: We gebruiken %~dp0 om aan te geven: kijk in de map waar DIT bestand staat
call python -m robot -d results/volledig "%~dp0tests"

echo ====================================================
echo   KLAAR!
echo ====================================================
pause