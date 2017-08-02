param(
	[string]$repoName,
	[string]$buildRef,
	[string]$groupUrlPathName='educationpartners' 
	# gitlab provides a group name, opus, and a separate group url path name, which was originally educationpartners, and must not be changed to avoid breaking existing links
)

#region IncrementBuildCounter
$buildCounterName = 'BUILD_COUNTER'
$privateTokenEnvVar = Get-ChildItem env: | ? { $_.Name -eq 'GITLAB_API_PRIVATE_TOKEN' }
If (!($privateTokenEnvVar)) { Throw "GITLAB_API_PRIVATE_TOKEN environment variable not found, abort"}
$privateToken = $privateTokenEnvVar.Value
$projectId = (ConvertFrom-Json (curl -sS -H "PRIVATE-TOKEN: $privateToken" "https://gitlab.com/api/v3/projects/$groupUrlPathName%2F$repoName")).id
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("PRIVATE-TOKEN", $privateToken)
$buildCounterExist = Invoke-RestMethod "https://gitlab.com/api/v3/projects/$projectId/variables" -Headers $headers | ? { $_.key -eq $buildCounterName }
If ($buildCounterExist) {
    [int]$buildCounter = (Invoke-RestMethod "https://gitlab.com/api/v3/projects/$projectId/variables/$buildCounterName" -Headers $headers).value
    Write-Host ("Prior buildCounter = $buildCounter")
    $buildCounter = $buildCounter + 1
    $response = curl -sS -X PUT -H "PRIVATE-TOKEN: $privateToken" "https://gitlab.com/api/v3/projects/$projectId/variables/$buildCounterName" -F "value=$buildCounter"
    [int]$buildCounter = (ConvertFrom-Json $response).Value
    Write-Host ("New buildCounter = $buildCounter")
} else {
    $response = curl -sS -X POST -H "PRIVATE-TOKEN: $privateToken" "https://gitlab.com/api/v3/projects/$projectId/variables" -F "key=$buildCounterName" -F "value=0"
    [int]$buildCounter = (ConvertFrom-Json $response).Value
    Write-Host ("No builds run, initial buildCounter = $buildCounter")
}
#endregion

trap 
{ 
	$ErrorMessage = $_.Exception.Message
    write-Error ("ErrorMessage = $ErrorMessage")
	[System.Environment]::Exit(1)
}
