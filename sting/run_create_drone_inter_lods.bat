@echo off
setlocal

if "%~1"=="" (
	echo Usage: %~nx0 P:\sting\drone_inter.p3d
	exit /b 1
)

set "OB=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder"
if not exist "%OB%\O2Script.exe" set "OB=C:\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder"

if not exist "%OB%\O2Script.exe" (
	echo O2Script.exe not found. Edit OB path inside %~nx0
	exit /b 1
)

cd /d "%OB%"
O2Script.exe -a "%~dp0create_drone_inter_lods.bio2s" "%~1"

endlocal
