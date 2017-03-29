---
# Welcome to Project BJC
![Magic!](http://i.imgur.com/hknf3Wx.jpg)

Here you will find instructions on how to spin up a standard Chef Demo environment in AWS or Azure, as well as instructions on how you can contribute to demo development.  This document assumes you have basic familiarity with AWS (Cloudformation and SSH keys) or Azure (ARM Templates and Resource Groups).  This project is maintained by the Solutions Architects team at Chef.  Issues, pull requests and general feedback are all welcome.  You may email us at saleseng [at] chef.io if you want to get in touch.

The talk track script for the standard demo is [located here](https://github.com/chef-cft/bjc/blob/master/SSL_Demo_Script.md)

---
## What is BJC?
---
BJC stands for Blue Jean Committee. It's also the code name for the Chef Demo project.

---
## Requirements
---
Depending on the Cloud Platform that is being deployed to, the relevant command line tools must be installed:

 - **AWS** - https://aws.amazon.com/cli/
 - **Azure** - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

---
## How do I spin up a demo?
---
#### First, setup your environment:
1. Clone this repository: `git clone https://github.com/chef-cft/bjc`
2. Change into the bjc directory: `cd bjc`

You need to configure the environment for AWS or Azure depending on what you want to deploy to.

##### AWS Credentials

Set environment variables for your AWS SSH key name and path, like so.  This must match one of the authorized ec2 ssh keys in your AWS account.
    * Put these lines into your ~/.bashrc or ~/.zshrc if you want to make them permanent.

   ```bash
   export EC2_SSH_KEY_NAME=binamov-sa
   export EC2_SSH_KEY_PATH=~/.ssh/binamov-sa.pem
   ```

##### Azure Credentials

In order to deploy to Azure you need to be logged into the subscription that the will be deployed to.

```bash
az login
```

Check that the correct subscription has been selected for deployment.

```bash
az account list -o table
```

Ensure that the subscription to be used has the `True` flag oin the `IsDefault` column.  If not then set the correct subscription, for example:

```bash
az account set --subscription <NAME OR ID OF SUBSCRIPTION>
```

#### Next, follow these steps to spin up your own dev/test environment:

##### AWS
The demo environment will provision in AWS fairly quickly, usually within a few minutes.  Once the environment is up there is a startup script you must run to prep the demo.  This script can take 10 minutes or more to complete.  Be sure to give yourself plenty of time prior to the start of your demo for the environment to spin up and for the startup script to run to completion.  We generally recommend setting up at least 30 minutes before your demo to ensure you have enough time.

1.  `git pull` to fetch the latest changes.
2.  Use the `build_demo.sh` script in the ./bin directory to stand up the latest stack in us-west-2.
    * Your command will look something like the command below.
    * Replace the demo version and other variables with your own settings:

  ```bash
  ./bin/build_demo.sh -k scarolan_sa 0.2.1 RobCo 4 'Sean Carolan' 'Solutions Architects'
  ```

3.  Log onto your stack's workstation
    * The IP is listed under your stack's outputs in the AWS CloudFormation Management Console.
    * Workstation credentials are pinned in #chef-demo-project slack channel.  
    * If you are not a Chef employee please contact saleseng@chef.io to get the username and password.

4.  Optional:  If you want to use Test Kitchen inside your demo environment, you'll need to go into the AWS control panel, select EC2, and then go into 'Key Pairs'.  Choose "Import New Key Pair" and import the chef_demo.pub file stored in this repo into the us-west-2 region of your account.  Alternatively you can simply edit the existing .kitchen.yml file inside the cookbook with any valid SSH key name in us-west-2 in your account.

5.  Run the "start me up" script on the desktop and get your demo on!
    * This is the script that can take 10+ minutes to complete.
    * Report any issues you find here:  [https://waffle.io/chef-cft/bjc](https://waffle.io/chef-cft/bjc)

##### Azure
The demo environment will spin from custom images that have been created in Azure.  The deployment will take about 30 minutes or so, but there should be no additional setup required after this initial run.  As with the AWS demo it is a good idea to ensure that this is done well in advance and for Azure we recommend allowing at least 60 minutes before the demo to ensure you have enough time.

1. `git pull` to fetch the latest changes
2. Use the `build_demo.sh` script in the `/bin` directory to stand up the stack in the `westus` region by default.
    * An example command is shown below
    * Ensure that the version and other variables are set to the required values

```bash
./bin/build_demo.sh -p azure 2.0.2 RobCo 4 'Russell Seymour' 'Solution Architects'
```

3.  Log into your demo's workstation
    * The IP is listed in the outputs of the deployment in the Portal when looking at the Resource Group
    * Workstation credentials are pinned in #chef-demo-project slack channel.  
    * If you are not a Chef employee please contact saleseng@chef.io to get the username and password.

## `build_demo.sh` Script

The script now caters for deploying to Azure so there are some changes as to the way in which it is called.

The signature of the command is now:

```bash
bin/build_demo.sh [-plrkDuh] DEMO_VERSION CUSTOMER_NAME HOURS_DEMO_RUNNING CONTACT DEPARTMENT
```

The valid options for the command are:

| Switch | Description | Default | Comments |
|--------|-------------|---------|----------|
| -p --provider | Select the Cloud Provider to deploy to | aws | |
| -r --region | Region or location to deploy to | AWS: us-west-2.  Azure: westus | |
| -l --location | Alias for `-r` | | |
| -k --key | AWS Key pair to use | | This is a required option for AWS.  (This used to be an argument) |
| -D --dryrun | Perform a dryrun to see the command(s) that will be executed | false | |
| -u --url | Base URL from which the JSON template should be retrieved | https://s3-us-west-2.amazonaws.com/bjcpublic/cloudformation | |
| -h --help | Display the help text for the script | | |

The script will check that the necessary command line tools are in installed when deploying to the specified provider.
---