@echo off
DEL /F /Q /S AwsBundle\*.*
"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe" devops-demo-dotnet.csproj /T:Package /P:Configuration="Debug";Platform="AnyCPU";IncludeIisSettings=false;PackageLocation=..\AwsBundle\demo-webapp.0.0.1-dev%datetimef%.zip
