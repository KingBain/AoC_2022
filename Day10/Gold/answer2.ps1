#$signal = Get-Content -Path "..\dummy_data.txt" 
#$signal = Get-Content -Path "..\dummy2_data.txt" 
$signal = Get-Content -Path "..\answer_data.txt" 

$crt = New-Object System.Collections.ArrayList

for ($y = 0; $y -lt 6; $y++) {
    $row = New-Object System.Collections.ArrayList
    for ($x = 0; $x -lt 40; $x++) {
        $row.add(".") > $null
    }
    $crt.Add($row) > $null
}

$scanCount=0
$scanInterval = (40,80,120,160,200,240)

$nextJob = 0
$X=1
$count=1
$total = 0
$runningJobs = New-Object System.Collections.ArrayList

do{

    if ($runningJobs.count -eq 0 ){
        $job = $signal[$nextJob]


        if ($job -match "addx"){
            $xSig = [int](($job -split ' ')[1]) 
            #"Start $xSig"
            $runningJobs.Add(@{START = $count; STOP =($count+1); ACTION = $xSig}) > $null
        }
        $nextJob++
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


    $xxx = $count
    if ($scancount -gt 0) {
        $xxx = $xxx - $scanInterval[$scanCount-1]
    }

    if ($XXX -eq $X -or $XXX -eq ($X-1) -or $XXX -eq ($X+1)){
        $crt[$scanCount][($xxx-1)] = "#"
    }

    if (($count%40) -eq 0) {
        $scanCount++
    }


    #"X is $X"
    #"== CYCLE $count =="
    $count++
}
while ($nextJob -le $signal.Length)


$crt | foreach-object {
    "$_"

}

#for ($y = 0; $y -lt $crt.count; $y++) {
#    for ($x = 0; $x -lt $crt[0].count; $x++) {
#        "$($CRT[$y][$x])"
#    }
#}