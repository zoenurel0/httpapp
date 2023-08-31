#Source:  <https://github.com/jdorfman/awesome-json-datasets>

$datasource = 'https://www.govtrack.us/api/v2/role?current=true&role_type=senator'

$headers =@{
'Content-Type' = 'application/json'
}

#Get raw dataset from Web
$returnData = Invoke-WebRequest -Uri $datasource -Headers $headers -Method Get

#Convert data to object we can work with
$wholeObject = $returnData.Content | ConvertFrom-Json


foreach ($record in $wholeObject.objects){

#Write-Output $record "`n"

"Name:{0}, Party:{1}, Phone:{2}, State:{3} `n" -f $($record.person.name),$($record.party),$($record.phone),$($record.state)


$record = ($record | ConvertTo-Json)


$return = Invoke-WebRequest -Uri "http://localhost:3000/console" -Method Post -Body $record -Headers $headers
"Status to console: $($return.StatusCode) `n" 


$return = Invoke-WebRequest -Uri "http://localhost:3000/file" -Method Post -Body $record -Headers $headers
"Status to file: $($return.StatusCode) `n`n`n" 

sleep -Seconds 3

}