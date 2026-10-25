@echo off
rem Veylith installer for Windows.
rem
rem Built on the skills CLI from vercel-labs - https://skills.sh
rem
rem   install.cmd                 install everything, for every agent on the machine, globally
rem   set AGENT=* & install.cmd   install for every agent the CLI knows, installed or not
rem   set SCOPE= & install.cmd    install into the current project instead of the user dir
rem   set SKILL=0 & install.cmd   skip the companion design skills
rem   set VIDEO=0 & install.cmd   skip HyperFrames, the video and deck toolchain
rem
rem Without cloning, from cmd.exe:
rem
rem   curl -fsSL https://raw.githubusercontent.com/asterxsk/veylith/main/install.cmd | cmd
rem
rem Git Bash users can run ./install.sh instead.

setlocal enabledelayedexpansion

if not defined SCOPE set SCOPE=-g

rem The <nul on every npx call below is load-bearing under `... install.cmd | cmd`:
rem the shell reads this script from stdin and npx inherits it, so without the
rem redirect the CLI drains the rest of the file and cmd stops after the first
rem skill. install.sh has the same guard as </dev/null.
rem
rem AGENT unset means install to every agent the CLI detects on the machine, plus
rem the .agents/skills store they share. Pinning claude-code here installed the
rem skills only for Claude Code, which is not the intent.
set AGENTFLAG=
if defined AGENT set AGENTFLAG=-a %AGENT%
if "%SKILL%"=="" set SKILL=1
if "%VIDEO%"=="" set VIDEO=1

where npx >nul 2>nul
if errorlevel 1 (
  echo npx not found. Install Node.js 18 or newer first: https://nodejs.org
  exit /b 1
)

echo.
echo Veylith - principles for better work
if defined AGENT (echo agent: %AGENT%   scope: %SCOPE%) else (echo agent: all detected   scope: %SCOPE%)

echo.
echo npx skills add asterxsk/veylith --skill ouu-shiit
call npx -y skills add asterxsk/veylith --skill ouu-shiit %SCOPE% %AGENTFLAG% -y <nul
if errorlevel 1 exit /b 1

if not "%SKILL%"=="0" (
  rem Companion design skills: poise lives here; the others have upstream repos.
  echo.
  echo npx skills add asterxsk/veylith --skill poise
  call npx -y skills add asterxsk/veylith --skill poise %SCOPE% %AGENTFLAG% -y <nul
  if errorlevel 1 exit /b 1

  echo.
  echo npx skills add pbakaus/impeccable --skill impeccable
  call npx -y skills add pbakaus/impeccable --skill impeccable %SCOPE% %AGENTFLAG% -y <nul
  if errorlevel 1 exit /b 1

  echo.
  echo npx skills add Leonxlnx/taste-skill --skill design-taste-frontend
  call npx -y skills add Leonxlnx/taste-skill --skill design-taste-frontend %SCOPE% %AGENTFLAG% -y <nul
  if errorlevel 1 exit /b 1

  echo.
  echo npx skills add vercel-labs/agent-skills --skill web-design-guidelines
  call npx -y skills add vercel-labs/agent-skills --skill web-design-guidelines %SCOPE% %AGENTFLAG% -y <nul
  if errorlevel 1 exit /b 1
)

if not "%VIDEO%"=="0" (
  rem HyperFrames - video, motion graphics, and decks. Its own repo, its own
  rem router skill, and it keeps itself updated.
  rem
  rem Only the router is added here. Naming the skill explicitly is what keeps a
  rem scripted run off the interactive picker: an agent or non-interactive
  rem "skills add" without --skill installs all 21 published skills. The router
  rem installs each creation workflow on demand from there, and
  rem "npx hyperframes skills update" pulls the rest of the core set.
  echo.
  echo npx skills add heygen-com/hyperframes --skill hyperframes
  call npx -y skills add heygen-com/hyperframes --skill hyperframes %SCOPE% %AGENTFLAG% -y <nul
  if errorlevel 1 exit /b 1
)

echo.
echo ------------------------------------------------------------------
echo Done.
echo.
echo   ouu-shiit              the effect layer (this repo)
if not "%SKILL%"=="0" (
  echo   poise                  design cleanup, standalone or paired with effects
  echo   impeccable             visual direction and craft
  echo   design-taste-frontend  brief inference, motion budget, pre-flight check
  echo   web-design-guidelines  interface audit
)
if not "%VIDEO%"=="0" (
  echo   HyperFrames            video, motion graphics, and decks - the /hyperframes router
)
echo.
echo Optional, not installable - it is reference material, not a skill:
echo.
echo   awesome-design-md      74 analysed brand DESIGN.md systems
echo.
echo     git clone --depth 1 https://github.com/VoltAgent/awesome-design-md
echo.
echo   Copy a single brand file into a project root when a brief names one.
echo   See skills\ouu-shiit\reference\design-references.md.
if not "%VIDEO%"=="0" (
  echo.
  echo HyperFrames renders video locally with headless Chrome and FFmpeg. It needs
  echo Node.js 22 or newer and ffmpeg on your PATH - run "npx hyperframes doctor"
  echo to check. Local rendering is free, Apache-2.0; only "hyperframes cloud
  echo render" bills per minute.
  echo.
  echo This installer adds the /hyperframes router. Run "npx hyperframes skills
  echo update" to pull the rest of the core set - the domain skills and media-use;
  echo the router installs each creation workflow on demand from there.
  echo Installing the router rather than all 21 skills is deliberate - the picker
  echo is interactive-only, so a scripted skills add without --skill would pull
  echo the entire catalog.
  echo.
  echo   See skills\ouu-shiit\reference\hyperframes.md.
)
echo.
echo Restart your agent so the new skills are picked up.
echo.
echo Docs:  https://skills.sh
echo ------------------------------------------------------------------

endlocal
