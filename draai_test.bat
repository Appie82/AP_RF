@echo off
python -m robot -d results -v ENV:test *.robot
start results/log.html