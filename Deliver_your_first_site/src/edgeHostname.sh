# /bin/bash
ctr_id=$(akamai pm lg -f json | jq -r .[0].contractIds[0])
grp_id=$(akamai pm lg -f json | jq -r .[0].groupId)

prefix=$(python3 ../src/createName.py)
p_name=$prefix'.akamai-lab.com'
eh_name=$p_name'.edgesuite.net'
api_path='/papi/v1/edgehostnames?contractId='$ctr_id'&groupId='$grp_id
echo 'edge hostname= '$eh_name

echo '{
    "domainPrefix": '\"$prefix'",
    "domainSuffix": "edgesuite.net",
    "ipVersionBehavior": "IPV6_COMPLIANCE",
    "productId": "prd_Fresca"
}'  | http --auth-type edgegrid -pHhBb -a default: :$api_path 