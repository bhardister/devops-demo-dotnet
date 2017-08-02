#region GetOctoFeedApiValue
$octoFeedApiVarName = 'OCTO_FEED_API'
$octoFeedApiVar = Get-ChildItem env: | ? { $_.Name -eq $octoFeedApiVarName }
Write-Host ("GetOctoFeedApiValue - octoFeedApiVar = $octoFeedApiVar")
If (!($octoFeedApiVar)) { Throw "$octoFeedApiVarName environment variable not found, abort"}
$octoFeedApiValue = $octoFeedApiVar.Value 
return $octoFeedApiValue
#endregion

trap 
{ 
	$ErrorMessage = $_.Exception.Message
    write-Error ("ErrorMessage = $ErrorMessage")
	[System.Environment]::Exit(1)
}
