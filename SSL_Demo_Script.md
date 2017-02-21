**This script is designed to be used with the Chef Automate Demo Tech Deck.**  

Notations in red below refer to the specific slide numbers within that deck.

Talk track is in **Bold**

Setup steps:

1. Spin up a new demo environment

2. Log onto the workstation and run the ‘start me up’ script

3. Open the web browser.  (You might have to do "Bookmarks >> Show Bookmarks Bar" to show the bookmarks bar)

4. Right click to open all the tabs in the ‘Chef’ folder and the ‘Planet Express’ folder.

5. Begin your demo with the "Planet Express" delivered website open in our browser.

First, refer to the companion deck slide #2 and introduce CHEF Automate.  

Our persona here is a system administrator who works at Planet Express, a web based company that sells framed photos from the NASA archives. In addition to the primary workstation-1 user, there are four other users who you can log in as, all using the same password.  Those usernames are:
`phil` - Sysadmin, chef engineer, has superadmin
`leela` - App developer, chef engineer, has superadmin
`hubert` - Release manager, has superadmin
`amy` - Security lead, has read-only access

**Our security team have implemented a new compliance profile that requires all web-facing applications to use only the latest SSL ciphers.  The PCI/DSS (****Payment Card Industry Data Security Standard) group have mandated that companies must use TLS 1.2 or newer to be PCI-compliant. ****You may have seen something similar in your own world. Think of Heartbleed, Shellshock or whatever the critical issue happens to be this week. You need to be able to move fast and remediate your systems, without fear of breaking the application.**

**We’ll first use Chef Automate’s Visibility feature to determine which servers fail the policy.  We then use Test Kitchen and Chef Automate to model and test our remediation, followed by quickly and safely introducing the change into Production.  Let's begin by diving into Visibility.**

Within the Chrome browser, start with the Visibility main page.  Take a moment to show the high level dashboard and the data being presented:

**Visibility allows us to answer the kinds of questions a Site Reliability Engineer or an Operations engineer would ask when operating complex infrastructure at scale.**

**For instance, this is the high level dashboard:**

* **The bottom half of the screen shows changes introduced by the Automate Workflow feature**

* **The top right hand corner shows the current number of changes in process**

* **The top left corner shows the number of cookbooks recently updated as well as changes delivered into Production**

Drill into the Visibility Node view.

**We are now looking at an overview screen of how the nodes in our estate, across our Chef Servers and Chef Organizations are converging.  With this view we can quickly understand:**

* **The total number of nodes and how many are either succeeding or failing their chef-client runs**

* **Recent changes delivered**

* **A trend graph with specifics on when changes were delivered as well as failures/successes**

* **_We will look at more of these features later in the demo_**

Drill into the Compliance Status view inside of Automate.  

**Let’s head over to the Compliance Status view where we can get an overview of our systems and compliance levels.  Our compliance scans automatically run during every chef-client run.  These scans can also be executed manually.**

**Here, we can quickly see that all of our staging and production environments are failing the SSL profile check.  Drilling in, we get a summary view of the specific Compliance control we have failed.  Note that while some of the tests pass, we are still using older or insecure versions of SSL on our web app.  Let’s take a close look at the tests to see what’s failing.**

Within visibility, you can simply scroll down to the compliance profile results and expand any of the four nodes in the list.  You will see one critical control, namely ssl v3 still being enabled.  Why is SSLv3 bad?  Read this link if you want to know more:

https://blog.qualys.com/ssllabs/2014/10/15/ssl-3-is-dead-killed-by-the-poodle-attack

**This particular profile checks to see that we are only using the latest secure implementation of TLS v1.2 to secure our website.  This could enable an attacker to perform a man in the middle attack and steal user’s personal information or credit card numbers.  Not good!**

Now go back and show the library of all policies available.  This is also a good time to introduce the compliance dashboard.

**To get you started, we’ve included a series of policies for you to leverage out of the box.  For instance, you can see policies based on the Center for Internet Security standards.**

Select the Basic SSH Security policy and expand one of the controls listed.

**You can also use other examples we’ve included such as Basic SSH.  We’re providing more policies with every release of Automate.**

Refer to the companion deck slides #3 - 7 (w/speaker notes): explain Compliance as code slides.



**Explain that compliance scans happen automatically at every stage of the software development lifecycle.  From a simple dev VM all the way out to production, every single machine gets a compliance and config audit scan every time chef runs.**

Minimize the Chrome browser, switching to the terminal. 

Refer to the companion deck slides 8 (w/speaker notes): explain Test Kitchen.**
**
Run `kitchen converge` then `kitchen verify` and explain that your local development environment reflects the same compliance issue.

