@echo off
powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File ""%~dp0setup-ssh.ps1""' -Verb RunAs"
