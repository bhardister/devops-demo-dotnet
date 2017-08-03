param(
	[string]$rev = "1"
)

.paket/paket restore
Push-Location devops-demo-dotnet
.\package.cmd $rev
If (Test-Path ..\octo) { rm ..\octo\*.* }
nuget pack -Version "0.0.$rev" -OutputDirectory ..\octo
Pop-Location
