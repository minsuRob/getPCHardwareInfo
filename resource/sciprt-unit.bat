@ECHO OFF
SETLOCAL

for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

for /f "skip=1 tokens=1-6 delims=," %%A in ('wmic computersystem get Manufacturer^,Model^,TotalPhysicalMemory^,SystemType^,Workgroup /format:csv ^| findstr ","') do (
    set "HostName=%%A"
    set "Manufacturer=%%B"
    set "SystemModel=%%C"
    set "SystemType=%%D"
    set "TotalPhysicalMemory=%%E"
)

for /f "skip=1 tokens=1-5 delims=," %%A in ('wmic computersystem get Manufacturer^,Model^,TotalPhysicalMemory^,SystemType^,Workgroup /format:csv ^| findstr ","') do (
    set "HostName=%%A"
    set "Manufacturer=%%B"
    set "SystemModel=%%C"
    set "TotalPhysicalMemory=%%E"
)

rem pcSys
echo %NetworkIP%
ECHO %HostName%
ECHO %Manufacturer%
ECHO wmic csproduct get version
ECHO %SystemModel%
ECHO wmic bios get ReleaseDate

rem CPU - Maybe window bug? so that sequnce was change. 
for /f "skip=1 tokens=1-5 delims=," %%A in ('wmic cpu get name^, numberofcores^, NumberOfLogicalProcessors^, maxclockspeed^ /format:csv ^| findstr ","') do (
    set "maxclockspeed=%%A"
    set "maxclockspeed=%%B"
    set "cpuName=%%C"
    set "numberofcores=%%D"
    set "NumberOfLogicalProcessors=%%E"
)

ECHO %cpuName%
ECHO %numberofcores%
ECHO %NumberOfLogicalProcessors%
ECHO %maxclockspeed%

rem RAM
for /f "skip=1 tokens=1-2 delims=," %%A in ('wmic MEMORYCHIP get banklabel^ /format:csv ^| findstr ","') do (
    set "Caption=%%A"
    set "banklabel=%%B"
)

ECHO %banklabel%

for /f "skip=1 tokens=1-2 delims=," %%A in ('wmic memphysical get MemoryDevices^ /format:csv ^| findstr ","') do (
    set "Caption=%%A"
    set "MemoryDevices=%%B"
)

ECHO %MemoryDevices%

rem os
for /f "skip=1 tokens=1-4 delims=," %%A in ('wmic os get Caption^, version^, OSArchitecture^ /format:csv ^| findstr ","') do (
    set "Caption=%%A"
    set "Caption=%%B"
    set "OSArchitecture=%%C"
    set "OSVersion=%%D"
)

ECHO %Caption%
ECHO %OSVersion%
ECHO %OSArchitecture%



GOTO :eof