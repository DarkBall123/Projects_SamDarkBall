@echo off
setlocal

set "SCRIPT_DIR=%~dp0"

if "%~1"=="" goto use_default_input
set "INPUT_P3D=%~f1"
goto check_input

:use_default_input
set "INPUT_P3D=%SCRIPT_DIR%drone_inter.p3d"

:check_input
if exist "%INPUT_P3D%" goto find_ob
echo Input P3D not found: %INPUT_P3D%
echo Put drone_inter.p3d next to %~nx0 or pass a path explicitly.
echo Example: %~nx0 drone_inter.p3d
exit /b 1

:find_ob
set "OB=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder"
if exist "%OB%\O2Script.exe" goto run_script
set "OB=C:\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder"
if exist "%OB%\O2Script.exe" goto run_script

echo O2Script.exe not found. Edit OB path inside %~nx0
exit /b 1

:run_script
pushd "%OB%"
set "TEMPLATE_P3D=%SCRIPT_DIR%..\ArmaFPV\drone.p3d"
echo Rebuilding %INPUT_P3D% with target scale 0.0277778, forced \sting material paths, and support LOD template %TEMPLATE_P3D%
O2Script.exe -a "%SCRIPT_DIR%create_drone_inter_lods.bio2s" "%INPUT_P3D%" "%TEMPLATE_P3D%"
popd

endlocal
