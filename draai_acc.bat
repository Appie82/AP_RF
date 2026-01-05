@echo off
python -m robot -d results -v ENV:acc *.robot
start results/log.html