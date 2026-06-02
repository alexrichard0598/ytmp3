Run this command in a directory of your choice to download the latest version of this script. DO NOT run this command in a non-empty folder, as it will download the files directly to the folder this is run from.

Command Prompt
```cmd
curl -L -o run.bat https://raw.githubusercontent.com/alexrichard0598/ytmp3/refs/heads/master/download-mp3.bat && .\run.bat && del run.bat
```

PowerShell
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/alexrichard0598/ytmp3/refs/heads/master/download-mp3.bat" -OutFile "run.bat"; .\run.bat; Remove-Item "run.bat"
```
