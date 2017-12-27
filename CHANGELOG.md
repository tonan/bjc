# Change Log

## 4.2.0

**Updates:**
- Added MVP Windows wrapper profile to repo, and updated workstation recipe to upload.
- Moved initial CCR to user_data in the cfn json. The start_demo script now waits for machines to register, and runs a second CCR via push jobs.
- Minor release due to change in default instance types and launch behavior. Should be non-impacting to demo workflows.

**Closed Issues:**
- [\#632](https://github.com/chef-cft/bjc/issues/632) - *enhancement* - Updated json template to use m4/c4 instances instead of m3/c3. Should slightly improve performance, and reduce instance costs.
- [\#634]((https://github.com/chef-cft/bjc/issues/634) - *enhancement* - Updated DCA launch scripts to speed up demo prep. No longer spins up TK by default (can be turned on by uncommenting in Start_DCA), and makes use of powershell parallelization to speed up re-bootstrap of nodes.

## 4.1.0

**Closed Issues:**
- [\#627](https://github.com/chef-cft/bjc/issues/627) - *enhancement* - Added CHANGELOG.md to project to better track development history.
- [\#625](https://github.com/chef-cft/bjc/issues/625) - *bug* - Unexpected audit errors persist after DCA_Correct script. Solved by introducing version pinnings to wrapper profile.
- [\#618](https://github.com/chef-cft/bjc/issues/618) - *enhancement* - Added inspec wrapper profile to /profiles directory in project, and archive/upload in Start_DCA script. Replaces previous implementation of pulling a static profile via cookbook files.
- [\#628](https://github.com/chef-cft/bjc/issues/627) - *enhancement* - Added powershell function to combine the functionality of Update-RunLists and Invoke-ChefClient to streamline demonstrations.
