$rules = @"
    [{   
        "Name": "Rock",
        "Symbol": "A",
        "Translation" : "X",
        "Beats": "Z",
        "Score" : 1
    },
    {
        "Name": "Paper",
        "Symbol": "B",
        "Translation": "Y",
        "Beats": "X",
        "Score": 2
    },
    {
        "Name": "Scissors",
        "Symbol": "C",
        "Translation": "Z",
        "Beats": "Y",
        "Score": 3
    }]
"@

$rules = $rules | ConvertFrom-Json  
$stragey = Get-Content -Path "..\answer_data.txt"

$totalScore = 0
$stragey | ForEach-Object {
    $myScore = 0
    $opponentMove = $_[0]
    $myMove = $_[2]

    $opp = $rules | where-object { $_.Symbol -eq $opponentMove} 
    $me = $rules | where-object { $_.Translation -eq $myMove} 

    $myScore += $me.Score

    #"== Round =="
    #"Opponent plays $($opp.Name)"
    #"I play $($me.Name)"


    $myScore +=6
    if ($opp.Translation -eq $me.Translation){
        $myScore -=3
    }

    if ($opp.Beats -eq $me.Translation){
        $myScore -=6
    } 
    $totalScore += $myScore
    #"Myscore is $myscore"
}

"Total Score is $totalScore"
   
