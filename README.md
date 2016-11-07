---
# Welcome to Project BJC
![Magic!](http://i.imgur.com/hknf3Wx.jpg)

Here you will find instructions on how to spin up a standard Chef Demo environment in AWS, as well as instructions on how you can contribute to demo development.  This document assumes you have basic familiarity with AWS, Cloudformation, and SSH keys.

---
## What is BJC?
---
BJC stands for Blue Jean Committee. It's also the code name for the Chef Demo project.

---
## How do I spin up a demo?
---
#### First, setup your environment:
1. Clone this repository: `git clone https://github.com/chef-cft/bjc`
2. Change into the bjc directory: `cd bjc`
3. Set environment variables for your AWS SSH key name and path, like so.
    * Put these lines into your ~/.bashrc or ~/.zshrc if you want to make them permanent.

   ```bash
   export EC2_SSH_KEY_NAME=binamov-sa
   export EC2_SSH_KEY_PATH=~/.ssh/binamov-sa.pem
   ```

#### Next, follow these steps to spin up your own dev/test environment:
The demo environment will provision in AWS fairly quickly; within a few minutes.  However, there is a start-up script, which configures the demo environment, that also needs to be run.  This script can take 10 minutes or more to complete.  Be sure to give yourself plenty of time prior to the start of your demo for the environment to spin up and for the startup script to run to completion.

1.  `git pull` to fetch the latest changes.
2.  Use the `build_demo.sh` script in the ./bin directory to stand up the latest stack in us-west-2.
    * Your command will look something like the command below.
    * Replace the demo version and other variables with your own settings:

  ```bash
  ./bin/build_demo.sh 0.2.1 RobCo scarolan_sa 4 'Sean Carolan' 'Solutions Architects'
  ```

3.  Log onto your stack's workstation
    * The IP is listed under your stack's outputs in the AWS CloudFormation Management Console.
    * Workstation credentials are pinned in #chef-demo-project.

4.  Run the "start me up" script on the desktop and get your demo on!
    * This is the script that can take 10+ minutes to complete
    * Report any issues you find here:  [https://waffle.io/chef-cft/bjc](https://waffle.io/chef-cft/bjc)

---
## How do I contribute to the demo?
---
This demo is built by wrapping the wombat project cookbooks and packer templates.
You should take a little time and become familiar with wombat and how it works: [https://github.com/chef-cft/wombat](https://github.com/chef-cft/wombat)

The different parts of the project are described below:

* *Wombat:*  Wombat is a system for building standard Chef components from source code.  It is meant to be modular and used as the base for other projects, such as BJC.  The wombat project can be viewed here: https://github.com/chef-cft/wombat
* *Packer:* Packer is open source software for building standard Virtual Machine images on various platforms.  It is used in BJC (and wombat) to build Amazon AMIs for use in demos.
* *Test Kitchen:* Test kitchen configs are included with each cookbook in BJC.  These cookbooks all wrap functionality contained in the upstream Wombat project.  We build our Test Kitchen instances from a bare-bones OS.  The wombat cookbooks handle installation and basic setup, then the bjc_cookbook wrappers add extra functionality and settings appropriate for demos.
* *Fixture Cookbooks:* A fixture cookbook contains recipes that can be added to a run list during testing, but not used in production environments.  This allows Test Kitchen to mock attributes and settings that may be required.  Each bjc-cookbook has a subdirectory called `test`.  Look in the `fixtures` subdirectory to see the test recipes.  You may see these recipes in the run_list in the .kitchen.yml.

#### Prerequisites

* You can successfully spin up a BJC-based demo as outlined above
* Slack #chef-demo-project and ask to be added as a collaborator
* Setup an SSH key on your github account
  * Create a new key like this:  `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
    * Substitute your github e-mail address & make a note of the location and name of the key
  * Go here:  [https://github.com/settings/keys](https://github.com/settings/keys)
  * Select 'New SSH Key' at the top right
  * Give it a name
  * Copy the contents of the _public_ key into the 'Key' box (e.g. contents of id_rsa.pub)
  * Click 'Add SSH Key'
* Clone this repo:  `git clone git@github.com:chef-cft/wombat.git `
* Install the wombat-cli gem:  `chef gem install wombat-cli`
* Uninstall the wombat gem:  `chef gem uninstall wombat`
* Install the necessary SSL certs and keys required to build new AMIs

  Download the `keys.tar.gz` file that is pinned to the #chef-demo-project slack channel.  This tarball contains the SSL certs and keys that are required to build new AMIs with Packer and Test Kitchen.  You'll need to unpack this into six directories: the `test/fixtures/cookbooks/test/files/default` directory inside each of the bjc_automate, bjc_compliance, bjc_workstation, bjc_chef_server, bjc_infranodes, bjc_build_node cookbooks, and the packer/keys directory as well.  This only needs to be done once, and these files will be excluded from your git commits by the .gitignore file in the repository root directory. So for example, if you downloaded `keys.tar.gz` into your Downloads directory you could run the following scripticle:

  ```bash
  tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_compliance/test/fixtures/cookbooks/test/files/default/
  tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_automate/test/fixtures/cookbooks/test/files/default/
  tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_chef_server/test/fixtures/cookbooks/test/files/default/
  tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_workstation/test/fixtures/cookbooks/test/files/default/
  tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_infranodes/test/fixtures/cookbooks/test/files/default/
  tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_build_node/test/fixtures/cookbooks/test/files/default/
  tar -zxvf ~/Downloads/keys.tar.gz -C packer/keys
  ```

#### Contributing

1. Visit the waffle.io board for this repository to see all open issues [https://waffle.io/chef-cft/bjc](https://waffle.io/chef-cft/bjc)
2. Either pick an existing Kanban card or create a new one.
    * Read it and make sure you understand what you are supposed to do.
    * Ask the creator of the card if anything is not clear.
    * Once you understand what is required assign the card to yourself and move it to the 'Ready' column.
    * Once you begin work on the card you can move it to the 'In Progress' column.
3. Create a branch in which to do your work:
    * `git checkout -b scarolan/myFeatureBranch`
4. Bump the version in `wombat.yml`
5. `cd` into the cookbook you want to work on, and bump the version in its `metadata.rb`
6. Spin up a TK instance with the `kitchen converge` command.
    * The provided .kitchen.yml files inside of each cookbook should work as long as you set the environment variables for your SSH key as noted in "How to spin up a demo" above.
    * Keep in mind that some parts of the demo will not work since you only have one isolated instance in Test Kitchen.
    * *NOTE:*  If you want to test your instance in a web browser, you must put the ip address and hostname of the kitchen instance in your local /etc/hosts file.
      * Example:  `209.25.15.23  compliance.automate-demo.com`.
    * *OPTIONAL:* If you are working with the Windows workstation and wish to RDP into the TK instance, just fetch the windows Administrator password from the state file located in the `.kitchen/default-windows-2012r2.yml` file.
8. Edit the cookbooks, recipes, or attributes that built the machine.
    * Continue to test your work in test kitchen.
9. Write at least three InSpec tests to verify your assumptions.
10. Once you are reasonably certain that the target machine is getting built to the correct specification, do a `kitchen test` to build it once more from scratch.
    * Make sure everything is working before you proceed!
    * It can take up to 45 minutes to build the Windows workstation AMI.
    * Better to fail fast in Test Kitchen before you create a new image.

At this point you should have a branch, with updated cookbook(s) and attributes, and an updated version in your wombat.yml file.  The next thing you'll want to do is build a new AMI and test it with the rest of the stack.

AMIs are built using the 'wombat' CLI command (provided by the `wombat-cli` gem installed as a prerequisite).  They can be built individually or all together.

10. Build a single AMI (or group of AMIs in the case of the infrastructure [AURD] nodes):
    * `wombat build bjc-workstation` will build a new AMI for the demo workstation
    * `wombat list` will show you all of the environments that can be built
      * *NOTE:* `wombat build bjc-infranodes` will build *all* of the infranodes at once
        * The infranodes cannot currently be built individually
    * `wombat build --parallel` will build all AMIs in the environment in parallel
      * This can take up to 45 mins so test accordingly before running this!
11. Update the `wombat.lock` file by running `wombat update lock`
    * This reads the packer logs and 'locks' the AMI(s) you just created into your configuration
12. Update the `stacks/bjc-demo.json` file by running `wombat update template`
    * This creates the CloudFormation template for spinning up the demo in AWS.
13. Copy the new `stacks/bjc-demo.json` to `stacks/bjc-demo-#{version}.json`
    * Where `#{version}` is the version contained in your `wombat.yml` file.
14. Test your new environment by spinning up a demo using your version
15. Log onto the stack you just created and do manual testing
    * E.G. Try to run the demo, send a change through Automate Workflow, etc.
    * If you find things wrong, go back to step #8 and fix whatever issues you found.
16. If you things work as expected and you are happy with the change, commit your changes to your branch and push it to the remote github master repo:
    * `git add .`
    * `git commit -m "My awesome new feature"`
    * `git push origin scarolan/myFeatureBranch`
17. Go to [https://github.com/chef-cft/bjc](https://github.com/chef-cft/bjc) and submit your pull request.
    * If your change(s) are addressing specific cards in waffle, be sure to include that in your PR.
      * In the body of the PR, above all other text, include `Fixes #XXX` where `XXX` is the number of the card you are addressing.
      * If you are addressing multiple cards, put one `Fixes` line in for each card you are addressing
        *  See this [PR](https://github.com/chef-cft/bjc/pull/197) as an example
18. Bug your co-workers in #chef-demo-project to review, approve and deliver your change.
19. Now your changes to the demo are stored both as code (Chef cookbooks) and built artifacts (AMI and CloudFormation template).
