#$commandBuffer = Get-Content -Path "..\answer_data.txt"
$commandBuffer = Get-Content -Path "..\dummy_data.txt"

$files = @{}
$dirs = New-Object -TypeName "System.Collections.ArrayList"

$dirs.Add("/") > null 
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
                $dirs.Add($path) > null 
                #"out $path"
            }
            default {
                $path+="$_/"
                $dirs.Add($path) > null 
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
$dirs | Select-Object -Unique | Sort-Object | ForEach-Object {
    
    $pattern = $_
    #"finding file under $pattern"
    
    $dirSize =0
    $files.Keys | where-object {$_ -match $pattern} | ForEach-Object {
        
        #"$_ exists under $pattern, files size is $($files[$_])"
        $dirSize += [int]($files[$_])
        #if ($files[$_] ){

        #}
    }
    "$pattern is $dirSize Large"
    ""
    if ($dirSize -le 100000) {
        $total+=$dirSize
    }


}

"the Total $total"
#$files.Keys | Sort-Object