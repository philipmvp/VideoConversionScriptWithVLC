@echo off
REM Batch script to convert AVI files to MP4 using VLC
REM Enable delayed variable expansion
setlocal enabledelayedexpansion
REM Set the folder containing AVI files
set "SOURCE_FOLDER=D:\English Movies"

REM Find all .avi files in the source folder and subfolders
for /r "%SOURCE_FOLDER%" %%F in (*.avi) do (
    REM Get the input file name and path
    set "INPUT_FILE=%%F"
    
    REM Get the folder of the source file
    set "FILE_FOLDER=%%~dpF"
    
    REM Get the file name without extension
    set "FILE_NAME=%%~nF"
    
    REM Define the output file path in the same folder
    set "OUTPUT_FILE=!FILE_FOLDER!!FILE_NAME!.mp4"
    
	REM Execute VLC to convert the file
    echo Converting "%%F" to "!OUTPUT_FILE!"
     "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" -I dummy "%%F" --sout=#transcode{vcodec=h264,acodec=mp4a,vb=800,ab=128}:standard{access=file,mux=mp4,dst="!OUTPUT_FILE!"} vlc://quit
)

echo Conversion completed!
pause
