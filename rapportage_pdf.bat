@echo off
echo Tests draaien op de %ENV% omgeving...
python -m robot -d results -v ENV:test *.robot

echo.
echo Test is klaar! 
echo Ik open nu het officiele rapport...
echo Druk in je browser op CTRL+P om het als PDF op te slaan.
echo.
start results/report.html
pause