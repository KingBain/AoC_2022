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

    #"== Round =="
    #"Opponent plays $($opp.Name)"


    #switch ($myMove) {
    #    "X" {"I need to lose"}
    #    "Y" {"I need to draw"}
    #    "Z" {"I need to win"}
    #}


    $myScore +=6
    
    if ($myMove -eq "X") {
        $me = $rules | where-object { $opp.Beats -eq $_.Translation} 
        $myScore -=6
        #"I play $($me.Name)"
    }

    if ($myMove -eq "Y") {
        $me = $rules | where-object { $_.Translation -eq $opp.Translation} 
        $myScore -=3
        #"I play $($me.Name)"
    }



    if ($myMove -eq "Z") {
        $me = $rules | where-object {$_.Beats -eq $opp.Translation} 
        #"I play $($me.Name)"
     }

     $myScore += $me.Score
     $totalScore += $myScore

}

"Total Score is $totalScore"