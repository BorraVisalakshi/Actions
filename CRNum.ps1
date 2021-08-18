param
(
	[Parameter(Mandatory=$true)][String]$username,
	[Parameter(Mandatory=$true)][String]$password,
	[Parameter(Mandatory=$true)][String]$crnumber
 
)

$web_client = new-object System.Net.Webclient
$web_client.Credentials = New-Object System.Net.NetworkCredential($username, $password)
$response_info = $web_client.DownloadString("https://dev94240.service-now.com/change_request.do?JSONv2&sysparm_query=number%$crnumber")
$response_json = ConvertFrom-Json $response_info
$result = $response_json.records[0].approval
echo $result
If($result -ne 'approved')
{
	$approvalException = New-Object System.Exception "CR is not Approved"
	Throw $approvalException
}
else
{
	 
	 
	 $output = Write-Output $result
	 $output | Get-Member
	 #echo 'output is' $output
	  #$out = Write-Host $output
}
