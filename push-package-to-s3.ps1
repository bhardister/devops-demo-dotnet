param(
	[string]$rev = "1",
	[string]$myKeyId,
	[string]$mySecretKey
)

Set-AWSCredentials -AccessKey $myKeyId -SecretKey $mySecretKey -StoreAs bhardister
Initialize-AWSDefaults -ProfileName bhardister -Region us-west-2
Set-AWSCredentials -ProfileName bhardister

$key = "demo-webapp.0.0." + $rev + "-dev.zip"
$file = "AwsBundle\demo-webapp.0.0." + $rev + ".zip"
Write-S3Object -BucketName bhardister -Key $key -File $file
