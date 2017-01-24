#!/bin/sh
# Use this script to make Chef Demo AMIs available to other AWS accounts.
# Simply run the script with the CF template file and account you want to publish to as arguments.

JSON=$1
ACCOUNT=$2
USAGE="$0 chef-demo.json 1234567890" 

if [[ $# -ne 2 ]]; then
  echo $USAGE
  exit 1
fi

function addAMIPermission {
  IMAGEID=$1
  ACCOUNT=$2
  aws ec2 modify-image-attribute --image-id $IMAGEID --launch-permission "{\"Add\": [{\"UserId\":\"$ACCOUNT\"}]}"
}

for ami in $(cat $JSON | jq -r '.Parameters | .[] | .[]' | grep ami-); do
  echo "Publishing $ami to account $ACCOUNT"
  addAMIPermission $ami $ACCOUNT
done
