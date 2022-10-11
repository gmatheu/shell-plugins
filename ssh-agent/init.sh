#! /bin/sh
## # ssh-agent plugin
##
## Provides several functions and aliases to manage a single instance of a ssh-agent across
## multiple terminal instances.
##
## Requires: fzf and/or gum to provide fuzzy search


SSH_AGENT_MUTEX=~/.current_ssh_agent
SSH_HOME=$HOME/.ssh

ssh-agent-activate-current () {
  ### Activates the current ssh agent.
  echo "Activating current ssh-agent: $SSH_AGENT_PID"
  source $SSH_AGENT_MUTEX
}

ssh-agent-create () {
  ### Creates a new ssh-agent and store its environment variables into $SSH_AGENT_MUTEX
  ssh-agent > $SSH_AGENT_MUTEX
  ssh-agent-activate-current
  echo "Current ssh-agent created: $SSH_AGENT_PID"
}

ssh-agent-kill-current () {
  ### Kills current ssh agent.
  echo "Killing current ssh agent: $SSH_AGENT_PID"
  kill -9 $SSH_AGENT_PID
  unset $SSH_AGENT_PID
}

ssh-agent-list-identities () {
  echo "> Loaded Entities"
  ssh-add -l
}

ssh-agent-add-identities () {
  ssh-agent-list-identities
  echo "------------"
  find $SSH_HOME -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | gum choose --no-limit | xargs -o -I {} ssh-add $SSH_HOME/{}
}

ssh-agent-add-identity () {
  ssh-agent-list-identities
  echo "------------"
  find $SSH_HOME/ -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | fzf | xargs -o -I {} ssh-add $SSH_HOME/{}
}

alias sac=ssh-agent-activate-current
alias sal=ssh-agent-list-identities
alias saa=ssh-agent-add-identity
alias sas=ssh-agent-add-identities
alias sad=ssh-agent-remove-identity
