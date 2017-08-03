param(
	[string]$rev = "1"
)

.paket/paket restore
Push-Location devops-demo-dotnet
.\package.cmd $rev
If (Test-Path ..\octo) { rm ..\octo\*.* }
nuget pack devops-demo-dotnet.nuspec -Version "0.0.$rev" -OutputDirectory ..\octo -NoPackageAnalysis
Pop-Location
