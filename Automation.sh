#!/bin/bash

#1- crt.sh
#2-Sublist3r
#3-assetfinder
#4-subfinder
#5-cariddi
#6-getallurls
#7-gospider
#8-katana


#first step...make a directory and a file with the name of the target
mkdir /home/kali/BugBounty/$1
touch /home/kali/BugBounty/$1/$1.txt

/home/kali/BugBounty/crt.sh/crt.sh -d $1
#Ok

sublist3r -d $1 -o /home/kali/BugBounty/$1/sublist-$1.txt 
#Ok

assetfinder $1 > /home/kali/BugBounty/$1/assetfinder-$1.txt
#Ok 

subfinder -d $1 -o /home/kali/BugBounty/$1/subfinder-$1.txt
#Ok

cat /home/kali/BugBounty/$1/assetfinder-$1.txt >> /home/kali/BugBounty/$1/$1.txt
cat /home/kali/BugBounty/$1/sublist-$1.txt >> /home/kali/BugBounty/$1/$1.txt 
cat /home/kali/BugBounty/$1/subfinder-$1.txt >> /home/kali/BugBounty/$1/$1.txt
cat /home/kali/BugBounty/crt.sh/output/$1.txt >> /home/kali/BugBounty/$1/$1.txt
sort /home/kali/BugBounty/$1/$1.txt | uniq > /home/kali/BugBounty/$1/SortedDomains-$1.txt
cat /home/kali/BugBounty/$1/SortedDomains-$1.txt | httpx-toolkit > /home/kali/BugBounty/$1/alive-$1

##Cariddi##
cat /home/kali/BugBounty/$1/alive-$1 | cariddi -e -s -rua > /home/kali/BugBounty/$1/cariddi-$1.txt

##getAllUrls##
cat /home/kali/BugBounty/$1/alive-$1 | getallurls -o /home/kali/BugBounty/$1/getAllUrls-$1.txt

##gospider##
mkdir /home/kali/BugBounty/$1/gospidy
touch /home/kali/BugBounty/$1/finalresults.txt

gospider -S /home/kali/BugBounty/$1/alive-$1 --sitemap -a -v -d 3 -o /home/kali/BugBounty/$1/gospidy/.

##katana##
katana -u /home/kali/BugBounty/$1/alive-$1 -jc -o /home/kali/BugBounty/$1/katana-output



cat /home/kali/BugBounty/$1/cariddi-$1.txt >> finalresults.txt
cat /home/kali/BugBounty/$1/getAllUrls-$1.txt >> finalresults.txt
cat /home/kali/BugBounty/$1/gospidy/* >> finalresults.txt
cat /home/kali/BugBounty/$1/katana >> finalresult.txt'
cat cariddi-$1.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u > /home/kali/BugBounty/$1/cariddi-out.txt



