$inventory = Get-Content -Path "..\answer_data.txt"

$calorieLoad = New-Object -TypeName 'System.Collections.ArrayList';
$roster = @{}

$counter = 1
$sum = 0 


$index = 1
$inventory | ForEach-Object {
    $sum += $_
    
    if ($_.length -eq 0 -or $inventory.Length -eq $index) {
        $roster["Elf_$counter"] = $sum
        $counter += 1
        $sum = 0
    }

    $index += 1
}

$chonky_load = 0
$chonk = ""

$roster.keys  |ForEach-Object {

    if ($roster[$_] -gt $chonky_load) {
        $chonky_load = $roster[$_]
        $chonk = $_
    }    
}

"$chonk with $chonky_load calories"