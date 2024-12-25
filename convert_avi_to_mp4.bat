@echo off
REM Batch script to convert AVI files to MP4 using VLC
REM Enable delayed variable expansion
setlocal enabledelayedexpansion
REM Set the folder containing AVI files
set "SOURCE_FOLDER=D:\English Movies"

REM Temporary file for codec check
set "TEMP_FILE=codec_info.txt"

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

        REM Check if the output file already exists
        if exist "!OUTPUT_FILE!" (
            echo Skipping "%%F" as the output file "!OUTPUT_FILE!" already exists.
            goto :continue
        )

        REM Extract codec information using VLC
        echo Checking codec for "%%F"
        "C:\Program Files\VideoLAN\VLC\vlc.exe" -I dummy --codec "%%F" vlc://quit > "!TEMP_FILE!" 2>&1

        REM Check if the file already has the desired codec
        findstr /i "h264" "!TEMP_FILE!" >nul
        if not errorlevel 1 (
        echo Skipping conversion for "%%F" as it already uses h264 codec.
        ) else (
        REM Execute VLC to convert the file
        echo Converting "%%F" to "!OUTPUT_FILE!"
        REM "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" -I dummy "%%F" --sout=#transcode{vcodec=h264,acodec=mp4a,vb=800,ab=128}:standard{access=file,mux=mp4,dst="!OUTPUT_FILE!"} vlc://quit

        :continue
    )
)

echo Conversion completed!
pause
