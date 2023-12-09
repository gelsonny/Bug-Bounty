#!/bin/bash

#1- crt.sh
#2-Sublist3r
#3-assetfinder
#4-subfinder
#5-cariddi
#6-getallurls
#7-gospider
#8-katana
#9-getJS
#10-waybackurl

#first step...make a directory and a file with the name of the target
mkdir ./$1
#touch /home/kali/BugBounty/$1/$1.txt

/home/BugBounty/crt.sh/crt.sh -d $1 -o ./any
#Ok

sublist3r -d $1 -o ./$1/sublist3r-$1.txt 
#Ok

assetfinder $1 > ./$1/assetfinder-$1.txt
#Ok 

subfinder -d $1 -o ./$1/subfinder-$1.txt
#Ok

cat ./$1/assetfinder-$1.txt >> ./$1/$1.txt
cat ./$1/sublist3r-$1.txt >> ./$1/$1.txt 
cat ./$1/subfinder-$1.txt >> ./$1/$1.txt
cat ./crt.sh/output/domain.$1.txt >> ./$1/crt-$1.txt
cat ./crt.sh/output/domain.$1.txt >> ./$1/$1.txt
sort ./$1/$1.txt | uniq > ./$1/SortedDomains-$1.txt
cat ./$1/SortedDomains-$1.txt | httpx-toolkit > ./$1/alive-$1
#httpx-toolkit -l /home/kali/BugBounty/$1/$1.txt  -p 80,443,8080,3000,9090 -status-code -title -o /home/kali/BugBounty/$1/httpx-status-code.txt

cat ./$1/alive-$1 | grep $1 > ./$1/alive-filter
cat ./$1/alive-filter > ./$1/alive-$1
rm ./$1/alive-filter

##Cariddi##
cat ./$1/alive-$1 | cariddi -e -s -rua > ./$1/cariddi.txt

##getAllUrls##
cat ./$1/alive-$1 | getallurls -o ./$1/getAllUrls.txt

##gospider##
mkdir ./$1/gospidy
touch ./$1/finalresults.txt

gospider -S ./$1/alive-$1 --sitemap -a -v -d 3 -o ./$1/gospidy/.

##katana##
katana -u ./$1/alive-$1 -jc -o ./$1/katana

##GetJS##
getJS --input ./$1/alive-$1 --complete > ./$1/getjs

##waybackurls##
cat ./$1/alive-$1 | waybackurl > ./$1/waybackurl

##waymore##
#python3 /home/kali/BugBounty/waymore/waymore.py -i /home/kali/BugBounty/$1/alive-$1 -f -xcc -xav -xus -l 1000 -from 2015 -oU /home/kali/BugBounty/$1/waymore.txt

sort ./$1/cariddi.txt | uniq >> ./$1/finalresults.txt
sort ./$1/getAllUrls.txt | uniq >> ./$1/finalresults.txt
sort ./$1/gospidy/* | uniq  >> ./$1/finalresults.txt
sort ./$1/katana | uniq >> ./$1/finalresults.txt
sort ./$1/waybackurl | uniq >> ./$1/finalresults.txt
sort ./$1/waymore.txt | uniq >> ./$1/finalresults.txt

cat ./$1/finalresults.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u > ./$1/final-output.txt



#to use AllForOne nuclei >> exposure scripts and jS scripts:
#find -name '*-exposure-*' -exec cp "{}" ./exposure/  \;
#https://github.com/arkadiyt/bounty-targets-data/blob/main/data/wildcards.txt
