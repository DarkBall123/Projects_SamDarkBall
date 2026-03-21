@echo off
setlocal

set "SCRIPT_DIR=%~dp0"

if "%~1"=="" (
	set "INPUT_P3D=%SCRIPT_DIR%drone_inter.p3d"
) else (
	set "INPUT_P3D=%~f1"
)

if not exist "%INPUT_P3D%" (
	echo Input P3D not found: %INPUT_P3D%
	echo Put drone_inter.p3d next to %~nx0 or pass a path explicitly.
	echo Example: %~nx0 drone_inter.p3d
	exit /b 1
)

set "OB=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder"
if not exist "%OB%\O2Script.exe" set "OB=C:\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder"

if not exist "%OB%\O2Script.exe" (
	echo O2Script.exe not found. Edit OB path inside %~nx0
	exit /b 1
)

cd /d "%OB%"
O2Script.exe -a "%SCRIPT_DIR%create_drone_inter_lods.bio2s" "%INPUT_P3D%"

endlocal
