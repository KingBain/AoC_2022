$gameHistory = Get-Content -Path "..\dummy_data.txt"

"Woould you like to play a game ?"

$H = 0 
$T = 0

$L=''
$gameHistory | ForEach-Object {
   $action = $_ -split ' '
   $s = $action[1]
   $d = $action[0]
   
    if ($D -ne $L){
        "direction change"
        #$T++
    }

   "$S steps to the $D"

   $H += $S
   $T += ($S-1) 
   
    $L = $D 
}

"Total Head Moves $h"
"Total Tail moves $t "