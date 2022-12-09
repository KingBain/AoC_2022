$b=  @()
$grid = Get-Content -Path "..\dummy_data.txt" | ForEach-Object {
    $b += ,($_ -split '' -ne '' | foreach-object {[int]$_})
}
$grid = $b




$maxCol = $grid[0].length-1
$maxRow = $grid.length-1
$mostScenic = 0
#for ($row = 0; $row -lt $maxRow; $row++) {
    #for ($col = 0; $col -lt $maxCol; $col++) {
        
        #$row = 1; $col = 2
        $row = 3; $col = 2
        #$row = 1; $col = 1

        $u = $l = $r = $d = 0
        #$curHeight = $grid[$row][$col]
        #"current height $curHeight"
        
        for ($i=$row;$i -lt $maxRow; $i++ ){          
            if ($i+1 -gt $maxRow) {break}

            if ($grid[$i][$col] -ge $grid[$i+1][$col]) {
                $d++
            }

            if ($grid[$i+1][$col] -ge $grid[$i][$col]) {
                $d++
                break
            }  
        }


        for ($i=$row; $i -gt 0; $i-- ){
            #"$($grid[$i-1][$col]) $($grid[$i][$col])"
            if ($i-1 -lt 0) {break}
            
            if ($grid[$i][$col] -ge $grid[$i-1][$col]){
                $u++
            }  

            if ($grid[$i-1][$col] -ge $grid[$i][$col]){
                $u++
                break
            }
        }
            
        #right
        for ($i=$col; $i -lt $maxCol; $i++){
            #$($grid[$row][$i])
            #"$($grid[$row][$i]) $($grid[$row][$i+1])"
            if ($i+1 -gt $maxCol) {break}

            if ($grid[$row][$i] -lt $grid[$row][$i+1]){
                $r++
            }
            
            if ($grid[$row][$i+1] -ge $grid[$row][$i]){
                $r++
                break
            } 
        }

        for ($i=$col; $i -gt 0; $i--) {
            #$($($grid[$row][$i]))
            #"$($grid[$row][$i]) $($grid[$row][$i-1])"
            
            if ($i-1 -lt 0) {break}
            
            if ($grid[$row][$i] -lt $grid[$row][$i-1]){
                $l++
            } 
            if ($grid[$row][$i-1] -ge $grid[$row][$i]){
                $l++
                break
            }


        }

        $score = $u * $l * $r * $d
  
        if ($score -gt $mostScenic) {
            "U $U L $L R $r D$d"
            #" Best View $row $col" 
            $mostScenic = $score
        }
    
    #}


 #}
#$mostScenic