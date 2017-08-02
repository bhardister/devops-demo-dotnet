param(
	[string]$repoName,
	[string]$buildRef,
    [string]$buildCounter
)

#region GetVersion
[string]$lastVerTag = ''
$tagsExist = git tag
Write-Host "existing tags = `"$tagsExist`""
$lastVerTag = '0.0'
if ($tagsExist) {
	$lastTag = git describe --abbrev=0 --tags
	[bool]$lastTagValid = $lastTag -match '^[0-99][.][0-99]$'
	if ($lastTagValid) { $lastVerTag = $lastTag } 
}
Write-Host "lastVerTag = $lastVerTag"
[string]$majMin = $lastVerTag
Write-Host "majMin = $majMin"
$patch = $buildCounter
Write-Host "buildCounter = $buildCounter"
$semVer = $majMin + '.' + $buildCounter
Write-Host "semVer = $semVer"
$Hash = $buildRef
Write-Host "git sha (buildRef) = $Hash"
Write-Host "GitLab commit details at: https://gitlab.com/educationpartners/$repoName/commit/$Hash"
$ShortHash = $Hash.substring(0,8)
Write-Host "short sha = $ShortHash"
$version = $semVer + '-' + $ShortHash
Write-Host "version = $version"
return $version
#endregion

trap 
{ 
	$ErrorMessage = $_.Exception.Message
    write-Error ("ErrorMessage = $ErrorMessage")
	[System.Environment]::Exit(1)
}
