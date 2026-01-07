@echo off
title Robot Framework - Volledige Suite (20 Tests)
echo ====================================================
echo   BEZIG MET HET DRAAIEN VAN ALLE 20 TESTS...
echo   Mappen: 01_basis en 02_geavanceerd
echo ====================================================
echo.

call python -m robot -d results/volledig tests/

echo.
echo ====================================================
echo   KLAAR!
echo   Rapportage is gegenereerd in: results/volledig
echo ====================================================
pause