**With Test Kitchen, we’ll spin up a server instance in Amazon and apply the cookbook that created our Planet Express server.  We’ll then execute our compliance check to collect instant feedback using the newly mandated security standard.  ****Now, looking at the Test Kitchen output, **** ****we can see that our freshly built webserver is indeed failing the new policy and we’ll need to write and test our remediation.** 

**But first, how does Chef help us define our Infrastructure as code?**

Refer to the companion deck slide 9 (w/speaker notes): explain Infrastructure as Code which includes Chef Config Mgmt 101 information.

Start the development process for remediation by creating a new branch in Git: `git checkout -b fixSSL`

**Because we're able to treat our Infrastructure as Code, we're storing and sharing our automation cookbook in source control.**

**Therefore, the first thing we need to do is isolate our code changes. This allows us to version control our infrastructure (at the folder and file level), and with CHEF Automate eventually submit it for Peer Review.**

Switch to Visual Studio Code (VSC). You can open VSC by simply running `code .` inside the bjc-ecommerce cookbook.  Open the `metadata.rb` and bump the version of the cookbook. Save the file. 

**In addition to the file level version control, Chef provides the ability to version our cookbooks signalling to our peers (and Chef Server) that something has changed.  We should practice good hygiene and bump the version of the cookbook as well. This is done through making a simple change to the cookbook metadata file.**

_OPTIONAL: Click on the Git icon on the left menu of Visual Studio Code. Click on the metadata.rb file and show the diff. Explain the benefits of source control and Infrastructure as Code. Switch back to the file browser in VSC._

Expand the templates directory and expand the default directory. Open the `default-ssl.conf.erb` file.  Near the top of the file there are some commented out lines.  Remove the # symbol from the beginning of each line to enable more secure SSL settings.  Save the file.

**When we look in the default cookbook recipe we can see how our webserver’s apache configuration is being managed. We see here that this template resource is managing the apache SSL configuration settings.  After some Googling around and reading the Apache documentation, we found the config settings for disabling SSLv3.  Those new settings are here in the Apache SSL config file.**


Switch back to the terminal. Run `kitchen converge` followed by `kitchen verify` again to verify your changes. 

**Now that we have our remediation written, we can test it on the instance we launched earlier. When we launch Test Kitchen again, it will re-run our compliance check, and report back success or failure. This is really important. By getting this instant feedback we can be sure that our changes work as expected.  See how we are now passing all our compliance checks, AND we managed to not break the web app in the process.**

The compliance check should not fail in test kitchen. Commit your changes by doing one of the following:

In the terminal run: `git commit -am "fix SSL settings"`

_OR OPTIONALLY: Switch to VSC. Click on Git in the left menu. Type the commit message “fix httpd.conf file” in the message box. Hit ctrl-enter to commit the changes._

**To quickly recap: we’ve created a version control branch to capture our work, made changes in our cookbook, and then tested them. Now ****we**** can commit our changes, in order to share and Peer Review our updated cookbook.**

**But with testing complete, how do we introduce the change into production quickly and safely?  This is where the Workflow feature comes in.  With this command line call, our change is submitted.**

In the terminal, submit the changes to Workflow for review by typing: `delivery review`

Refer to the companion deck slide 10-11 (w/speaker notes):

**- First** "One Path for Change" slide, that the way change moves through our organization is fixed.  

**- Second** "One Path for Change" slide, introducing Phases and the Human Gates

Chrome will open a new tab, and should come in focus. Workflow will kick off the VERIFY Stage followed by Peer Review approval.  The VERIFY Stage typically takes 2m 30s to run.

**Within CHEF Automate, the Workflow feature has taken over and immediately executes predefined tests on the changes I submitted. ****We can drill down into the first stage, called VERIFY, and see the types of tests being executed along with the results:**

**- LINT Phase: **Runs tools that analyze your source code to identify stylistic problems (e.g., Rubocop and Foodcritic).

**- SYNTAX Phase: **Runs tools to confirm that the code can be parsed and, if applicable, that it compiles (e.g., knife cookbook utility)

**- UNIT Phase: **Runs unit tests (e.g., ChefSpec which tests resources and recipes as part of a simulated chef-client run.)


Select a file and show line level commenting by clicking a line number and adding a comment. If present in your session, have your Sales lead perform this step.

_OPTIONAL: Copy the Journey video url from the Youtube tab that is open in Chrome and add it to your comment. Click Add Comment. Show how you can have fun while reviewing code._

**Chef**** ****Workflow supports a human gate to Peer Review changes. Peers can drill down into the individual ****files**** that were changed, and see a diff between the old file and the new. You can also do fun things like embed gifs, and youtube videos and emoticons are also supported.**

Click Finish Review and then click Approve. The BUILD Stage typically takes 2 minutes to run.

Refer to the companion deck slides 12-13


