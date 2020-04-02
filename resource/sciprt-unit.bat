@ECHO OFF
SETLOCAL

for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

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
for /f "skip=1 tokens=1-2 delims=," %%A in ('wmic csproduct get version^ /format:csv ^| findstr ","') do (
    set "PCName=%%B"
)
ECHO %PCName%
ECHO %SystemModel%


for /f "skip=1 tokens=1-2 delims=," %%A in ('wmic bios get ReleaseDate^ /format:csv ^| findstr ","') do (
    set "ReleaseDate=%%B"
)
ECHO %ReleaseDate%

for /f "skip=1 tokens=1-2 delims=," %%A in ('wmic DISKDRIVE get SerialNumber^ /format:csv ^| findstr ","') do (
    set "SerialNumber=%%B"
)
ECHO %SerialNumber%


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
    set "banklabel=%%B"
)
rem % 1,073,741,824‬
echo %TotalPhysicalMemory%
ECHO %banklabel%

for /f "skip=1 tokens=1-2 delims=," %%A in ('wmic memphysical get MemoryDevices^ /format:csv ^| findstr ","') do (
    set "MemoryDevices=%%B"
)

ECHO %MemoryDevices%

for /f "skip=1 tokens=1-3 delims=," %%A in ('wmic diskdrive get model^, size^ /format:csv ^| findstr ","') do (
    set "driveModel=%%B"
    set "diskSize=%%C"
)

ECHO %diskSize%
ECHO %driveModel%

rem os
for /f "skip=1 tokens=1-4 delims=," %%A in ('wmic os get Caption^, version^, OSArchitecture^ /format:csv ^| findstr ","') do (
    set "Caption=%%B"
    set "OSArchitecture=%%C"
    set "OSVersion=%%D"
)

ECHO %Caption%
ECHO %OSVersion%
ECHO %OSArchitecture%
SET dst=%NetworkIP%, %HostName%, %Manufacturer%, %PCName%, %SystemModel%, %ReleaseDate%, %SerialNumber%, %cpuName%, %numberofcores%, %NumberOfLogicalProcessors%, %maxclockspeed%, %TotalPhysicalMemory%, %banklabel%, %MemoryDevices%, %diskSize%, %driveModel%, %Caption%, %OSVersion%, %OSArchitecture%
echo %dst% | clip
GOTO :eof