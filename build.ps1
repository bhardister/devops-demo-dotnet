param(
	[string]$rev = "1"
)

cd C:\_s\devops-demo-dotnet
.paket/paket restore
Push-Location devops-demo-dotnet
.\package.cmd $rev
rm ..\octo\*.*
nuget pack -Version "0.0.$rev" -OutputDirectory ..\octo
Pop-Location
