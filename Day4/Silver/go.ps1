#Compare-Object -DifferenceObject (6) -ReferenceObject (6) -IncludeEqual
$b = Compare-Object -DifferenceObject (6) -ReferenceObject (6)



#$b = Compare-Object -DifferenceObject (2,3,4,5,6) -ReferenceObject (4,5,6,7,8)

if ($b.SideIndicator -notcontains "<=" -and $b.SideIndicator -Notcontains "=>") {" full overlap"}