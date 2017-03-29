#!/bin/bash
# Builds Chef Demo environment with a Cloudformation template

# VARIABLES -------------------------------------------
# Default variables that will be used in the script
# Cloud Platform to deploy to
CLOUD_PROVIDER="aws"

# Key pair to use in AWS
SSH_KEY=""

# Base URl to use which holds the necessary templates
BASE_URL="https://s3-us-west-2.amazonaws.com/bjcpublic/cloudformation"

# Ensure the parameters array is empty
PARAMETERS=()
ARG_COUNT=0
DRY_RUN=0

# ----------------------------------------------------

# FUNCTIONS ------------------------------------------

function usage()
{

  COMMAND=$1

  # create help text to display the usage
  help_text="$(cat <<EOF
  Usage: ${COMMAND} [-plrkDuh] DEMO_VERSION CUSTOMER_NAME HOURS_DEMO_RUNNING CONTACT DEPARTMENT

  Options:
     -k --key       - SSH Key Pair to use in AWS
     -p --platform  - Cloud platform to use.  Either 'aws' or 'azure'.  Default: aws
     -r --region    - Location or region to deploy to.  Defaults:  AWS = us-west-2, AZURE = westus
     -l --location  - Alias for -r switch
     -D --dryrun    - Dry run to check that the command that will be run
     -u --url       - Base URL from which to get the template. Default: ${BASE_URL}
     -h --help      - Display this help

  Options MUST be specified before the required arguments
EOF
)"

  echo "$help_text"
}

function executeCmd()
{
  localcmd=$1

  # If Dry Run has been specified then just output the command
  if [ $DRY_RUN -eq 1 ]
  then
    echo $localcmd
  else

    # Execute the command
    eval $localcmd
  fi

}

# ----------------------------------------------------

# Configure the options for the script
while [[ $# -gt 0 ]]
do

  key="$1"

  case $key in 

    # Select the cloud platform
    -p|--provider)
      shift
      CLOUD_PROVIDER=`echo $1 | tr '[:upper:]' '[:lower:]'`
    ;;

    # Specify the location to deploy into
    -l|--location)
      shift
      REGION=$1
    ;;

    -r|--region)
      shift
      REGION=$1
    ;;

    -h|--help)
      usage $0
      exit 1
    ;;

    -k|--key)
      shift
      SSH_KEY=$1
    ;;

    -D|--dryrun)
      DRY_RUN=1
    ;;

    # Any extra parameters that have been set assign to the correct variables
    *)

      PARAMETERS[ARG_COUNT]="$1"

      let ARG_COUNT++

    ;;
  esac

  shift
done

# Create the necessary variables from the PARAMETERS array
VERSION=${PARAMETERS[0]}
CUSTOMER=${PARAMETERS[1]}
CUSTOMER="${CUSTOMER// /-}"
TTL=${PARAMETERS[2]}
CONTACT="${PARAMETERS[3]}"
DEPARTMENT=${PARAMETERS[4]}

# Ensure that all the necessary information has been provided
if [ "X$VERSION" == "X" ] ||
   [  "X$CUSTOMER" == "X" ] ||
   [  "X$TTL" == "X" ] ||
   [  "X$CONTACT" == "X" ] ||
   [  "X$DEPARTMENT" == "X" ]
then

  echo -e "Some required parameters are missing.  Please ensure that all are provided.\n\n"
  usage $0

  exit 2
fi

# Determine the termination date
TERMINATION_DATE="$(TZ=Etc/UTC date -j -v +${TTL}H +'%Y-%m-%dT%H:%M:%SZ')"

# Determine the name of the stack
STACK_NAME=$(printf "%s-%s-Chef-Demo-$(TZ=Etc/UTC date +'%Y%m%dT%H%M%SZ')" ${CONTACT// /-} ${CUSTOMER})

# Based on the cloud provider set the region default
case $CLOUD_PROVIDER in
  aws)
    REGION="${REGION:-us-west-2}"

    # Ensure that the SSH_KEY has been specified
    if [ "X$SSH_KEY" == "X" ]
    then
      echo -e "An SSH Key Pair must been specified using the -k option when deploying to AWS\n\n"
      usage $0
      exit 3
    fi

    # Ensure that the aws command is available
    if ! hash aws 2>/dev/null
    then
      echo "Please ensure that the AWS command line tools are installed"

      # only exit if this is not a dry run
      if [ $DRY_RUN -eq 0 ]
      then
        exit 4
      fi
    fi

    # Build up the command to run to deploy the cloud formation template
    cmdparts=()
    cmdparts[0]=$(printf 'aws cloudformation create-stack')
    cmdparts[1]=$(printf ' --stack-name "%s"' $STACK_NAME)
    cmdparts[2]=$(printf ' --region %s', $REGION)
    cmdparts[3]=$(printf ' --tags Key=TTL,Value=%s Key=X-Contact,Value="%s" Key=X-Dept,Value="%s" Key=X-Project,Value="%s" Key=X-Termination-Date,Value="%s"' $TTL "$CONTACT" "$DEPARTMENT" "$CUSTOMER" $TERMINATION_DATE)
    cmdparts[4]=$(printf ' --template-url %s/bjc-demo-aws-%s.json' $BASE_URL $VERSION)
    cmdparts[5]=$(printf ' --parameters ParameterKey=KeyName,ParameterValue=%s ParameterKey=TTL,ParameterValue=%s' $SSH_KEY $TTL)
    
    # Join the cmdparts together to get the overall command
    cmd="${cmdparts[@]}"

    executeCmd "$cmd"

  ;;
  azure)
    REGION="${REGION:-westus}"

    # Ensure that the az command is installed
    if ! hash az 2>/dev/null
    then
      echo "Please ensure that Azure CLI 2.0 command line tools are installed"
      echo -e "   https://docs.microsoft.com/en-us/cli/azure/install-azure-cli\n\n"

      # only exit if this is not a dry run
      if [ $DRY_RUN -eq 0 ]
      then
        exit 4
      fi
    fi

    # Build up the command to create the necessary resource group for the deployment
    cmdparts=()
    cmdparts[0]=$(printf 'az group create')
    cmdparts[1]=$(printf ' -l "%s"' $REGION)
    cmdparts[2]=$(printf ' -n "%s"' $STACK_NAME)
    cmdparts[3]=$(printf ' --tags TTL=%s X-Contact="%s" X-Dept="%s" X-Project="%s" X-Termination-Date="%s"' $TTL "$CONTACT" "$DEPARTMENT" "$CUSTOMER" $TERMINATION_DATE)

    cmd="${cmdparts[@]}"
    executeCmd "$cmd"

    # Create the command to perform the deployment
    cmdparts=()
    cmdparts[0]=$(printf 'az group deployment create')
    cmdparts[1]=$(printf ' -g "%s"' $STACK_NAME)
    cmdparts[2]=$(printf ' --template-uri %s/bjc-demo-azure-%s.json' $BASE_URL $VERSION)

    cmd="${cmdparts[@]}"
    executeCmd "$cmd"
  ;;
esac

