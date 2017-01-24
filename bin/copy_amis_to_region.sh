#!/bin/sh
# Use this script to make Chef Demo AMIs available to other AWS regions in your account.
# It uses the version string in the AMI name to know what to copy. 

VERSION=$1
SOURCE_REGION=$2
DEST_REGION=$3
WOMBAT_LOCK=$4
USAGE="$0 1.2.11 us-east-1 us-west-2 wombat.yml" 

if [[ $# -ne 4 ]]; then
  echo $USAGE
  exit 1
fi

# Dump images into csv file
# aws ec2 describe-images --owners $ACCOUNT | jq -r ".[] | .[] | select(.Name | contains(\"-$VERSION\")) | [.Name, .ImageId] | @csv" > /tmp/awsimages.csv
grep ami- $WOMBAT_LOCK | sed 's/,//g' | sed 's/ //g' | sed 's/:/,/g' | sed 's/"//g' > /tmp/awsimages.csv

while IFS=, read NAME AMI; do
  AMINAME=$(aws ec2 describe-images --image-id $AMI --region $SOURCE_REGION | jq -r '.[] | .[] | .Name')
  echo "Copying $AMINAME $AMI from $SOURCE_REGION to $DEST_REGION..."
  aws ec2 copy-image --source-image-id $AMI --source-region $SOURCE_REGION --region $DEST_REGION --name $AMINAME
done < /tmp/awsimages.csv
