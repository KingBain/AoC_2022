$b=  @()
$grid = Get-Content -Path "..\answer_data.txt" | ForEach-Object {
#$grid = Get-Content -Path "..\dummy_data.txt" | ForEach-Object {
    $b += ,($_ -split '' -ne '' | foreach-object {[int]$_})
}
$grid = $b


$maxCol = $grid[0].length-1
$maxRow = $grid.length-1
$mostScenic = 0
$u = $l = $r = $d = 0


for ($row = 0; $row -lt $maxRow; $row++) {
    for ($col = 0; $col -lt $maxCol; $col++) {
    
    $u = $l = $r = $d = 0
    $targetHeight = $grid[$row][$col]
    
    foreach ($num in ($row-1)..0){
        if ($row -eq 0){break}
        if ($grid[$num][$col] -lt $targetHeight) {$u++}
        if ($grid[$num][$col] -ge $targetHeight) {$u++;break}
    }

    foreach ($num in ($row+1)..$maxRow){
        if ($row -eq $maxRow){break}
        if ($grid[$num][$col] -lt $targetHeight) {$d++}
        if ($grid[$num][$col] -ge $targetHeight) {$d++; break}
    }

    foreach ($num in ($col+1)..$maxCol){
        if ($col -eq $maxCol){break}
        if ($grid[$row][$num] -lt $targetHeight) {$r++}
        if ($grid[$row][$num] -ge $targetHeight) {$r++; break}
    }

    foreach ($num in ($col-1)..0){
        if ($col -eq 0){break}
        if ($grid[$row][$num] -lt $targetHeight) {$l++}
        if ($grid[$row][$num] -ge $targetHeight) {$l++; break}
    }

    $score = $u * $l * $r * $d
  
    if ($score -gt $mostScenic) {
        $mostScenic = $score
    }


    }
}

$mostScenic

