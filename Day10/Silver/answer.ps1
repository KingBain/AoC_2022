$signal = Get-Content -Path "..\dummy_data.txt" 
#$signal = Get-Content -Path "..\answer_data.txt" 

$X = 1


$queue = New-Object System.Collections.ArrayList



$cycle = 1
do {
    "++Cycle $($cycle)++"
    "X=$X"
    $count=0
    #do queue jobs
    $queue.Clone()| foreach-object {
        if ($_["STOP"] -eq $cycle){
            "Finish action, $($_["ACTION"])"
            $X = (($X),($_["ACTION"]) | Measure-Object -Sum).sum
            "$($_["ACTION"]) complete"
            $queue.RemoveAt($count) 
        }
        $count++
    }

    $job = $signal[($cycle-1)]
    if ($job -match "addx"){
        $xSig = [int](($job -split ' ')[1]) 
        "Start $xSig"
        $queue.Add(@{START = $cycle; STOP =($cycle+1); ACTION = $xSig}) > $null
        #"added job"
    }


"X=$X"
"==Cycle $($cycle)=="
""
$cycle++
}
while($cycle -lt 10)