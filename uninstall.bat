@echo off
chcp 65001 >nul
title BLACK SOULS II  魔书 Mod v3.0  卸载（整包替换法）
setlocal EnableExtensions

set "HERE=%~dp0"
if "%HERE:~-1%"=="\" set "HERE=%HERE:~0,-1%"

echo ============================================================
echo   BLACK SOULS II   魔书 Mod v3.0   -   卸载（整包替换法）
echo ============================================================
echo.

rem ================= 1. 定位游戏目录 =================
set "TARGET="

rem 1a) 拖放：把 游戏目录 / Game.exe / Game.rgss3a / Game.ini 拖到本脚本上
if not "%~1"=="" (
  if exist "%~1\Game.exe" set "TARGET=%~1"
  if /i "%~nx1"=="Game.exe" set "TARGET=%~dp1"
  if /i "%~nx1"=="Game.rgss3a" set "TARGET=%~dp1"
  if /i "%~nx1"=="Game.ini" set "TARGET=%~dp1"
)

rem 1b) 本目录、上 1~3 层本身就是游戏目录？
if not defined TARGET call :probe "%HERE%"
if not defined TARGET call :probe "%HERE%\.."
if not defined TARGET call :probe "%HERE%\..\.."
if not defined TARGET call :probe "%HERE%\..\..\.."

rem 1c) 兜底：扫 本目录 / 上 1~3 层 的“子目录”，若恰好一个含 Game.exe 则采用
if not defined TARGET call :scan "%HERE%"
if not defined TARGET call :scan "%HERE%\.."
if not defined TARGET call :scan "%HERE%\..\.."
if not defined TARGET call :scan "%HERE%\..\..\.."

if not defined TARGET (
  echo [未找到游戏目录]
  echo   请把游戏根目录^(或 Game.exe^)拖到本脚本图标上运行。
  echo.
  pause
  exit /b 1
)

pushd "%TARGET%" 2>nul
if errorlevel 1 goto :nrm_done
set "TARGET=%CD%"
popd
:nrm_done
if defined TARGET if "%TARGET:~-1%"=="\" set "TARGET=%TARGET:~0,-1%"

echo 游戏目录 : %TARGET%
echo.

if not exist "%TARGET%\Game.rgss3a.orig.bak" (
  echo [失败] 未找到备份 Game.rgss3a.orig.bak，无法自动还原。
  echo        如果你手动改过档案，请自行处理。
  echo.
  pause
  exit /b 1
)

echo 正在还原（约 515 MB，请稍候）...
copy /Y "%TARGET%\Game.rgss3a.orig.bak" "%TARGET%\Game.rgss3a.new" >nul
if errorlevel 1 (
  echo [失败] 还原失败：游戏可能正在运行，或没有写入权限。
  del /Q "%TARGET%\Game.rgss3a.new" 2>nul
  echo.
  pause
  exit /b 1
)
move /Y "%TARGET%\Game.rgss3a.new" "%TARGET%\Game.rgss3a" >nul
if errorlevel 1 (
  echo [失败] 覆盖失败，请关闭游戏后重试。
  echo.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo   [完成] 已还原原版：%TARGET%\Game.rgss3a
echo ============================================================
echo.
pause
exit /b 0

rem ---- 子程序：若 %~1 本身就是含 Game.exe 的目录，则设为 TARGET ----
:probe
if not defined TARGET if exist "%~1\Game.exe" set "TARGET=%~1"
exit /b 0

rem ---- 子程序：若 %~1 的子目录中恰好一个含 Game.exe，则设为 TARGET ----
:scan
if defined TARGET exit /b 0
set "SC_CNT=0"
set "SC_HIT="
for /d %%D in ("%~1\*") do (
  if exist "%%D\Game.exe" call :sc_hit "%%~fD"
)
if "%SC_CNT%"=="1" if not defined TARGET set "TARGET=%SC_HIT%"
exit /b 0

:sc_hit
set /a SC_CNT+=1 >nul
set "SC_HIT=%~1"
exit /b 0
