REM /======================================================
REM * got this out of 
REM * https://www.computing.net/answers/windows-xp/dos-batch-to-copy-first-100-lines-of-a-text-file/202404.html
REM * From G: windows command how to copy to extract the first line in a file
REM *
REM **/

@ECHO OFF
setlocal enabledelayedexpansion

SET /P maxlines=Enter number of lines to be moved to new txt document: 
SET /A linecount=0

FOR /F "delims=" %%A IN (ThrowAwayJustformatting.js) DO ( 
  IF !linecount! GEQ %maxlines% GOTO ExitLoop
  ECHO %%A >> C:\tmp\WinHeadOut.txt
  SET /A linecount+=1
)

:ExitLoop
ECHO All Done.
ECHO.
ECHO Press any key to close this window.
REM PAUSE>NUL
