param(
	[string]$rev = "1"
)
Set-AWSCredentials -ProfileName bhardister
$key = "demo-webapp.0.0." + $rev + "-dev.zip"
$file = "AwsBundle\demo-webapp.0.0." + $rev + ".zip"
Write-S3Object -BucketName bhardister -Key $key -File $file
