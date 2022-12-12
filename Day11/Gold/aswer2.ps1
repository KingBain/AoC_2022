#$monkeyBuilder = Get-Content -Path "..\dummy_data.txt" 
$monkeyBuilder = Get-Content -Path "..\answer_data.txt" 

class Monkey{
    [object]$Items
    [bool]$OperationMulti = $true
    [int]$OperationValue
    [int]$TestValue
    [int]$TestTrue
    [int]$TestFalse
    [int]$InspectionCount = 0

    [void] InspectItems(){
        $itemCounter = 0
        ($this.Items).clone() | ForEach-Object {

            $this.InspectionCount++
            #write-host "big number $_"
            $oppValue = ''
            if ($this.OperationValue -eq -1){
                #write-host "here"
                $oppValue = [bigint]$_
                
            } else {
                $oppValue = $this.OperationValue
            }
            
            if ($this.OperationMulti) {
                [int64]$new = [int64]$_ * [int64]$oppValue
            } else {
                [int64]$new = [int64]$_ + [int64]$oppValue
            }
                  
            #this is the magi right here, its the LCM for all the monkeys
            [int64]$new = [int64]($new % $lcm)


            if ($new % $this.TestValue -eq 0){
                ($tree[$this.TestTrue]).Items.add($new) > $null
            } else {
                ($tree[$this.TestFalse]).Items.add($new) > $null
            }

        #write-host ("Item contains $($this.Items.count) items")
        ($this.Items).RemoveAt(0)
        #write-host ("Remove Item at $itemCounter")
        #write-host ("Item contains $($this.Items.count) items now")
        $itemCounter++   
        }
    }
}

function lcm($String){
    $array=@()
    [System.Double]$product=1
    $Numbers = $String.Split(",")
    foreach ($Number in $Numbers) {
        $sqrt=[math]::sqrt($number)
        $Factor=2
        $count=0
        while ( ($Number % $Factor) -eq 0) {
            $count+=1
            $Number=$Number/$Factor
            if (($array | Where-Object {$_ -eq $Factor}).count -lt $count) {
                $array+=$Factor
            }
        }
        $count=0
        $Factor=3
        while ($Factor -le $sqrt) {
            while ( ($Number % $Factor) -eq 0) {
                $count+=1
                $Number=$Number/$Factor
                if (($array | Where-Object {$_ -eq $Factor}).count -lt $count) {
                    $array+=$Factor
                    }
                }           
            $Factor+=2
            $count=0
        }
        if ($array -notcontains $Number) {
            $array+=$Number
        }
    }
    foreach($arra in $array) {$product = $product * $arra}
    return $product
}

$tree = New-Object System.Collections.ArrayList
$monkeyBuilder | ForEach-Object {
    if ($_[0] -eq "M") {
        $m = [Monkey]::new()
    } 
    if ($_[2] -eq "S" -and $m) {
        [System.Collections.ArrayList]$m.Items = @($_ -replace '\,','' -split ' ' | Select-Object -Skip 4)
    } 
    if ($_[2] -eq "O") {
        $opp = $_ -split ' '
        if ($opp[6] -eq '+' -and $m){
            $m.OperationMulti = $false
        }
        if (($opp | Select-Object -last 1) -eq "old"){
            $m.OperationValue = -1
        } else{
            $m.OperationValue = $opp | Select-Object -last 1
        }
    } 
    if ($_[2] -eq "T" -and $m) {
        $m.TestValue = $_ -split ' ' | select-object -Last 1
    } 
    if ($_[8] -eq "r")  {
        $m.TestTrue = $_ -split ' ' | select-object -Last 1
    } 
    if ($_[8] -eq "a") {
        $m.TestFalse = $_ -split ' ' | select-object -Last 1
        $tree.Add($m) > $null
    }  
}

$lcm = lcm -string ([string]$tree.TestValue -replace (' ',','))

$rounds = 10000

1..$rounds | ForEach-Object {
    "Round $_"
    $tree | ForEach-Object {
        $_.InspectItems()
    }
}

0..($tree.count-1) | ForEach-Object {
    "Monkey $_ inspected items $($tree[$_].InspectionCount ) times."
}
$score = $tree.InspectionCount | Sort-Object -Descending | Select-Object -First 2


"Total Monkey Business $($score[0] * $score[1])"
