@echo off
echo Alle tests verzamelen en uitvoeren...
:: We draaien alles wat begint met een cijfer
python -m robot -d results -v ENV:test *.robot

echo.
echo Klaar! Het rapport wordt geopend...
start results/report.html
pause