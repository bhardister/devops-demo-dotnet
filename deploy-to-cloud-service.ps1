param(
	[string]$rev = "0",
	[string]$myKeyId = $env:myKeyId,
	[string]$mySecretKey = $env:mySecretKey
)
Write-Host ("deploy-to-cloud-service START: rev = $rev")
Set-AWSCredentials -AccessKey $myKeyId -SecretKey $mySecretKey -StoreAs bhardister
Initialize-AWSDefaults -ProfileName bhardister -Region us-west-2
Set-AWSCredentials -ProfileName bhardister
Write-Host ("deploy-to-cloud-service: authenticated with AWS")

$key = "demo-webapp.0.0." + $rev + ".zip"
$file = "AwsBundle\demo-webapp.0.0." + $rev + ".zip"
Write-S3Object -BucketName bhardister -Key $key -File $file
Write-Host ("deploy-to-cloud-service: file $file uploaded to S3 bucket bhardister as $key")

$v = "devops-demo-dotnet.0.0." + $rev
$result = New-EBApplicationVersion -ApplicationName 'devops-demo-dotnet' -VersionLabel $v -SourceBundle_S3Bucket 'bhardister' -SourceBundle_S3Key $key -Description 'demo' -AutoCreateApplication $false
Write-Host ("deploy-to-cloud-service: added application version $v to devops-demo-dotnet")

$p1 = new-object Amazon.ElasticBeanstalk.Model.ConfigurationOptionSetting
$p1.Namespace = 'aws:autoscaling:launchconfiguration'
$p1.OptionName = 'IamInstanceProfile'
$p1.Value = 'aws-elasticbeanstalk-ec2-role'
$updatedTargetEnv = Update-EBEnvironment -EnvironmentName 'devops-demo-dotnet-dev' -VersionLabel $v -OptionSetting @($p1)
Write-Host ("deploy-to-cloud-service END: deploying version $v to environment devops-demo-dotnet-dev")
