$inventory = Get-Content -Path "..\answer_data.txt"
$offset =0
$total = 0

function get-score($char) {
    $count = 1
    97..122 + 65..90 | foreach-object {
        if ($char -ceq [char]$_) {
            return $count    
        }
        $count++   
    }
}

0..(($inventory.length/3)-1) | ForEach-Object {
  
   $chunk = (
            $inventory[$_+$offset].ToCharArray(), 
            $inventory[$_+1+$offset].ToCharArray(), 
            $inventory[$_+2+$offset].ToCharArray()
            )    
            
    $chunk[0] | Where-Object {$chunk[1] -ccontains $_} | 
        Select-Object -Unique | 
        Where-Object {$chunk[2] -ccontains $_} | 
        Select-Object -Unique |
        ForEach-Object {
            $total += get-score -char $_
        }

   $offset +=2
}

$total
