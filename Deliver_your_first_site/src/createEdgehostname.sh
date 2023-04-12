#!/bin/bash
ctr_id=$(akamai pm lg -f json | jq -r .[0].contractIds[0])
grp_id=$(akamai pm lg -f json | jq -r .[0].groupId)

prefix=$(python3 ../src/createName.py)
p_name=$prefix'.akamai-lab.com'
eh_name=$p_name'.edgesuite.net'
api_path='/papi/v1/edgehostnames?contractId='$ctr_id'&groupId='$grp_id

domainPrefix=$(echo '{
    "domainPrefix": '\"$p_name'",
    "domainSuffix": "edgesuite.net",
    "ipVersionBehavior": "IPV6_COMPLIANCE",
    "productId": "prd_Fresca"
}'  | http --auth-type edgegrid -pB -a default: :$api_path | jq -r '.domainPrefix')

edge_hostname=$(akamai pm leh -c $ctr_id -g $grp_id -f json | jq -c --arg eh_name "$eh_name" '.[] | select(.edgeHostnameDomain == $eh_name)' | jq -r '.edgeHostnameDomain')

echo '# edge hostname is created.'  
echo '# Please save these values. You will use them when you create a new property.'
echo 'property_name = '$domainPrefix  
echo 'property_hostname = '$domainPrefix
echo 'edge_hostname = '$edge_hostname