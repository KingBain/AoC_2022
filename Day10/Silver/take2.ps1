#$signal = Get-Content -Path "..\dummy_data.txt" 
#$signal = Get-Content -Path "..\dummy2_data.txt" 
$signal = Get-Content -Path "..\answer_data.txt" 

$scanInterval = (20,60,100,140,180,220)

$nextJob = 0
$X=1
$count=1
$total = 0
$runningJobs = New-Object System.Collections.ArrayList

do{
    "++ CYCLE $count ++"
    "X is $X"

    if ($runningJobs.count -eq 0 ){
        $job = $signal[$nextJob]


        if ($job -match "addx"){
            $xSig = [int](($job -split ' ')[1]) 
            #"Start $xSig"
            $runningJobs.Add(@{START = $count; STOP =($count+1); ACTION = $xSig}) > $null
        }
        $nextJob++
    }


    if ($scanInterval -contains $count){
        $total += ($count * $X)
    }


    $t=0
    $runningJobs.Clone()| foreach-object {
        if ($_["STOP"] -eq $count){
            $X = (($X),($_["ACTION"]) | Measure-Object -Sum).sum
            #"$($_["ACTION"]) complete"
            $runningJobs.RemoveAt($t) 
        }
        $t++
    }



    "X is $X"
    "== CYCLE $count =="
    $count++
}
while ($nextJob -le $signal.Length)

"Total $total"