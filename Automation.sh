#!/bin/bash

#1- crt.sh
#2-Sublist3r
#3-assetfinder
#4-subfinder

#first step...make a directory and a file with the name of the target
mkdir /home/kali/BugBounty/$1
touch /home/kali/BugBounty/$1/$1.txt

/home/kali/BugBounty/crt.sh/crt.sh -d $1

sublist3r -d $1 -o /home/kali/BugBounty/$1/sublist-$1.txt 

assetfinder $1 > /home/kali/BugBounty/$1/assetfinder-$1.txt

subfinder -d $1 -o /home/kali/BugBounty/$1/subfinder-$1.txt

cat /home/kali/BugBounty/$1/assetfinder-$1.txt >> /home/kali/BugBounty/$1/$1.txt
cat /home/kali/BugBounty/$1/sublist-$1.txt >> /home/kali/BugBounty/$1/$1.txt 
cat /home/kali/BugBounty/$1/subfinder-$1.txt >> /home/kali/BugBounty/$1/$1.txt
cat /home/kali/BugBounty/crt.sh/output/$1.txt >> /home/kali/BugBounty/$1/$1.txt
sort /home/kali/BugBounty/$1/$1.txt | uniq > /home/kali/BugBounty/$1/SortedDomains-$1.txt
cat /home/kali/BugBounty/$1/SortedDomains-$1.txt | httpx-toolkit > /home/kali/BugBounty/$1/alive-$1



