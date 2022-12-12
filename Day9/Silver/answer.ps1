$gameHistory = Get-Content -Path "..\dummy_data.txt"

"Woould you like to play a game ?"
$snake = [Snake]::new()


$gameHistory | ForEach-Object {
   $action = $_ -split ' '
    
   $snake.move($action[1], $action[0])
   "Snake Head is at $($snake.CurX),$($snake.CurY) "  
   "Snake Tail is at $($snake.CurTailX),$($snake.CurTailY) "  
   ""
}



class Snake{
    [int]$LastX
    [int]$LastY
    [int]$LastTailX
    [int]$LastTailY
    [int]$LastSteps = 0
    [int]$LastTailtepsS
    [string]$LastDirection = ""
    [int]$CurX = 0
    [int]$CurY = 0
    [int]$CurTailX = 0
    [int]$CurTailY = 0
    [int]$TotalHeadSteps = 0
    [int]$TotalTailSteps = 0


    [void] LastAction(){
        Write-Host "Moved $($this.LastSteps), in the $($this.LastDirection) direction"
    }


    [void] tailScan (){
        $diag = $false
        $sameX = $false
        $sameY= $false
        $touching = $false
        
        $headX = $this.CurX
        $headY = $this.CurY
        $tailX = $this.CurTailX
        $tailY = $this.CurTailY

        $dir = $this.LastDirection
        $oppDir = ''

        #are the head and the tail ontop
        if ($headX -eq $tailX -and $headY -eq $tailY){
            $touching = $true
        } else {
            $touching = $false
        }
        
        if ($headY -eq $tailY ) {$sameY =$true} 
        else {$sameY = $false}

        if ($headX -eq $tailX ) {$sameX =$true} 
        else {$sameX = $false}
        #are on the same Y
        #moving left and right
        
        if ($dir -eq 'R') {$oppDir='L'}
        if ($dir -eq 'L') {$oppDir='R'}

        
        if ($sameY) {
            $this.moveTail(1,$dir)

            write-host "move $tailX $headX "

            
        }

      
    }
    [void] Move([int]$s, [string]$d){
        $this.LastX = $this.CurX
        $this.LastY = $this.CurY
        $this.LastDirection = $d
        $this.LastSteps = $s

        1..$s |foreach-object {
            switch ( $d ) {
                R {
                    $this.CurX += 1
                    $this.tailScan()
                }    
    
                U {
                    $this.CurY += 1
                    #$this.moveTail("U")
                }
    
                L {
                    $this.CurX -= 1
                    #$this.moveTail("L")
                }
    
                D {
                    $this.CurY -= $1
                    #$this.moveTail("D")
                }
            }
        }
        

        $this.TotalHeadSteps += $s




    }

    [void] moveTail ([int]$s, [string]$d){
        $this.LastTailX = $this.CurTailX
        $this.LastTailY = $this.CurTailY

        switch ($d) {
            U {
                $this.CurTailY += $s
            }
            R {
                $this.CurTailX += $s
            }
            L {
                $this.CurTailX -= $s
            }
            D {
                $this.CurTailY -= $s
            }
        }
        $this.TotalTailSteps += $s


        #$this.LastDirection = $d
        #$this.LastSteps = $s

    }
}









