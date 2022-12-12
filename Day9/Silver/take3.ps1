$gameHistory = Get-Content -Path "..\dummy_data.txt"

#       X,Y
$grid = @(1,1)
$he= @(0,0)

"$grid   "

$gameHistory | ForEach-Object {
    $action = $_ -split ' '
    $s = $action[1]
    $d = $action[0]

    #"$S steps to the $D"

    if ("R" -eq  $D){
        $he[0] += $S
    }

    if ("U" -eq  $D){
        $he[1] += $S
    }

    if ("L" -eq  $D){
        $he[0] -= $S
    }

    if ("D" -eq  $D){
        $he[1] -= $S
    }

    if ($he[0] -gt $grid[0]){
        $grid[0] = $he[0]
    }

    if ($he[1] -gt $grid[1]){
        $grid[1] = $he[1]
    }

}

$grid