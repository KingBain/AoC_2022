#$workPlan = Get-Content -Path "..\answer_data.txt"
$workOrder = Get-Content -Path "..\answer_data.txt"

function buildStacks($stackCount) {
    $stackInventory = New-Object System.Collections.ArrayList

    #"Stacks needed $stackCount"
    1..[int][string]$stackCount| foreach-object {
        #$stackInventory.add((New-Object System.Collections.Queue)) > $null
        $stackInventory.add((New-Object System.Collections.Stack)) > $null
    }
    
    return $stackInventory
}

function populateRow($stackList){
    $row = @{}
    $stackList | Foreach-object {
        #write-host "Line $_"

        $stackColumn = 0
        $_ -split "(.{4})" -ne "" | ForEach-Object {
            if ($_ -match "\[") {
                $box = $_ -replace (" ","") -replace ("\[","") -replace ("\]","")
                $row["$stackColumn"] = $box
                #return ($stackColumn,$box)
                #write-host "Found $box box at column $stackColumn"
            }
        
            $stackColumn++
        }
    }
    #write-host "$stackList" 
Return $row

}

$count = 0 
do {
    $count++    
}while (($workOrder[$count]).length -gt 0)


$cleanNumber = $workOrder[($count-1)] -replace (" ","") | Sort-Object
$stackInShip = buildStacks -stackCount $cleanNumber[-1]

$manifest = $workOrder[($count-2)..0]
#$manifest = $workOrder[0..($count-2)] 

$manifest | ForEach-Object {
    $results =  populateRow -stackList $_
    $results.Keys | ForEach-Object {
        $stackInShip[$_].push($results[$_])
        #$stackInShip[$_].Enqueue($results[$_])
    }
}


$workOrder[($count+1)..($workOrder.count-1)] | ForEach-Object {
    
    $order = $_ -split " "

    1..($order[1]) | ForEach-Object {
        $old = $order[3] - 1
        $new = $order[5] - 1
        
        $catch = $stackInShip[$old].pop()
        $stackInShip[$new].push($catch)
        "moving $catch from position $old to position $new, action runs $($order[1]) times"

    }

}


$total = ""
$stackInShip | ForEach-Object {
    $total += $_.Peek()  
}
"top row"
$total