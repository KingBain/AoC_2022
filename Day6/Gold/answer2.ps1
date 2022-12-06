$patternWidth = 14
$buffer = Get-Content -Path "..\answer_data.txt"

#$buffer -split "(.{$patternWidth})" -ne '' | foreach-object {
#    "$_" | Select-Object -Unique
#}

$index = 0
$buffer.ToCharArray() | ForEach-Object {
    $slot = $($buffer[($index)..($index+($patternWidth-1))])
    #"anaylzing $_ at position $index"
    #"next $($patternWidth-1) packets $slot"
    
    $results = $slot | Group-Object | Where-Object {$_.count -gt 1}
    
    if (-not $results){
        "found start of marker at $($index+$patternWidth)"
        break
    }

$index ++
}