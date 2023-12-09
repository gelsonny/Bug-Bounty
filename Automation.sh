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
mkdir /home/kali/BugBounty/$1
#touch /home/kali/BugBounty/$1/$1.txt

/home/kali/BugBounty/crt.sh/crt.sh -d $1 -o ./any
#Ok

sublist3r -d $1 -o /home/kali/BugBounty/$1/sublist3r-$1.txt 
#Ok

assetfinder $1 > /home/kali/BugBounty/$1/assetfinder-$1.txt
#Ok 

subfinder -d $1 -o /home/kali/BugBounty/$1/subfinder-$1.txt
#Ok

cat /home/kali/BugBounty/$1/assetfinder-$1.txt >> /home/kali/BugBounty/$1/$1.txt
cat /home/kali/BugBounty/$1/sublist3r-$1.txt >> /home/kali/BugBounty/$1/$1.txt 
cat /home/kali/BugBounty/$1/subfinder-$1.txt >> /home/kali/BugBounty/$1/$1.txt
cat /home/kali/BugBounty/crt.sh/output/domain.$1.txt >> /home/kali/BugBounty/$1/crt-$1.txt
cat /home/kali/BugBounty/crt.sh/output/domain.$1.txt >> /home/kali/BugBounty/$1/$1.txt
sort /home/kali/BugBounty/$1/$1.txt | uniq > /home/kali/BugBounty/$1/SortedDomains-$1.txt
cat /home/kali/BugBounty/$1/SortedDomains-$1.txt | httpx-toolkit > /home/kali/BugBounty/$1/alive-$1
#httpx-toolkit -l /home/kali/BugBounty/$1/$1.txt  -p 80,443,8080,3000,9090 -status-code -title -o /home/kali/BugBounty/$1/httpx-status-code.txt

cat /home/kali/BugBounty/$1/alive-$1 | grep $1 > /home/kali/BugBounty/$1/alive-filter
cat /home/kali/BugBounty/$1/alive-filter > /home/kali/BugBounty/$1/alive-$1
rm /home/kali/BugBounty/$1/alive-filter

##Cariddi##
cat /home/kali/BugBounty/$1/alive-$1 | cariddi -e -s -rua > /home/kali/BugBounty/$1/cariddi.txt

##getAllUrls##
cat /home/kali/BugBounty/$1/alive-$1 | getallurls -o /home/kali/BugBounty/$1/getAllUrls.txt

##gospider##
mkdir /home/kali/BugBounty/$1/gospidy
touch /home/kali/BugBounty/$1/finalresults.txt

gospider -S /home/kali/BugBounty/$1/alive-$1 --sitemap -a -v -d 3 -o /home/kali/BugBounty/$1/gospidy/.

##katana##
katana -u /home/kali/BugBounty/$1/alive-$1 -jc -o /home/kali/BugBounty/$1/katana

##GetJS##
getJS --input /home/kali/BugBounty/$1/alive-$1 --complete > /home/kali/BugBounty/$1/getjs

##waybackurls##
cat /home/kali/BugBounty/$1/alive-$1 | waybackurl > /home/kali/BugBounty/$1/waybackurl

##waymore##
#python3 /home/kali/BugBounty/waymore/waymore.py -i /home/kali/BugBounty/$1/alive-$1 -f -xcc -xav -xus -l 1000 -from 2015 -oU /home/kali/BugBounty/$1/waymore.txt

sort /home/kali/BugBounty/$1/cariddi.txt | uniq >> /home/kali/BugBounty/$1/finalresults.txt
sort /home/kali/BugBounty/$1/getAllUrls.txt | uniq >> /home/kali/BugBounty/$1/finalresults.txt
sort /home/kali/BugBounty/$1/gospidy/* | uniq  >> /home/kali/BugBounty/$1/finalresults.txt
sort /home/kali/BugBounty/$1/katana | uniq >> /home/kali/BugBounty/$1/finalresults.txt
sort /home/kali/BugBounty/$1/waybackurl | uniq >> /home/kali/BugBounty/$1/finalresults.txt
sort /home/kali/BugBounty/$1/waymore.txt | uniq >> /home/kali/BugBounty/$1/finalresults.txt

cat /home/kali/BugBounty/$1/finalresults.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u > /home/kali/BugBounty/$1/final-output.txt



#to use AllForOne nuclei >> exposure scripts and jS scripts:
#find -name '*-exposure-*' -exec cp "{}" ./exposure/  \;
#https://github.com/arkadiyt/bounty-targets-data/blob/main/data/wildcards.txt
