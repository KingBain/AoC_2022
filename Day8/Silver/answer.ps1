#$forestMap = Get-Content -Path "..\dummy_data.txt" 
$forestMap = Get-Content -Path "..\answer_data.txt" 

$treeInfo = New-Object -TypeName "System.Collections.ArrayList"
for ($y = 0; $y -lt $forestMap.count; $y++) {
    for ($x = 0; $x -lt $forestMap[0].Length; $x++) {
        $tree = New-Object -TypeName psobject
        $tree | Add-Member -MemberType NoteProperty -Name X -Value $x
        $tree | Add-Member -MemberType NoteProperty -Name Y -Value $y
        $tree | Add-Member -MemberType NoteProperty -Name Z -Value $forestMap[$y][$x]
        $tree | Add-Member -MemberType NoteProperty -Name Visible -Value $false
        $treeInfo.Add($tree) > $null
    }
}

$treeInfo = $treeInfo.ToArray()

$forest = @{
    Height = $forestMap[0].Length
    Width = $forestMap.count
    TotalTrees = $treeInfo.count
    TotalVisibleTrees = 0
}



"Scanning X axis... "
0..($forest.Height-1) | ForEach-Object {
    $row = $_
    #"Tree row $_"
    $treeRow = $treeInfo | Where-Object {$_.y -eq $row}
    $tallest = $treeRow | Sort-Object -Descending -Property Z | Select-Object -first 1 
    #$tallest.Visible = $true
    #"Tallest tree is $($tallest.Z)"

    $lastHeight = 0
    $treeRow | sort-object -Property X  | ForEach-Object {
        if ($lastHeight -lt $_.Z){
            $_.visible = $true
        }
        
        if ($_.Z -gt $lastHeight){
            $lastHeight = $_.Z
        }
    }

    $lastHeight = 0
    $treeRow | sort-object -Property X -Descending | ForEach-Object {
        if ($lastHeight -lt $_.Z){
            $_.visible = $true
        }
        
        if ($_.Z -gt $lastHeight){
            $lastHeight = $_.Z
        }
    }
}

"Scanning Y axis... "
0..($forest.Width-1) | ForEach-Object { 
    
    $col = $_
    #"Tree col $col"
    $treeCol = $treeInfo | Where-Object {$_.x -eq $col}
    $tallest = $treeCol| Sort-Object -Descending -Property Z | Select-Object -first 1 
    #$tallest.Visible = $true
    #"Tallest tree is $($tallest.Z)"
    #$treeCol

    $lastHeight = 0
    $treeCol | sort-object -Property Y | ForEach-Object {
        if ($lastHeight -lt $_.Z){
            $_.visible = $true
        }
        
        if ($_.Z -gt $lastHeight){
            $lastHeight = $_.Z
        }
    }  

    $lastHeight = 0
    $treeCol |  sort-object -Property Y -Descending | ForEach-Object {
        if ($lastHeight -lt $_.Z){
            $_.visible = $true
        }
        
        if ($_.Z -gt $lastHeight){
            $lastHeight = $_.Z
        }
    }   

}

#$treeInfo | Sort-Object -Property X,Y

$visible = $treeInfo | Where-Object {$_.Visible -eq $true}
"From the exterior a total of $($visible.count) can be see"