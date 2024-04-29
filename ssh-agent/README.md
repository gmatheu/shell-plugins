 # ssh-agent plugin

 Provides several functions and aliases to manage a single instance of a ssh-agent across
 multiple terminal instances.

 Requires: fzf and/or gum to provide fuzzy search


## Functions

### ssh_agent_activate_current 
   Activates the current ssh agent.

### ssh_agent_list 
   List existing agents

### ssh_agent_create 
   Creates a new ssh-agent and store its environment variables into $SSH_AGENT_MUTEX

### ssh_agent_kill_current 
   Kills current ssh agent.


## Aliases

* *ssh-agent-create*: ssh_agent_create
* *sac*: ssh_agent_activate_current
* *sal*: ssh_agent_list_identities
* *saa*: ssh_agent_add_identity
* *sas*: ssh_agent_add_identities
* *sad*: ssh_agent_remove_identity
