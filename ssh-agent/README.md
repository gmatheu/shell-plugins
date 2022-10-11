 # ssh-agent plugin

 Provides several functions and aliases to manage a single instance of a ssh-agent across
 multiple terminal instances.

 Requires: fzf and/or gum to provide fuzzy search


## Functions

### ssh-agent-activate-current 
   Activates the current ssh agent.

### ssh-agent-create 
   Creates a new ssh-agent and store its environment variables into $SSH_AGENT_MUTEX

### ssh-agent-kill-current 
   Kills current ssh agent.


## Aliases

* *sac*: ssh-agent-activate-current
* *sal*: ssh-agent-list-identities
* *saa*: ssh-agent-add-identity
* *sas*: ssh-agent-add-identities
* *sad*: ssh-agent-remove-identity
