@echo off

STARTLOCAL

REM Add required dlls to the PATH
echo Adding areaDetector and ffmpegServ bin dirs to PATH
set PATH=%PATH%;C:\epics\synApps_EA\support\areaDetector-1-9-1\bin\windows-x64-static;C:\epics\synApps_EA\support\ffmpegServer-2-1-1dls1\bin\windows-x64-static

REM set EPICS_CA_MAX_ARRAY_BYTES=100000000
REM echo EPICS_CA_MAX_ARRAY_BYTES=%EPICS_CA_MAX_ARRAY_BYTES%

REM set env vars here instead of in the EPICS ioc
set SES_BASE_DIR=C:/SES_1.4.0-r28_Win64/
set SES_INSTRUMENT_FILE=data/4ES276_Instrument.dat
set SES_INSTRUMENT_DLL=dll/SESInstrument.dll

echo Starting the Electron Analyser IOC
C:\epics\synApps_EA\support\electronAnalyser-2-13\bin\windows-x64-static\electronAnalyser.exe st.cmd
pause

ENDLOCAL
