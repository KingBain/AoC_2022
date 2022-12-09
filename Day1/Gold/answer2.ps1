#$inventory = Get-Content -Path "..\answer_data.txt"
$inventory = Get-Content -Path "..\answer_data.txt"

$roster = New-Object -TypeName 'System.Collections.ArrayList';

$counter = 1
$sum = 0 

$index = 1
$inventory | ForEach-Object {
    $sum += $_
    
    if ($_.length -eq 0 -or $inventory.Length -eq $index) {
        $roster +=
            [PSCustomObject]@{
                Name     = "Elf_$counter"
                Calories = $sum
            }

        $counter += 1
        $sum = 0
    }

    $index += 1
}


$roster | Sort-Object -Property @{ Expression="Calories"; Descending = $true } | 
    Select-Object -First 3 Calories | Measure-Object Calories -sum