**Once our Peer Reviewer is happy and clicks Approve, Chef Workflow merges the change into the pipeline’s target branch and proceeds to the BUILD stage.  The BUILD stage repeats the LINT, SYNTAX, and UNIT Phases again. This is because the target branch may have moved ahead (this occurs if there are multiple open changes on a project and another change is approved before yours).**

**The remaining three Phases are now executed including the:**

**- QUALITY Phase: **Execution of additional code analysis tools (usually specific to your application).

**- SECURITY Phase: **Execution of additional security code analysis tools (such as Checkmarx or Brakeman which scans uncompiled code for security issues.)

**- PUBLISH Phase: **Produces potentially releasable artifacts made available to the rest of the pipeline.

**We now have an artifact that has been built for Production. In this case, our artifact is a cookbook which is Published to a Chef Server and our Private Supermarket.**

Click and select the ACCEPTANCE Stage view in the demo environment.  The ACCEPTANCE Stage typically takes under 2 minutes to run.

**Beginning with the ACCEPTANCE stage, Automate begins verifying the cookbook that was produced in the previous Stage. The goal of the ACCEPTANCE stage is for the team to make a decision about whether the change should proceed to production or not. There are four phases executed:**

**- PROVISION phase: **Provision infrastructure needed to test the cookbook (or artifacts in the case of applications).  Automate can provision against public and private clouds or this Phase.  In addition, you can use Docker containers as well.  You can customize based on the type of change being introduced into Production (e.g., infrastructure or application).

**- DEPLOY phase: **Deploy the cookbook to the infrastructure that has been set aside for testing.

**- SMOKE phase: **Short-running tests that verify the resulting system passes minimal health checks.

**- FUNCTIONAL phase: **Tests that give you confidence that the system is meeting its business requirements - this could include UAT and other manual tests.  This phase can also execute your compliance checks to ensure the correct level of security compliance.  This means you find out if there are compliance issues with the introduced change as quickly as possible.

**As with all checks performed by Chef Automate, the intent is to identify problems as early and quickly as possible.**

Once the ACCEPTANCE Stage has passed, click Deliver (this is a great opportunity to have the Customer, if in the room, to click the Deliver button).

**Now that we have passed ACCEPTANCE, we have the option to deploy our change through the final stages.  When our Product Owner (or Release Manager) is happy with the release and clicks Deliver, our change proceeds into the UNION Stage.**

Use the companion deck slide 14 (w/speaker notes) to explain what happens inside the UNION, REHEARSAL, and DELIVERED stages.

The Phases in Union and the remaining stages in the pipeline are now the same: provision, deploy, smoke, and functional.


**As you can see within the UI, our change is working through the final three Stages.  Each Stage applies the same provision, deploy, smoke, and functional phases of testing described previously.**

**While our changes are getting tested in the final Stages, let’s take a look at what’s going on in our entire Chef ecosystem. With Automate's Visibility feature, we get a unified view of the infrastructure fleet being managed by Chef and all the ongoing changes delivered by Workflow.**

Go to the Nodes tab in Chrome and click on the Compliance tab

**Visibility allows us to answer the kinds of questions an SRE or an Ops person (a Site Reliability Engineer or an Operations engineer) would ask when operating complex infrastructure at scale:**

**From simple questions, like, how many changes have we delivered, in this example, the past twelve hours?**

Mouse over and show the 1 under changes delivered

**or how many nodes do I have in my Union Environment?**

Drop down the environments dropdown and select union

**To more involved questions:**

**- Let's say we identified a cookbook for review. How many nodes are affected by that ****cookbook****?  Or, how many systems were impacted by the changes delivered by the Workflow feature?**

Click on the search bar, mouse over the pretty dropdown tooltips, and begin typing `cookbook:` after which you can backspace the search

**- All those workflow tests run on Build Nodes, do we have enough of those?**

Mouseover the 3 in the active build nodes

- **Are there instances in my infrastructure that are failing to adhere to policy - failing converges?**

Mouseover/click the (hopefully zero) failed nodes aggregator

- **Visibility captures all events from all of your infrastructure for live analysis, and also further review. Visibility has a concept of a data-tap, where data can be shipped to your 3-rd party preferred tools like Splunk, Power BI, and others for deeper analysis, retention, and further reporting.**


Acceptance, Union, Rehearsal and Delivered all automatically get the updated code.  You can hit refresh on the Compliance tab to show the checkmarks turning green in real time.

**Now that the change has been fully delivered let’s look at our compliance dashboard.  Note that all our environments are now showing a green status checkmark indicating that they are fully compliant with our new SSL profile.  **

There’s no longer any need to scan anything manually.  You can simply point out the results of the automated compliance checks at each stage.

Show on the scan report that the node is now compliant and passed the rule.


Use the companion deck slide 15 (w/speaker notes) to summarize and end demo

