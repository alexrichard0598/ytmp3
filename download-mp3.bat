@ECHO OFF
SetLocal DisableDelayedExpansion

if "%~dp0"=="" (
	SET current_path=%cd%
) else (
	SET "current_path=%~dp0"
)
IF %current_path:~-1%==\ SET current_path=%current_path:~0,-1%

ECHO Checking for git
git --version || winget install --id Git.Git -e --source winget

ECHO Checking for updates to script
git status || git init; git remote add origin https://github.com/alexrichard0598/ytmp3.git
git pull --set-upstream origin master

IF NOT EXIST "%current_path%\bin" (
	mkdir "%current_path%\bin"
)

IF NOT EXIST "%current_path%\bin\yt-dlp.exe" (
	ECHO Downloading yt-dlp
	curl -L https://github.com/yt-dlp/yt-dlp/releases/download/2026.03.17/yt-dlp.exe --output "%current_path%\bin\yt-dlp.exe"
)

IF NOT EXIST "%current_path%\bin\ffmpeg.exe" (
	IF NOT EXIST "%current_path%\ffmpeg.zip" (
		ECHO Downloading FFmpeg
		curl -L https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-n8.1-latest-win64-gpl-8.1.zip --output "%current_path%\ffmpeg.zip"
	)
	ECHO Extracting FFmpeg
	mkdir tmp
	tar -xf "%current_path%\ffmpeg.zip" -C "%current_path%mp"

	FOR /d %%D IN ("%current_path%mp\*") DO (
    IF EXIST "%%D\bin" (
      ECHO Moving FFmpeg to bin
      MOVE /y "%%D\bin\*" "bin\"
      RD /s /q "%current_path%mp"
    )
	)
)

ECHO Checking Deno version
deno -v || winget install DenoLand.Deno; ECHO Please rerun script.; EXIT

ECHO Checking for updates for yt-dlp
CALL "%current_path%\bin\yt-dlp.exe" -U

SET /P url=[Please enter YouTube URL Ex: https://www.youtube.com/watch?v=kR8rk3K6qzo] &REM

CALL "%current_path%\bin\yt-dlp.exe" --ffmpeg-location "%current_path%\bin" --paths "%current_path%\Downloads" "%url%"
