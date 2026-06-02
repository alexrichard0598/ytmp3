@ECHO OFF
SetLocal DisableDelayedExpansion
SET current_path=%~dp0
IF %current_path:~-1%==\ SET current_path=%current_path:~0,-1%

IF NOT EXIST "%current_path%\bin\yt-dlp.exe" (
	ECHO "Downloading yt-dlp"
	curl -L https://github.com/yt-dlp/yt-dlp/releases/download/2026.03.17/yt-dlp.exe --output "%current_path%\bin\yt-dlp.exe"
)

IF NOT EXIST "%current_path%\bin\ffmpeg.exe" (
	ECHO "Downloading ffmpeg"
	curl -L https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-n8.1-latest-win64-gpl-8.1.zip --output "%current_path%\ffmpeg.zip"
	tar -xf "%current_path%\ffmpeg.zip" -C %current_path%\bin"
)

ECHO Checking for updates for yt-dlp
CALL "%current_path%\bin\yt-dlp.exe" -U

SET /P url=[Please enter YouTube URL Ex: https://www.youtube.com/watch?v=kR8rk3K6qzo] &REM

CALL "%current_path%bin\yt-dlp.exe" --ffmpeg-location "%current_path%bin" --paths "%current_path%Downloads" "%url%"
