# "Risk" Automate Demo Script

## We’ll be playing the role of a sys admin in the bank’s IT department, acting on a 0-day vulnerability

I’m sure you’ve seen something similar in your own work: think of Heartbleed, Shellshock, or this week’s flavor of NSA leaks.

*Let me ask: If you had to identify and remediate your entire infrastructure from something like Heartbleed, how long do think it would take you today?*

For our bank in real life, a single admin was able to remediate their 2200 Chef-managed nodes in under 15 minutes. The other 50,000 or so nodes took them 150 people and 9 full work days to remediate. We're going to follow in the footsteps of that lone admin and tackle this vulnerability using Chef Automate, which is going to drastically reduce the amount of time it takes to detect and remediate.

## Let’s say we’ve just received this email giving us details of the 0-day vulnerability and how to remediate it

*How often are you asked to do this?*

With Chef Automate, our auditors will start by determining which servers are vulnerable to this attack, then we’ll write and test a remediation, and finally we’ll quickly and safely introduce the change into Production.

> Move to Demo environment: Open email from internal auditor showing vulnerability

## So where does Chef come in

First, we’ll use Chef Automate to gain insights into which servers are affected by this vulnerability. We’re using the same view our security auditors used to see that our entire production fleet are susceptible and need remediation.

*How long would this typically take you?*

> Open to Chrome, on the Node tab. Navigate to Compliance Status to show Red Donuts

## The Compliance Status tab makes it go much quicker

showing us clearly when there IS a problem in our environment; clicking on one of our servers shows us WHAT the problem is, which is that SSL 3 should not be enabled; and finally, clicking on the problem shows us exactly WHERE this problem is, **on Port 443, SSL 3 is enabled**, and how we can remediate it - **disable SSL 3 on all ports, in this case, 443**.

Our security team has pulled together this profile to act as an SSL compliance baseline for all of the nodes we manage.

> - On Compliance status tab - There is a problem.
> - Click on Delivered - See what the problem is
> - Click on Problem - See WHERE the problem is

## And now that we’ve identified the issue and the affected nodes, it’s time for us to remediate the problem

We’re simply going to open the cookbook recipe that contains this configuration and update our SSL config to be more secure.

> - Create a branch `git checkout -b remediate`
> - open the cookbook `code .`
> - navigate to `templates->default->ssl-benchmark.conf.erb`
> - uncomment lines 12 and 13
> - save file
> - Open `metadata.rb` and update version number
> - commit `git commit -am ‘promote fix for vuln’`
> - Promote to delivery `delivery review -a`
> - promote change through pipeline

## This updated cookbook is now being safely and quickly promoted into production using the continuous integration and deployment framework in Chef Automate

We’ve promoted this change, it’s being be tested against any dependencies it has, and once it’s passed through our pipeline, Chef Automate will automatically apply these configuration settings to our servers. And finally, it’ll kick off another scan of our Production systems to verify that the change we made remediated our Auditors concerns.

*Are you subject to any external or internal audits? 
How often; (quarterly, annually)? 
How would you check your machines for a vulnerability today? 
Would you write a script?)*

> Click on Review Tab in Workflow, show changes, Audit Logs, etc.

## Historically, there have been pitfalls with scripting these audits, such as handling different operating systems, how and where to maintain all these scripts, and running error-prone manual executions

We need to use a method that gives us the control to define the desired state of our systems and the flexibility to apply those definitions to our running infrastructure--and that’s Chef Automate!

With Chef Automate, we get a library of compliance profiles from the Center for Internet Security that ship out of the box, and we can easily import NIST and DISA STIG SCAP profiles, as well as Microsoft Security Center profiles!

Chef Automate uses a language called InSpec to very simply express our requirements as code in a format that’s also understandable for non-engineers; it then uses that language to scan and report back on the status of our infrastructure.

That means we have the ability to create our own profiles, use ones that come pre-loaded, or establish a standard built on a combination of both.

*Do you see any profiles here that you use or would want to use today?*

> Navigate from Viz to Compliance TAB, open the “Available” profiles tab

## Once Workflow sends our change through the pipeline, we can verify that the vulnerability has been corrected by viewing the results of our rescan

When that profile runs against those same servers, we see no vulnerabilities. Our auditors love Chef Automate because it provides them real-time insights into the compliance of our organization, and I love Chef Automate because it only took us a matter of minutes to patch an SSL vulnerability on our systems!

> Open the visibility tab, show that the machines have recently checked in and implemented the change, switch over to the compliance tab and highlight the machines are no longer vulnerable.

> Show on the scan report that the node is now compliant and passed the rule.

## So, how much time do you think this will save you from your current 0-day remediation process

> Return to Demo Solution Details slide