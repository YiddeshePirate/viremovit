$str = "C:\Users\eliez\Documents\virus test\Ubuntu 18.04.3 LTS amd64\WinddowsUpdateCheck\..\WinddowsUpdateCheck\WinddowsUpdater.exe"


$match = $str -replace "\\[^\\]+\\\.\.", ""

write $match


