$workPlan = Get-Content -Path "..\answer_data.txt"
#$workPlan = Get-Content -Path "..\dummy_data.txt"


function convertToNumberArray ($elfGroups) {
    $output = New-Object System.Collections.ArrayList

    $elfGroups -split "," | ForEach-Object {
           $num =$_ -split "-" 
           $output.add($num[0]..$num[1] ) > $null
    }
    
    #returned functions automatically unroll arrays, use unary
    return ,$output
}

function isRussianDoll ($dolls) {
    
    if ($dolls[0].length -eq $dolls[1].length ) {
        $compare = Compare-Object -DifferenceObject $dolls[1] -ReferenceObject $dolls[0] -IncludeEqual
        if ($compare.SideIndicator -notcontains "<=" -and $compare.SideIndicator -Notcontains "=>") {return $true}
    }
    
    if ($dolls[0].length -gt $dolls[1].length ) {
        $compare = Compare-Object -DifferenceObject $dolls[1] -ReferenceObject $dolls[0]
    } else {
        $compare = Compare-Object -DifferenceObject $dolls[0] -ReferenceObject $dolls[1]
    }
   
    if ($compare.SideIndicator -contains "<=" -and $compare.SideIndicator -Notcontains "=>") {
        return $true
    }
    return $false
}

$row = 1
$count = 0 
$workPlan | ForEach-Object {
    convertToNumberArray -elfGroups $_ | ForEach-Object {
        #"first group $($_[0]), second group $($_[1])" 
        if (isRussianDoll -dolls $_) {
            #"row found $row"
            #"first group $($_[0]), second group $($_[1])" 
            $count++
        
        }
    }
    $row++
}

$count