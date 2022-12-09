$forestMap = Get-Content -Path "..\dummy_data.txt" 
#$forestMap = Get-Content -Path "..\answer_data.txt" 

$treeInfo = New-Object -TypeName "System.Collections.ArrayList"
for ($y = 0; $y -lt $forestMap.count; $y++) {
    for ($x = 0; $x -lt $forestMap[0].Length; $x++) {
        $tree = New-Object -TypeName psobject
        $tree | Add-Member -MemberType NoteProperty -Name X -Value $x
        $tree | Add-Member -MemberType NoteProperty -Name Y -Value $y
        $tree | Add-Member -MemberType NoteProperty -Name Z -Value $forestMap[$y][$x]
        $tree | Add-Member -MemberType NoteProperty -Name Visible -Value $false
        $tree | Add-Member -MemberType NoteProperty -Name View @{Up=0 ; Left=0; Right=0; Down=0  }
        $tree | Add-Member -MemberType NoteProperty -Name Score -Value 1
        $treeInfo.Add($tree) > $null
    }
}

$treeInfo = $treeInfo.ToArray()

$count=1
$treeInfo | foreach-object {
    "Tree #$count"
    $count++
    $target= $_

    #$target = $treeinfo | where-object {$_.X -eq 2 -and $_.y -eq 1}

    #"up"
    foreach ($tree in $treeInfo){
        if ($tree.y -lt $target.y -and $tree.x -eq $target.x){
            $target.View["up"]++
            if ($tree.z -ge $target.Z){
                break
            }
        }
    }

    #"left"
    foreach ($tree in ($treeInfo | sort-object -Property X -Descending)){
        if ($tree.y -eq $target.y -and $tree.x -lt $target.x){
            $target.View["left"]++
            if ($tree.z -ge $target.Z){
                continue
            } 
                
            
        }
    }

    #"right"
    foreach ($tree in ($treeInfo | sort-object -Property X )){
        if ($tree.y -eq $target.y -and $tree.x -gt $target.x){
            $target.View["right"]++
            if ($tree.z -ge $target.Z){
                continue
            } 
                
            
        }
    }

    #"down"
    foreach ($tree in $treeInfo){
        if ($tree.y -gt $target.y -and $tree.x -eq $target.x){
            $target.View["down"]++
            if ($tree.z -ge $target.Z){
                break
            }          
        }
    }

    $b = 1
    $target.View.Keys | ForEach-Object {
        if ($target.View[$_] -ne 0) {
            $b = $b * $target.View[$_]
        } 
        
    } 

    $target.Score = $b
    $target.Score

}

"Total Trees $count"


$treeInfo | Sort-Object -Property Score -Descending | Select-Object -first 3 -property Score