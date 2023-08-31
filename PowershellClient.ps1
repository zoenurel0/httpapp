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
$record = ($record | ConvertTo-Json)

Write-Output $record "`n"

Invoke-WebRequest -Uri "http://localhost:3000/console" -Method Post -Body $record -Headers $headers

Invoke-WebRequest -Uri "http://localhost:3000/file" -Method Post -Body $record -Headers $headers

sleep -Seconds 3

}