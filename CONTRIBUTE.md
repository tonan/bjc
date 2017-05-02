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
  * Create a new key like this if you don't have one already:  `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
    * Substitute your github e-mail address & make a note of the location and name of the key
  * Go here:  [https://github.com/settings/keys](https://github.com/settings/keys)
  * Select 'New SSH Key' at the top right
  * Give it a name
  * Copy the contents of the _public_ key into the 'Key' box (e.g. contents of id_rsa.pub)
  * Click 'Add SSH Key'
* Clone this repo:  `git clone git@github.com:chef-cft/wombat.git `
* Install the wombat-cli gem:  `chef gem install wombat-cli`
* Uninstall the wombat gem (this is a *different* wombat project than ours!):  `chef gem uninstall wombat`
* Install the necessary SSL certs and keys required to build new AMIs.  See below:

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

0. Contributors need to clone the project directly from our delivery server.  We do not commit code directly to github, rather we send it through our Workflow pipeline instead.  The easiest way to do this is just rename or delete your existing `bjc` repo and clone it fresh from the new Opsworks Automate server.  See #chef-demo-project for help getting an account. https://bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io
1. Visit the waffle.io board for this repository to see all open issues [https://waffle.io/chef-cft/bjc](https://waffle.io/chef-cft/bjc)
2. Either pick an existing Kanban card or create a new one.
    * Read it and make sure you understand what you are supposed to do.
    * Ask the creator of the card if anything is not clear.
    * Once you understand what is required assign the card to yourself and move it to the 'Ready' column.
    * Once you begin work on the card you can move it to the 'In Progress' column.
3. Create a branch in which to do your work:
    * `git checkout -b scarolan/myFeatureBranch`
4. Bump the version in `wombat.yml`.
5. `cd` into the first cookbook you want to work on, and bump the version in its `metadata.rb`
6. Spin up a TK instance with the `kitchen converge` command.
    * The provided .kitchen.yml files inside of each cookbook should work as long as you set the environment variables for your SSH key as noted in "How to spin up a demo" above.
    * Keep in mind that some parts of the demo will not work since you only have one isolated instance in Test Kitchen.
    * *NOTE:*  If you want to test your instance in a web browser, you must put the ip address and hostname of the kitchen instance in your local /etc/hosts file.
      * Example:  `209.25.15.23  compliance.automate-demo.com`.
    * *OPTIONAL:* If you are working with the Windows workstation and wish to RDP into the TK instance, just fetch the windows Administrator password from the state file located in the `.kitchen/default-windows-2012r2.yml` file.
8. Edit the cookbooks, recipes, or attributes that built the machine.
    * Continue to test your work in test kitchen.
9. Write some InSpec tests to verify your assumptions.  Run `kitchen verify` to make sure they work.
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
16. If you things work as expected and you are happy with the change, commit your changes to your local branch and run a `delivery review` command to send your changes to the pipeline.
    * Protip: Go to your new PR in waffle.io and add a `Fixes` line in for each card you are addressing
      *  See this [PR](https://github.com/chef-cft/bjc/pull/197) as an example
17. Bug your co-workers in #chef-demo-project to review, approve and deliver your change.
18. Now your changes to the demo are stored both as code (Chef cookbooks) and built artifacts (AMI and CloudFormation template).

##### Special instructions for updating the "payload" cookbooks such as bjc-ecommerce.

If you need to update the content of the bjc-ecommerce cookbook or any other cookbooks that are *part of the demo*, there are some extra steps you need to take.  The reason for this is we want to have a clean history inside the demo and have the cookbook properly synced with the Automate server in the demo.  Here are the steps for updating bjc-ecommerce or other cookbooks:

1. Build and test all your changes in test kitchen as usual.
2. Spin up a demo and make all the exact same changes inside the demo.  Probably easiest to just copy/paste whatever work you did into the demo.
3.  Push your change all the way through the demo to the 'delivered' stage.
4.  On the workstation, `git checkout master` and `git pull` to sync back from the Automate server.  Now you are ready to zip up your changes.
5.  Go into the cookbook and look for the .git directory.  It might be hidden.  If it is enable 'show hidden files' in the file explorer.  Right click it and do "Send to >> Compressed file".  Name the file git_dir.zip.  You'll need to get this file off the workstation and into the files/default directory in the bjc-ecommerce cookbook.
6.  Log onto the automate server.  You simply `ssh automate` and `sudo /bin/su - root` from the workstation.  Now that you have a root prompt run the following:  `automate-ctl create-backup`.  This will generate a new backup file in /var/opt/delivery/backups.  It will have a long name with a timestamp.  Take that file and rename it simply `chef-automate-backup.zst`.  Put that file into the files/default directory in the bjc_automate cookbook.  This restores the backup so the automate server comes up in the correct state with all data and accounts.  IMPORTANT - don't forget to update the checksum for this file in the default recipe of the bjc_automate cookbook.  You need to use the sha256sum command on the backup file to generate a new checksum and update the bjc_automate::default recipe with the new checksum. 
7. If you made changes to Compliance (eg certs) ssh into it `ssh compliance` take a backup of it too, and place/overwrite the resulting file into bjc_compliance/files/default: `sudo -u chef-pgsql /opt/chef-compliance/embedded/bin/pg_dump -c chef_compliance > compliance_backup.sql `
8.  Commit your changes into the pipeline above as usual.  Now when your demo is built it will download the latest cookbook code from our github repo, but you'll still have all the git and delivery data baked in as well.

