param(
	[string]$rev = "0",
	[string]$apiKey = $env:apiKey
)
Write-Host ("deploy-to-iis START: rev = $rev")
$p = "octo\devops-demo-dotnet.0.0." + $rev + ".nupkg"
$v = "0.0." + $rev
octo push --package $p --replace-existing --server http://172.31.23.165:8080 -apiKey $apiKey
Write-Host ("deploy-to-iis: push of package at $p to Octopus library complete")
octo create-release --project devops-demo-dotnet --version $v --package "devops-demo-dotnet:$v" --deployto dev --server http://172.31.23.165:8080 -apiKey $apiKey
Write-Host ("deploy-to-iis END: deploying devops-demo-dotnet." + $v + " to IIS dev environment")
