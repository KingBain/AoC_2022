$workPlan = Get-Content -Path "..\answer_data.txt"
#$workPlan = Get-Content -Path "..\dummy_data.txt"


function convertToNumberArray ($elfGroups) {
    $output = New-Object System.Collections.ArrayList

    $elfGroups -split "," | ForEach-Object {
           $num =$_ -split "-" 
           $output.add($num[0]..$num[1] ) > $null
    }
    
    #dont unroll array
    return ,$output
}

function isOverlap($pairs) {
    $pairs[0] | Where-Object {$pairs[1] -contains $_} | ForEach-Object {
        return $true
    }
    return $false
}

$count = 0 
$workPlan |ForEach-Object {
    convertToNumberArray -elfGroups $_ | ForEach-Object {
        #"first group $($_[0]), second group $($_[1])" 
        if (isOverlap -pairs $_) {
            $count++

        }
    }
}
$count