$forestMap = Get-Content -Path "..\dummy_data.txt"
#$forestMap = Get-Content -Path "..\answer_data.txt" 

#$totalTrees = 0

#"the forest is $($forest[0].Length) wide and $($forest.count) long"

#$totalTrees += (($forest[0].Length)*2 + ($forest.count*2)-4)
#"from the outside edges a total of $totalTrees can be see"

function treesOnAxis($X, $Y) {
    $b = $treeInfo | Where-Object {$_.Y -eq $Y -or $_.X -eq $X -and $_.Visible -eq $false } 
    return $b
}

function treesOnAxis2($X, $Y) {
    $toa = New-Object -TypeName "System.Collections.ArrayList"
   
    foreach($tr in $treeInfo)
    {
        if ($tr.Y -eq $Y -or $tr.X -eq $X -and $tr.Visible -eq $false){
            $toa.Add($tr) > $null
        }

    }

    return $toa
}

$treeInfo = New-Object -TypeName "System.Collections.ArrayList"
for ($y = 0; $y -lt $forestMap.count; $y++) {
    for ($x = 0; $x -lt $forestMap[0].Length; $x++) {
        
        $tree = New-Object -TypeName psobject
        $tree | Add-Member -MemberType NoteProperty -Name X -Value $x
        $tree | Add-Member -MemberType NoteProperty -Name Y -Value $y
        $tree | Add-Member -MemberType NoteProperty -Name Height -Value $forestMap[$y][$x]
        $tree | Add-Member -MemberType NoteProperty -Name Visible -Value $false
        $treeInfo.Add($tree) > $null
    }
}

$forest = @{
    Height = $forestMap[0].Length
    Width = $forestMap.count
    TotalTrees = $treeInfo.count
    TotalVisibleTrees = 0
}


"The forest is $($forest.Width) wide, $($forest.Height) high, with $($forest.TotalTrees) total amount of trees"
"Begin checking height ..."
pause
#exterior edges
#$treeInfo | Where-Object {$_.X -eq 0 -or $_.X -eq ($forest.Height-1) } | foreach-object {$_.Visible = $true}
#$treeInfo | Where-Object {$_.Y -eq 0 -or $_.Y -eq ($forest.Width-1) } | foreach-object {$_.Visible = $true}

$count=1
$treeInfo.GetEnumerator() | ForEach-Object {
    $target = $_

    if ($count%10 -eq 0){
        "Rount $count"
    }
    #"Scanning Tree $count at $($target.X),$($target.Y) with height $($target.height)"

    #$treesOnAxis  = $treeInfo | Where-Object {$_.Y -eq $target.Y -or $_.X -eq $target.X}
    
    $trees = treesOnAxis2 -Y $target.Y -X $target.X

    #top
    $trees | Where-Object {$_.Y -lt $target.Y -and $_.X -eq $target.X } | Foreach-object {
        if ($target.Height -gt $_.height) {
            $target.Visible = $true
        }

    }

    $trees | Where-Object {$_.Y -gt $target.Y -and $_.X -eq $target.X } | Foreach-object {
        if ($target.Height -gt $_.height) {
            $target.Visible = $true
        }
    
    }
    
    #left
    $trees | Where-Object {$_.Y -eq $target.Y -and $_.X -lt $target.X } | Foreach-object {
        if ($target.Height -gt $_.height) {
            $target.Visible = $true
        }
    
    }
    
    #right
    $trees | Where-Object {$_.Y -eq $target.Y -and $_.X -gt $target.X } | Foreach-object {
        if ($target.Height -gt $_.height) {
            $target.Visible = $true
        }
    
    }

$count++
}


#$target = $treeInfo | Where-Object {$_.Y -eq 1 -and $_.X -eq 1 }

#"Target"
#$target 
#""



$visible = $treeInfo | Where-Object {$_.Visible -eq $true}
"From the exterior a total of $($visible.count) can be see"