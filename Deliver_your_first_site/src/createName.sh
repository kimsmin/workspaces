#!/bin/bash
ctr_id=$(akamai pm lg -f json | jq -r .[0].contractIds[0])
grp_id=$(akamai pm lg -f json | jq -r .[0].groupId)

prefix=$(python3 ../src/createName.py)
p_name=$prefix'.akamai-lab.com'
eh_name=$p_name'.edgesuite.net'
echo 'Your edge hostname: '$eh_name

c_secret=$(awk '/client_secret/ {print$3}' ../credential.txt | sort -u)
host=$(awk '/host/ {print$3}' ../credential.txt | sort -u)
a_token=$(awk '/access_token/ {print$3}' ../credential.txt | sort -u)
c_token=$(awk '/client_token/ {print$3}' ../credential.txt | sort -u)

python3 ../src/createEdgehostname.py $c_secret $host $a_token $c_token $eh_name

akamai pm leh -c $ctr_id -g $grp_id -f json | jq -c --arg eh_name $eh_name '.[] | select(.edgeHostnameId == $eh_name)'