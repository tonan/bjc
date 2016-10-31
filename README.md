# Welcome to Project BJC

![Magic!](http://i.imgur.com/hknf3Wx.jpg)

Here you will find instructions on how to spin up a standard Chef Demo environment in AWS, as well as instructions on how you can contribute to demo development.  This document assumes you have basic familiarity with AWS, Cloudformation, and SSH keys.

### What is BJC?
BJC stands for Blue Jean Committee. It's also the code name for the Chef Demo project. The different parts of the project are described below:

Wombat - Wombat is a system for building standard Chef components from source code.  It is meant to be modular and used as the base for other projects, such as BJC.  The wombat project can be viewed here: https://github.com/chef-cft/wombat

Packer - Packer is open source software for building standard Virtual Machine images on various platforms.  It is used in BJC (and wombat) to build Amazon AMIs for use in demos.

Test Kitchen - Test kitchen configs are included with each cookbook in BJC.  These cookbooks all wrap functionality contained in the upstream Wombat project.  We build our Test Kitchen instances from a bare-bones OS.  The wombat cookbooks handle installation and basic setup, then the bjc_cookbook wrappers add extra functionality and settings appropriate for demos.

Fixture cookbooks - A fixture cookbook contains recipes that can be added to a run list during testing, but not used in production environments.  This allows Test Kitchen to mock attributes and settings that may be required.  Each bjc-cookbook has a subdirectory called `test`.  Look in the `fixtures` subdirectory to see the test recipes.  You may see these recipes in the run_list in the .kitchen.yml.

### How to I set up my dev environment?

1.  Clone this repository: `git clone https://github.com/chef-cft/bjc`
2.  Change into the bjc directory: `cd bjc`
3.  Set environment variables for your AWS SSH key name and path, like so.  Put these lines into your ~/.bashrc or ~/.zshrc if you want to make them permanent.

 ```
 export EC2_SSH_KEY_NAME=binamov-sa
 export EC2_SSH_KEY_PATH=~/.ssh/binamov-sa.pem
 ```

4.  Now you are ready to spin up demos and aid in the development effort.  Here are your yak clippers, soldier. :scissors:

### How do I spin up a demo?

Follow these steps to spin up your own dev/test environment:

1.  `git pull` to fetch the latest changes.
2.  Use the `build_demo.sh` script in the ./bin directory to stand up the latest stack in us-west-2. 🍵  Your command will look something like this.  Replace the demo version and other variables with your own settings:

  `./bin/build_demo.sh 0.2.1 RobCo scarolan_sa 4 'Sean Carolan' 'Solutions Architects'`
3.  Log onto your stack's workstation, and report any issues that you find here: https://waffle.io/chef-cft/bjc . You can find credentials for the workstation pinned in the #chef-demo-project Slack channel.

### How do I contribute to the demo?

This demo is built by wrapping the wombat project cookbooks and packer templates.
You should take a little time and become familiar with wombat and how it works: https://github.com/chef-cft/wombat

*before you begin, set yourself up with some keys*

Download the `keys.tar.gz` file that is pinned to the #chef-demo-project slack channel.  This tarball contains the SSL certs and keys that are required to build new AMIs with Packer and Test Kitchen.  You'll need to unpack this into six directories: the `test/fixtures/cookbooks/test/files/default` directory inside each of the bjc_automate, bjc_compliance, bjc_workstation, bjc_chef_server, bjc_infranodes, bjc_build_node cookbooks, and the packer/keys directory as well.  This only needs to be done once, and these files will be excluded from your git commits by the .gitignore file in the repository root directory. So for example, if you downloaded `keys.tar.gz` into your Downloads directory you could run the following scripticle:

 ```
 tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_compliance/test/fixtures/cookbooks/test/files/default/
 tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_automate/test/fixtures/cookbooks/test/files/default/
 tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_chef_server/test/fixtures/cookbooks/test/files/default/
 tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_workstation/test/fixtures/cookbooks/test/files/default/
 tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_infranodes/test/fixtures/cookbooks/test/files/default/
 tar -zxvf ~/Downloads/keys.tar.gz -C cookbooks/bjc_build_node/test/fixtures/cookbooks/test/files/default/
 tar -zxvf ~/Downloads/keys.tar.gz -C packer/keys
 ```


The basic process for contributing to this demo is as follows:

1.  Visit the waffle.io board for this repository to see all open issues: https://waffle.io/chef-cft/bjc
2.  Either pick an existing Kanban card or create a new one.  Read it and make sure you understand what you are supposed to do.  Ask the creator of the card if anything is not clear.  Once you understand what is required assign the card to yourself and move it to the 'Ready' column.  Once you begin work on the card you can move it to the 'In Progress' column.
3.  Create a branch to do your work in:
 * `git checkout -b scarolan/myFeatureBranch`
4.  Bump the version in wombat.yml
5.  `cd` into the cookbook you want to work on, and bump the version in `metadata.rb`
6.  Spin up a TK instance with the `kitchen converge` command. The provided .kitchen.yml files inside of each cookbook should work as long as you set a couple of environment variables for your SSH key.  Keep in mind that some parts of the demo will not work since you only have one isolated instance in Test Kitchen.
 * NOTE:  If you want to test your instance in a web browser, you must put the ip address and hostname of the kitchen instance in your local /etc/hosts file.  Example:  `209.25.15.23  compliance.automate-demo.com`.
7.  OPTIONAL - if you are working with the Windows workstation and wish to RDP into the TK instance, just fetch the windows Administrator password from the state file located in the .kitchen/default-windows-2012r2.yml file.
8.  Edit the cookbooks, recipes, or attributes that built the machine.  Continue to test your work in test kitchen.
9.  Write at least three InSpec tests to verify your assumptions.
10.  Once you are reasonably certain that the target machine is getting built to the correct specification, do a `kitchen test` to build it once more from scratch.  Make sure everything is working before you proceed!  It can take up to 45 minutes to build the Windows workstation AMI.  Better to fail fast in Test Kitchen before you create a new image.
11.  At this point you should have a branch, with updated cookbook(s) and attributes, and an updated version in your wombat.yml file.  The next thing you'll want to do is build a new AMI and test it with the rest of the stack.  
12.  To build a new AMI you simply run a build command like this: `./bin/wombat build bjc_workstation`.  You can also do `./bin/wombat build bjc_compliance`, etc.  If you want to build everything from source, just do `./bin/wombat build --parallel`.
13.  Once the build is done, you can run `./bin/wombat deploy`.  This will do two things.  First it fetches the latest AMIs that you built from the packer log files.  It inserts these new AMIs into your `stacks/bjc-demo.json` file.  After updating `stacks/bjc-demo.json` it spins up a stack in EC2.  At this point you should also copy the JSON to your a new versioned file name.  Example: `cp bjc-demo.json bjc-demo-1.2.3.json`
14.  Log onto the stack you just created and do manual testing (eg, try to run the demo, send a change through Automate Workflow, etc.)  If you find things wrong, go back to step #5 and fix whatever issues you found.
15.  Once you've done functional testing and verification, commit all your changes to git and push your branch to the remote github master repo:
 * `git add .`
 * `git commit -m "My awesome new feature"`
 * `git push origin scarolan/myFeatureBranch`
16.  Go to https://github.com/chef-cft/bjc and submit your pull request.
17.  Bug your co-workers in #chef-demo-project to review, approve and deliver your change.
18.  Now your changes to the demo are stored both as code (Chef cookbooks) and built artifacts (AMI and CloudFormation template).
