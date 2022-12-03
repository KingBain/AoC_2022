$inventory = Get-Content -Path "..\answer_data.txt"
$total = 0

$inventory | ForEach-Object {
    $sackSize =$_.length
    $comparmentSize = $sackSize/2

    $comp1 = ($_[0..($comparmentSize-1)])
    $comp2 = ($_[$comparmentSize..$_.length])


    $comp1 | Where-Object {$comp2 -ccontains $_} | Select-Object -First 1 | ForEach-Object {
        $duplicate = $_
        $count = 1

        97..122 + 65..90 | foreach-object {
            if ($duplicate -ceq [char]$_) {
                $total += $count    
            }
            $count++   
        }

    }
}

$total