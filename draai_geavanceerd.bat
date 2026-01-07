@echo off
title Robot Framework - Geavanceerde Suite
echo ====================================================
echo   BEZIG MET HET DRAAIEN VAN DE TESTSET (13 t/m 20)
echo ====================================================
echo.

call python -m robot -d results/geavanceerd tests/02_geavanceerd/

echo.
echo ====================================================
echo   KLAAR! Rapport staat in results/geavanceerd
echo ====================================================
pause