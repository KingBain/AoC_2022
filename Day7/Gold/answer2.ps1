$commandBuffer = Get-Content -Path "..\answer_data.txt"
#$commandBuffer = Get-Content -Path "..\dummy_data.txt"

$files = @{}

$dirs = @{}

$dirs["/"] = 0 
$path = ""

$commandBuffer | ForEach-Object {
    if ($_ -match "\$ cd \/") {
        $path = ""
        $path +="/"
    }


    if ($_ -match "\$ cd") {  
        switch (($_ -split " ")[2]) {
            "/" {$path ="/"}
            ".." {
                #"in $path"
                $path = $path -split "/" -ne '' | select-object -SkipLast 1 | ForEach-Object {"$_/"}         
                $path = $path -join ''
                $path = "/" + $path
                $dirs[$path] = 0 
                #"out $path"
            }
            default {
                $path+="$_/"
                $dirs[$path] = 0 
            }

        }
    }




    #if ($_ -match "dir ") {
    #    $folder = ($_ -split " " -ne '')[1]
    #    $path += "$folder/"
    #}    

    if ($_[0] -match "^\d+$") {
        #"found"
        $size = ($_ -split " " -ne '')[0]
        $filename = ($_ -split " " -ne '')[1]

        $files["$path$filename"] = $size
    }
}

$total = 0
$dirs.keys | Select-Object -Unique | Sort-Object | ForEach-Object {
    
    $pattern = $_
    #"finding file under $pattern"
    
    $dirSize =0
    $files.Keys | where-object {$_ -match $pattern} | ForEach-Object {
        
        #"$_ exists under $pattern, files size is $($files[$_])"
        $dirSize += [int]($files[$_])
        #if ($files[$_] ){

        #}
    }
    $dirs[$pattern] = $dirSize
    #"$pattern is $dirSize Large"
    #""
    #if ($dirSize -le 100000) {
       $total+=$dirSize
    #}


}

$totalDisk = 70000000
$totalUSed = $dirs["/"]
$patchSize = 30000000

$currentFreespace = $totalDisk -$totalUSed

"Current freespace is $currentFreespace"

$dirs.GetEnumerator() | sort-object -Property value | Where-Object (($currentFreespace + $_.value) -gt $patchSize) 

$dirs.GetEnumerator() | sort-object -Property value | ForEach-Object {
    if (($currentFreespace + $_.value) -gt $patchSize){
        "delete $($_.Name) would free up $($_.value)"
        break
    }
}


#$needAtleast = 

#"the Total $total"
#$files.Keys | Sort-Object