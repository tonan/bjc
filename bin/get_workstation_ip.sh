#!/bin/sh
# Usage and help
USAGE="Usage: $0 STACKNAME"

if [[ $# -ne 1 ]]; then
  echo $USAGE
  exit 1
fi

NAME=$1
aws cloudformation describe-stacks --stack-name $NAME | jq '.[] | .[] | .Outputs'
