cd C:\_s\devops-demo-dotnet
.paket/paket restore
Push-Location devops-demo-dotnet
.\package.cmd
nuget pack -Version 0.0.1 -OutputDirectory ..\octo
Pop-Location
