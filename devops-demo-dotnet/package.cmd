@echo off
DEL /F /Q /S AwsBundle\*.*
set year=%date:~-2%
call :trim %year% year
set month=%date:~4,2%
call :trim %month% month
set day=%date:~7,2%
call :trim %day% day
set hour=%time:~0,2%
call :trim %hour% hour
set min=%time:~3,2%
call :trim %min% min
set datetimef=%year%%month%%day%%hour%%min%
REM echo %datetimef%
"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe" devops-demo-dotnet.csproj /T:Package /P:Configuration="Debug";Platform="AnyCPU";IncludeIisSettings=false;PackageLocation=AwsBundle\demo-webapp.0.0.1-dev%datetimef%.zip
REM pause
goto eof

:trim
set %2=%1

:eof
