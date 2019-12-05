REM @echo off
for /f "tokens=2-8 delims=/:. " %%A in ("%date%:%time%: =0%%") do set "TIMESTAMP=%%C%%A%%B-%%D%%E"
if exist D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\count.html (
copy D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\count.html D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\tempCount.html
del /Q D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\count.html
)
REM call renameCount.bat
REM call D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\renameCount.bat

REM setlocal enableextensions


set fileCount=0 
for %%x in (dashboardNGTA*.html) do set /a fileCount+=1
echo %fileCount%
echo %TIMESTAMP% ^&nbsp; ^&nbsp; ^&nbsp; ^&nbsp; ^&nbsp; %fileCount% ^&nbsp; ^&nbsp; ^&nbsp; ^&nbsp; ^&nbsp; dashboardNGTA files >> D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\count.html
echo ^<br^> >> D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\count.html
type D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\tempCount.html >> D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\count.html
del /Q D:\RootCXReports\MarketPlace\regression\P_O_C__VinayConfig\tempCount.html

REM endlocal