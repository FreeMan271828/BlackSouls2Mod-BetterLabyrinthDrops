@echo off
chcp 65001 >nul
title BLACK SOULS II  魔书 Mod v3.0  安装（整包替换法）
setlocal EnableExtensions

set "HERE=%~dp0"
if "%HERE:~-1%"=="\" set "HERE=%HERE:~0,-1%"

echo ============================================================
echo   BLACK SOULS II   魔书 Mod v3.0   -   安装（整包替换法）
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
  echo.
  echo   请用下面任一方式重试：
  echo     1. 把本文件夹整个复制进游戏根目录^(有 Game.exe 的那层^)里，再双击 install.bat;
  echo     2. 或者把游戏根目录^(或 Game.exe^)拖到本脚本图标上运行。
  echo.
  pause
  exit /b 1
)

rem 规整路径，去掉 .. 之类
pushd "%TARGET%" 2>nul
if errorlevel 1 goto :nrm_done
set "TARGET=%CD%"
popd
:nrm_done
if defined TARGET if "%TARGET:~-1%"=="\" set "TARGET=%TARGET:~0,-1%"

echo 游戏目录 : %TARGET%
echo.

rem ================= 2. 校验来源档案 =================
if not exist "%HERE%\Game.rgss3a" (
  echo [失败] 本文件夹内缺少 Game.rgss3a，请确认压缩包已完整解压。
  echo.
  pause
  exit /b 1
)
for %%A in ("%HERE%\Game.rgss3a") do set "SRC_SIZE=%%~zA"
echo 待安装档案 : %SRC_SIZE% 字节

if not exist "%TARGET%\Game.rgss3a" (
  echo [失败] 目标目录里没有 Game.rgss3a，游戏目录可能不对：%TARGET%
  echo.
  pause
  exit /b 1
)
echo.

rem ================= 3. 备份原档 =================
if not exist "%TARGET%\Game.rgss3a.orig.bak" (
  copy /Y "%TARGET%\Game.rgss3a" "%TARGET%\Game.rgss3a.orig.bak" >nul
  if errorlevel 1 (
    echo [失败] 备份失败：游戏可能正在运行，或没有写入权限。
    echo.
    pause
    exit /b 1
  )
  echo [1/2] 已备份原版  -^>  Game.rgss3a.orig.bak
) else (
  echo [1/2] 已存在 Game.rgss3a.orig.bak，跳过备份。
)

rem ================= 4. 替换（先写临时名，验大小后再改名）=================
echo [2/2] 正在写入（约 515 MB，请稍候，勿关窗口）...
copy /Y "%HERE%\Game.rgss3a" "%TARGET%\Game.rgss3a.new" >nul
if errorlevel 1 (
  echo [失败] 写入失败：游戏可能在运行，或没有写入权限。
  echo        请完全退出游戏（并让 Steam 停止校验/更新）后重试。
  del /Q "%TARGET%\Game.rgss3a.new" 2>nul
  echo.
  pause
  exit /b 1
)
for %%A in ("%TARGET%\Game.rgss3a.new") do set "NEW_SIZE=%%~zA"
if not "%NEW_SIZE%"=="%SRC_SIZE%" (
  echo [失败] 写入大小不符（得到 %NEW_SIZE%，应为 %SRC_SIZE%），已放弃。
  del /Q "%TARGET%\Game.rgss3a.new" 2>nul
  echo.
  pause
  exit /b 1
)
move /Y "%TARGET%\Game.rgss3a.new" "%TARGET%\Game.rgss3a" >nul
if errorlevel 1 (
  echo [失败] 覆盖最终文件失败，请关闭游戏后重试。
  echo.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo   [完成] 已安装到：%TARGET%\Game.rgss3a
echo          档案大小：%NEW_SIZE% 字节
echo ============================================================
echo   卸载：双击 uninstall.bat（会把备份还原回去）
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
