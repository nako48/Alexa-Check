#!/bin/bash
check(){
curl=$(curl -s "http://data.alexa.com/data?cli=10&dat=snbamz&url=$1" -L)
grank=$(echo $curl | grep -Po '(?<=TEXT=")[^"]*')
irank=$(echo $curl | grep -Po '(?<=RANK=")[^"]*' | head -2 | tail -1)
country=$(echo $curl | grep -Po '(?<=NAME=")[^"]*')
if [[ $curl =~ "404" ]]; then
printf "NOT FOUND CHECK\n"
else
printf "=================================\n"
printf "Result Site : $1
Rank Global : $grank
Rank Country $country : $irank\n"
echo "=================================
Result Site : $1
Rank Global : $grank
Rank Country $country : $irank
=================================" >> hasil.txt
fi
}
header
echo ""
echo "List In This Directory : "
ls
echo -n "Masukan File List : "
read list
if [ ! -f $list ]; then
	echo "$list No Such File"
	exit
fi
x=$(gawk '{ print $1 }' $list)
IFS=$'\r\n' GLOBIGNORE='*' command eval  'site=($x)'
for (( i = 0; i < "${#site[@]}"; i++ )); do
	url="${site[$i]}"
	check $url
done