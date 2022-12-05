$workOrder = Get-Content -Path "../answer_data.txt"

function buildEmptyStacks($stackCount) {
    $stackSpaces = New-Object System.Collections.ArrayList

    #"Stacks needed $stackCount"
    1..[int][string]$stackCount| foreach-object {
        $stackSpaces.add((New-Object System.Collections.ArrayList)) > $null
    }
    
    return $stackSpaces
}

function populateRow($stackList){
    $row = @{}
    $stackList | Foreach-object {
        $stackColumn = 0
        $_ -split "(.{4})" -ne "" | ForEach-Object {
            if ($_ -match "\[") {
                $box = $_ -replace (" ","") -replace ("\[","") -replace ("\]","")
                $row["$stackColumn"] = $box
            }
            $stackColumn++
        }
    }
    Return $row
}


$count = 0 
do {
    $count++    
}while (($workOrder[$count]).length -gt 0)


$cleanNumber = $workOrder[($count-1)] -replace (" ","") | Sort-Object

$emptyStacks = buildEmptyStacks -stackCount $cleanNumber[-1]

#$manifest = $workOrder[0..($count-2)]
$manifest = $workOrder[($count-2)..0]

$manifest | ForEach-Object {
    $results =  populateRow -stackList $_
    $results.Keys | ForEach-Object {
        $emptyStacks[$_].add($results[$_]) > $null
    }
}
$loadedStacks = $emptyStacks

$workOrder[($count+1)..($workOrder.count-1)] | ForEach-Object { 
    
    $order = $_ -split " "
    $amount = $order[1]
    $old = $order[3] - 1
    $new = $order[5] - 1


    #"Load to move $amount "
    #"before $($loadedStacks[$new])"
    #"before $($loadedStacks[$old])"

    $move = @($loadedStacks[$old] | Select-Object -last $amount)
   
    #"moving $move"

    
    $loadedStacks[$new].AddRange($move) 
    $loadedStacks[$old].RemoveRange($loadedStacks[$old].count-$amount, $amount )

    #"after $($loadedStacks[$new])"
    #"after $($loadedStacks[$old])"

#break
}

$total = ""
$loadedStacks | ForEach-Object {
    $total += @($_) |Select-Object -last 1

}

$total