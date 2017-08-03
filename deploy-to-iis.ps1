param(
	[string]$rev = "1",
	[string]$apiKey
)
$p = "octo\devops-demo-dotnet.0.0." + $rev + ".nupkg"
$v = "0.0." + $rev
octo push --package $p --replace-existing --server http://172.31.23.165:8080 -apiKey $apiKey
octo create-release --project devops-demo-dotnet --version $v --package "devops-demo-dotnet:$v" --deployto intg --server http://172.31.23.165:8080 -apiKey $apiKey
