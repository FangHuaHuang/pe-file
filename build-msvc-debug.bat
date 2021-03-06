:: This builds using MS Visual C++ with debug symbols
:: Looks if one of %VS*COMNTOOLS% variables exists where * is one of 140 (2015),
:: 120 (2013), 110 (2012), 100 (2010), 90 (2008). They are tried in that order.

@set DIR=
@if not "%VS90COMNTOOLS%"=="" set DIR=%VS90COMNTOOLS%
@if not "%VS100COMNTOOLS%"=="" set DIR=%VS100COMNTOOLS%
@if not "%VS110COMNTOOLS%"=="" set DIR=%VS110COMNTOOLS%
@if not "%VS120COMNTOOLS%"=="" set DIR=%VS120COMNTOOLS%
@if not "%VS140COMNTOOLS%"=="" set DIR=%VS140COMNTOOLS%
@if "%DIR%"=="" (
	echo Could not find a Visual Studio toolkit
	pause
	goto :EOF
)

@echo Compiling with toolchain at "%DIR%" [DEBUG]

@set FLAGS=/nologo /MDd /MP /D _DEBUG /Zi /W4 /wd4201 /wd4480 /O2 /GS /EHa /D _UNICODE /D UNICODE
@set FILES=PEFile.cpp PEFileResources.cpp PEDataSource.cpp PEVersion.cpp

@echo Compiling 32-bit...
@call "%DIR%\..\..\VC\vcvarsall.bat" x86
cl %FLAGS% /FdPEFile_d.pdb %FILES%
lib /nologo /out:PEFile_d.lib *.obj
@del /F /Q *.obj >NUL 2>&1
@echo.

@echo Compiling 64-bit...
@call "%DIR%\..\..\VC\vcvarsall.bat" x64
cl %FLAGS% /FdPEFile64_d.pdb /c %FILES%
lib /nologo /out:PEFile64_d.lib *.obj
@del /F /Q *.obj >NUL 2>&1
@pause
